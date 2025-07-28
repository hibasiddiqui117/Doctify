# 🩺 Doctify - RAG-based AI Health Assistant Chatbot

Doctify is an intelligent Retrieval-Augmented Generation (RAG) powered AI chatbot that predicts **diseases**, suggests **medications**, recommends **remedies**, lists **precautions**, and advises the appropriate **doctor/specialist**—all based on user-inputted **symptoms** in natural language.

---

## 🔍 Features

- 🤖 **LLM-Powered Symptom Analysis**  
  Utilizes large language models to interpret and understand user symptoms.

- 📚 **RAG (Retrieval-Augmented Generation)**  
  Enhances response accuracy by combining external medical knowledge with LLM predictions.

- 💊 **AI-Powered Diagnosis**  
  Predicts probable diseases and recommends relevant medications and home remedies.

- ⚠️ **Precautionary Measures**  
  Offers personalized health precautions based on the predicted diagnosis.

- 🧑‍⚕️ **Specialist Recommendation**  
  Suggests the right type of medical specialist or doctor to consult.

---

## 🛠️ Tools & Technologies

- **Backend**: Python, Flask
- **AI Models**: Hugging Face Transformers, Sentence Transformers, LangChain
- **Vector Search**: FAISS
- **Database**: SQLAlchemy, PyODBC
- **APIs**: OpenAI, Hugging Face
- **Others**: dotenv, Pydantic, Scikit-learn, Pandas, TQDM

---

## 🧪 Dependencies

> Listed in `requirements.txt`. Major dependencies include:

- `Flask`
- `langchain`
- `sentence-transformers`
- `faiss-cpu`
- `transformers`
- `torch`
- `scikit-learn`
- `pydantic`
- `SQLAlchemy`
- `python-dotenv`

To install all dependencies, run:

```bash
pip install -r requirements.txt
