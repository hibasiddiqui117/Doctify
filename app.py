from flask import Flask, request, jsonify, render_template, redirect, url_for, session, flash
from flask_cors import CORS
from werkzeug.security import generate_password_hash, check_password_hash
from backend.llm.llm_integration import LLMHandler
from backend.config import Config
from datetime import datetime
import logging
import os
import pyodbc
import re

app = Flask(__name__, template_folder='templates', static_folder='static')
CORS(app)

# Then modify the secret key configuration:
app.secret_key = os.environ.get('SECRET_KEY') or 'your-development-secret-key'

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Initialize LLM Handler
llm_handler = LLMHandler(use_local_index=True)

def get_db_connection():
    """Establish connection to SQL Server database"""
    try:
        connection_string = f"""
            DRIVER={{{Config.DB_DRIVER}}};
            SERVER={Config.DB_SERVER};
            DATABASE={Config.DB_DATABASE};
            Trusted_Connection={Config.DB_TRUSTED_CONNECTION};
        """
        return pyodbc.connect(connection_string)
    except Exception as e:
        logger.error(f"Database connection error: {str(e)}")
        return None

# Common Data (unchanged)
COMMON_SYMPTOMS = [
    {"name": "Fever", "icon": "fas fa-temperature-high", "category": "General"},
    {"name": "Headache", "icon": "fas fa-head-side-virus", "category": "Neurological"},
    {"name": "Cough", "icon": "fas fa-lungs-virus", "category": "Respiratory"},
    {"name": "Fatigue", "icon": "fas fa-bed", "category": "General"},
    {"name": "Nausea", "icon": "fas fa-stomach", "category": "Digestive"},
    {"name": "Dizziness", "icon": "fas fa-dizzy", "category": "Neurological"},
    {"name": "Chest Pain", "icon": "fas fa-heartbeat", "category": "Cardiac"},
    {"name": "Shortness of Breath", "icon": "fas fa-wind", "category": "Respiratory"},
    {"name": "Abdominal Pain", "icon": "fas fa-stomach-pain", "category": "Digestive"},
    {"name": "Joint Pain", "icon": "fas fa-bone", "category": "Musculoskeletal"},
    {"name": "Sore Throat", "icon": "fas fa-comment-medical", "category": "ENT"},
    {"name": "Rash", "icon": "fas fa-allergies", "category": "Dermatological"}
]

COMMON_CONDITIONS = [
    {"name": "Common Cold", "icon": "fas fa-snowflake", "specialty": "General Physician"},
    {"name": "Flu", "icon": "fas fa-virus", "specialty": "Infectious Disease"},
    {"name": "Allergies", "icon": "fas fa-allergies", "specialty": "Allergist"},
    {"name": "Migraine", "icon": "fas fa-headache", "specialty": "Neurologist"},
    {"name": "COVID-19", "icon": "fas fa-virus", "specialty": "Pulmonologist"},
    {"name": "Diabetes", "icon": "fas fa-vial", "specialty": "Endocrinologist"},
    {"name": "Hypertension", "icon": "fas fa-heartbeat", "specialty": "Cardiologist"},
    {"name": "Asthma", "icon": "fas fa-lungs", "specialty": "Pulmonologist"}
]

SPECIALTIES = [
    {"name": "Cardiology", "icon": "fas fa-heart"},
    {"name": "Dermatology", "icon": "fas fa-allergies"},
    {"name": "Neurology", "icon": "fas fa-brain"},
    {"name": "Pediatrics", "icon": "fas fa-baby"},
    {"name": "Orthopedics", "icon": "fas fa-bone"},
    {"name": "Gynecology", "icon": "fas fa-female"}
]

# Authentication Routes
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')
        
        if not email or not password:
            flash('Please fill all fields', 'error')
            return redirect(url_for('login'))
        
        conn = get_db_connection()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute("SELECT * FROM Users WHERE Email = ?", (email,))
                user = cursor.fetchone()
                
                if user and check_password_hash(user.PasswordHash, password):
                    session['user_id'] = user.UserID
                    session['user_email'] = user.Email
                    flash('Login successful!', 'success')
                    return redirect(url_for('home'))
                else:
                    flash('Invalid email or password', 'error')
            except Exception as e:
                logger.error(f"Login error: {str(e)}")
                flash('Login failed. Please try again.', 'error')
            finally:
                cursor.close()
                conn.close()
        else:
            flash('Database connection error', 'error')
    
    return render_template('login.html')

@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        email = request.form.get('email')
        password = request.form.get('password')
        confirm_password = request.form.get('confirm_password')
        
        if not email or not password or not confirm_password:
            flash('Please fill all fields', 'error')
            return redirect(url_for('signup'))
        
        if password != confirm_password:
            flash('Passwords do not match', 'error')
            return redirect(url_for('signup'))
        
        if not re.match(r"[^@]+@[^@]+\.[^@]+", email):
            flash('Invalid email address', 'error')
            return redirect(url_for('signup'))
        
        if len(password) < 8:
            flash('Password must be at least 8 characters', 'error')
            return redirect(url_for('signup'))
        
        conn = get_db_connection()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute("SELECT * FROM Users WHERE Email = ?", (email,))
                if cursor.fetchone():
                    flash('Email already exists', 'error')
                    return redirect(url_for('signup'))
                
                hashed_password = generate_password_hash(password)
                cursor.execute(
                    "INSERT INTO Users (Email, PasswordHash, CreatedDate) VALUES (?, ?, GETDATE())",
                    (email, hashed_password)
                )
                conn.commit()
                
                flash('Account created successfully! Please login.', 'success')
                return redirect(url_for('login'))
            except Exception as e:
                logger.error(f"Signup error: {str(e)}")
                flash('Registration failed. Please try again.', 'error')
            finally:
                cursor.close()
                conn.close()
        else:
            flash('Database connection error', 'error')
    
    return render_template('signup.html')

@app.route('/logout')
def logout():
    session.clear()
    flash('You have been logged out', 'info')
    return redirect(url_for('home'))

# Existing Routes (unchanged)
@app.route('/')
def home():
    """Render the home page with medical data"""
    return render_template('index.html',
                         symptoms=COMMON_SYMPTOMS,
                         conditions=COMMON_CONDITIONS,
                         specialties=SPECIALTIES,
                         selected_symptoms=[])

@app.route('/api/specialists', methods=['GET'])
def get_specialists():
    """Get specialists from database or fallback to mock data"""
    try:
        condition = request.args.get('condition', '').strip()
        location = request.args.get('location', 'Karachi').strip()
        
        # Get specialty from condition
        specialty = next(
            (c['specialty'] for c in COMMON_CONDITIONS 
            if c['name'].lower() == condition.lower()),
            'General Physician'
        )

        # Try database first
        conn = get_db_connection()
        if conn:
            try:
                cursor = conn.cursor()
                query = """
                SELECT 
                    d.DoctorID as doctor_id,
                    d.FirstName + ' ' + d.LastName as name,
                    ds.SpecialtyName as specialty,
                    d.YearsOfExperience as experience,
                    c.City + ', ' + c.ClinicName as location,
                    dc.ConsultationFee as fee,
                    CASE WHEN da.AvailabilityID IS NOT NULL THEN 1 ELSE 0 END as available,
                    d.Qualification as qualifications,
                    d.Bio as about,
                    d.Rating as rating
                FROM Doctor d
                JOIN DoctorSpecialtyMapping dsm ON d.DoctorID = dsm.DoctorID AND dsm.IsPrimary = 1
                JOIN DoctorSpecialty ds ON dsm.SpecialtyID = ds.SpecialtyID
                JOIN DoctorClinic dc ON d.DoctorID = dc.DoctorID
                JOIN Clinic c ON dc.ClinicID = c.ClinicID
                LEFT JOIN DoctorAvailability da ON dc.DoctorClinicID = da.DoctorClinicID
                WHERE ds.SpecialtyName = ? AND c.City LIKE ? AND d.IsActive = 1 AND dc.IsActive = 1
                ORDER BY d.Rating DESC
                """
                
                cursor.execute(query, [specialty, f'%{location}%'])
                
                columns = [column[0] for column in cursor.description]
                db_specialists = [dict(zip(columns, row)) for row in cursor.fetchall()]
                
                if db_specialists:
                    specialists = []
                    for i, spec in enumerate(db_specialists):
                        specialists.append({
                            "id": spec['doctor_id'],
                            "name": spec['name'],
                            "specialty": spec['specialty'],
                            "rating": float(spec['rating']),
                            "experience": f"{spec['experience']} years",
                            "location": spec['location'],
                            "fee": float(spec['fee']),
                            "available": bool(spec['available']),
                            "languages": ["English", "Urdu"],  # Default as not in schema
                            "image": f"/static/images/doctors/doctor-{(i % 4) + 1}.jpg",
                            "qualifications": spec['qualifications'].split(',') if spec['qualifications'] else ["MBBS"],
                            "about": spec['about'] or f"Specialized in {spec['specialty']}"
                        })
                    
                    return jsonify({
                        'success': True,
                        'condition': condition,
                        'specialty': specialty,
                        'location': location,
                        'count': len(specialists),
                        'specialists': specialists,
                        'source': 'database'
                    })
            except Exception as db_error:
                logger.error(f"Database query error: {str(db_error)}")
            finally:
                cursor.close()
                conn.close()

        # Fallback to mock data if database fails or returns no results
        return get_mock_specialists(condition, location)
        
    except Exception as e:
        logger.error(f"Specialists error: {str(e)}", exc_info=True)
        return jsonify({
            'success': False,
            'error': 'Failed to retrieve specialists',
            'details': str(e) if Config.FLASK_DEBUG else None
        }), 500

@app.route('/api/specialties', methods=['GET'])
def get_specialties():
    """Get list of all medical specialties"""
    try:
        # First try to get from database
        conn = get_db_connection()
        if conn:
            try:
                cursor = conn.cursor()
                cursor.execute("SELECT SpecialtyID, SpecialtyName, SpecialtyDescription FROM DoctorSpecialty")
                columns = [column[0] for column in cursor.description]
                specialties = [dict(zip(columns, row)) for row in cursor.fetchall()]
                return jsonify({
                    'success': True,
                    'specialties': specialties,
                    'source': 'database'
                })
            except Exception as db_error:
                logger.error(f"Database query error: {str(db_error)}")
            finally:
                cursor.close()
                conn.close()
        
        # Fallback to static data if database fails
        return jsonify({
            'success': True,
            'specialties': [{"SpecialtyName": spec["name"]} for spec in SPECIALTIES],
            'source': 'static'
        })
        
    except Exception as e:
        logger.error(f"Specialties error: {str(e)}", exc_info=True)
        return jsonify({
            'success': False,
            'error': 'Failed to retrieve specialties',
            'details': str(e) if Config.FLASK_DEBUG else None
        }), 500

@app.route('/result')
def result():
    """Show diagnosis results page"""
    symptoms = request.args.get('symptoms', '').split(',')
    if not symptoms or symptoms == ['']:
        return redirect(url_for('home'))
    
    return render_template('result.html',
                         symptoms=[s.capitalize() for s in symptoms],
                         conditions=COMMON_CONDITIONS)

@app.route('/api/health', methods=['GET'])
def health_check():
    """System health check endpoint"""
    db_status = 'connected' if get_db_connection() else 'disconnected'
    return jsonify({
        'status': 'healthy',
        'database': db_status,
        'timestamp': datetime.now().isoformat(),
        'version': '1.0.0'
    })

@app.route('/api/diagnose', methods=['POST'])
def diagnose_symptoms():
    """Diagnose symptoms using AI"""
    try:
        data = request.get_json()
        if not data or 'symptoms' not in data:
            return jsonify({'success': False, 'error': 'Symptoms array required'}), 400

        symptoms = [s.strip().lower() for s in data['symptoms'] if s.strip()]
        if not symptoms:
            return jsonify({'success': False, 'error': 'No valid symptoms provided'}), 400

        result = llm_handler.diagnose_from_symptoms(symptoms)

        # Format response
        if 'context' in result:
            result['context'] = {
                'overview': result['context'].get('overview', ''),
                'remedies': list(result['context'].get('remedies', []))[:5],
                'precautions': list(result['context'].get('precautions', [])),
                'medications': list(result['context'].get('medications', []))[:5]
            }

        return jsonify({
            'success': True,
            'diagnosis': result,
            'symptoms': symptoms,
            'timestamp': datetime.now().isoformat()
        })

    except Exception as e:
        logger.error(f"Diagnosis error: {str(e)}", exc_info=True)
        return jsonify({
            'success': False,
            'error': 'An error occurred during diagnosis',
            'details': str(e) if Config.FLASK_DEBUG else None
        }), 500

@app.route('/api/symptoms', methods=['GET'])
def get_symptoms():
    """Get filtered list of symptoms"""
    try:
        search = request.args.get('search', '').lower()
        category = request.args.get('category', '').lower()

        filtered = COMMON_SYMPTOMS
        if search:
            filtered = [s for s in filtered if search in s['name'].lower()]
        if category:
            filtered = [s for s in filtered if s['category'].lower() == category]

        return jsonify({
            'success': True,
            'count': len(filtered),
            'symptoms': filtered,
            'search': search,
            'category': category
        })

    except Exception as e:
        logger.error(f"Symptoms error: {str(e)}", exc_info=True)
        return jsonify({
            'success': False,
            'error': 'Failed to filter symptoms',
            'details': str(e) if Config.FLASK_DEBUG else None
        }), 500

def get_mock_specialists(condition, location):
    """Fallback mock data generator for specialists"""
    specialty = next(
        (c['specialty'] for c in COMMON_CONDITIONS 
        if c['name'].lower() == condition.lower()),
        'General Physician'
    )
    
    specialists = [
        {
            "id": f"doc{i+1}",
            "name": f"Dr. {'Ayesha' if i % 2 else 'Farhan'} {'Malik' if i % 2 else 'Siddiqui'}",
            "specialty": specialty,
            "rating": round(4.5 + (i * 0.1), 1),
            "experience": f"{10 + i} years",
            "location": f"{location} Medical Center",
            "fee": f"{1500 + (i * 500)}",
            "available": "Today" if i % 2 else "Tomorrow",
            "languages": ["English", "Urdu"],
            "image": f"/static/images/doctors/doctor-{i+1}.jpg",
            "qualifications": ["MBBS", "FCPS" if i % 2 else "MD"],
            "about": f"Specialized in {specialty} with extensive experience in treating {condition}."
        } for i in range(4)
    ]
    
    return jsonify({
        'success': True,
        'condition': condition,
        'specialty': specialty,
        'location': location,
        'count': len(specialists),
        'specialists': specialists,
        'source': 'mock'
    })

if __name__ == '__main__':
    app.run(
        host=Config.FLASK_HOST,
        port=Config.FLASK_PORT,
        debug=Config.FLASK_DEBUG
    )