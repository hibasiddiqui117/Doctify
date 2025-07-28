import os
import time
import pyodbc
from typing import List, Dict, Any
from collections import Counter
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_community.vectorstores import FAISS
from langchain.docstore.document import Document
from transformers import pipeline
from backend.config import Config
import logging
from functools import lru_cache

# Configure logging
logging.basicConfig(level=logging.WARNING)
logger = logging.getLogger(__name__)

class LLMHandler:
    def __init__(self, use_local_index=True):
        self.use_local_index = use_local_index
        self.index_path = os.path.join("backend", "static", "data", "medical_faiss_index")
        
        try:
            self.embedding_model = HuggingFaceEmbeddings(
                model_name="sentence-transformers/all-MiniLM-L6-v2",
                model_kwargs={'device': 'cpu'},
                encode_kwargs={'normalize_embeddings': True}
            )
            self.vectorstore = self._initialize_vectorstore()
            self.symptom_disease_map = self._load_symptom_disease_mapping()
            logger.info("LLMHandler initialized successfully")
        except Exception as e:
            logger.error(f"Initialization failed: {str(e)}")
            raise

    @lru_cache(maxsize=1)
    def _load_symptom_disease_mapping(self) -> Dict[str, List[str]]:
        conn = None
        try:
            conn = self.get_db_connection()
            cursor = conn.cursor()
            cursor.execute("""
                SELECT LOWER(TRIM(s.SymptomName)), d.DiseaseName
                FROM Diagnosis di
                JOIN Disease d ON di.DiseaseID = d.DiseaseID
                CROSS APPLY STRING_SPLIT(REPLACE(di.Notes, ',', ' '), ' ') AS tokens
                JOIN Symptom s ON LOWER(TRIM(tokens.value)) = LOWER(TRIM(s.SymptomName))
                WHERE di.IsFinalDiagnosis = 1
                GROUP BY LOWER(TRIM(s.SymptomName)), d.DiseaseName
            """)
            mapping = {}
            for symptom, disease in cursor.fetchall():
                if symptom not in mapping:
                    mapping[symptom] = []
                mapping[symptom].append(disease)
            if not mapping:
                return self._get_fallback_mappings()
            logger.info(f"Loaded {len(mapping)} symptom-disease pairs")
            return mapping
        except pyodbc.Error as e:
            logger.warning(f"Using fallback mappings due to DB error: {str(e)}")
            return self._get_fallback_mappings()
        finally:
            if conn:
                conn.close()

    def _get_fallback_mappings(self) -> Dict[str, List[str]]:
        return {
            "fever": ["influenza", "common cold"],
            "cough": ["bronchitis", "pneumonia"],
            "headache": ["migraine"],
            "chest pain": ["heart disease"],
            "nausea": ["gastritis"]
        }

    def _handle_unknown_case(self, symptoms: List[str]) -> Dict[str, Any]:
        return {
            "condition": "UNKNOWN",
            "confidence": 0,
            "message": "No matching diagnosis found",
            "symptoms": symptoms
        }

    def get_db_connection(self):
        conn_str = (
            f"DRIVER={{{Config.DB_DRIVER}}};"
            f"SERVER={Config.DB_SERVER};"
            f"DATABASE={Config.DB_DATABASE};"
            f"Trusted_Connection={Config.DB_TRUSTED_CONNECTION};"
        )
        return pyodbc.connect(conn_str, timeout=10)

    def _initialize_vectorstore(self) -> FAISS:
        if not os.path.exists(self.index_path):
            raise FileNotFoundError(f"FAISS index not found at {self.index_path}")
        return FAISS.load_local(
            self.index_path, 
            self.embedding_model, 
            allow_dangerous_deserialization=True
        )

    def diagnose_from_symptoms(self, symptoms: List[str], k: int = 3) -> Dict[str, Any]:
        if not symptoms:
            return self._handle_unknown_case([])
        symptoms = [s.lower().strip() for s in symptoms]
        try:
            potential_diseases = []
            for symptom in symptoms:
                potential_diseases.extend(self.symptom_disease_map.get(symptom, []))
            docs = self.vectorstore.similarity_search(" ".join(symptoms), k=k)
            disease_counts = Counter()
            for doc in docs:
                disease = doc.metadata.get('disease')
                if disease and (not potential_diseases or disease in potential_diseases):
                    disease_counts[disease] += 1
            if not disease_counts:
                return self._handle_unknown_case(symptoms)
            top_disease = disease_counts.most_common(1)[0][0]
            return {
                "condition": top_disease,
                "confidence": min(100, disease_counts[top_disease] * 100 // k),
                "context": self._get_diagnosis_context(top_disease, docs)
            }
        except Exception as e:
            logger.error(f"Diagnosis failed: {str(e)}")
            return self._handle_unknown_case(symptoms)

    def _get_diagnosis_context(self, disease: str, docs: List[Document]) -> Dict[str, Any]:
        context = {
            "medications": set(),
            "precautions": set(),
            "remedies": set(),
            "doctors": self._get_relevant_doctors(disease)
        }
        for doc in docs[:3]:
            if doc.metadata.get('disease') == disease:
                content = doc.page_content.lower()
                if "medication:" in content:
                    meds = content.split("medication:")[1].split(".")[0].strip()
                    if meds:
                        context["medications"].update(
                            m.strip().capitalize() for m in meds.split(","))
                if "precaution:" in content:
                    precs = content.split("precaution:")[1].split(".")[0].strip()
                    if precs:
                        context["precautions"].update(
                            p.strip().capitalize() for p in precs.split(","))
                if "remedy:" in content:
                    rems = content.split("remedy:")[1].split(".")[0].strip()
                    if rems:
                        context["remedies"].update(
                            r.strip().capitalize() for r in rems.split(","))
        context["medications"] = list(context["medications"])[:5]
        context["precautions"] = list(context["precautions"])[:5]
        context["remedies"] = list(context["remedies"])[:5]
        return context

    def _get_relevant_doctors(self, disease: str) -> List[Dict]:
        """Get relevant doctors with full details based on disease/specialty match."""
        conn = None
        try:
            conn = self.get_db_connection()
            cursor = conn.cursor()
            cursor.execute("""
                SELECT TOP 3 
                    d.DoctorID, 
                    d.FirstName + ' ' + d.LastName AS Name,
                    ds.SpecialtyID,
                    s.SpecialtyName,
                    d.YearsOfExperience,
                    d.Rating,
                    c.ClinicName,
                    c.Address,
                    c.City,
                    c.Phone,
                    dc.ConsultationFee,
                    dc.FollowUpFee,
                    da.DayOfWeek,
                    da.StartTime,
                    da.EndTime
                FROM Doctor d
                JOIN DoctorSpecialtyMapping ds ON d.DoctorID = ds.DoctorID
                JOIN DoctorSpecialty s ON ds.SpecialtyID = s.SpecialtyID
                JOIN DoctorClinic dc ON d.DoctorID = dc.DoctorID
                JOIN Clinic c ON dc.ClinicID = c.ClinicID
                JOIN DoctorAvailability da ON dc.DoctorClinicID = da.DoctorClinicID
                WHERE s.SpecialtyName LIKE ?
                ORDER BY d.Rating DESC, d.YearsOfExperience DESC
            """, (f"%{disease}%",))
            columns = [column[0] for column in cursor.description]
            return [dict(zip(columns, row)) for row in cursor.fetchall()]
        except Exception as e:
            logger.error(f"Doctor search failed: {str(e)}")
            return []
        finally:
            if conn:
                conn.close()

    def _get_day_name(self, day_num: int) -> str:
        days = ["Monday", "Tuesday", "Wednesday", "Thursday", 
                "Friday", "Saturday", "Sunday"]
        return days[day_num - 1] if 1 <= day_num <= 7 else "Unknown"
