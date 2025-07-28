import time
from datetime import datetime
from backend.llm.llm_integration import LLMHandler

def format_time(time_str):
    """Convert time string to 12-hour format"""
    try:
        return datetime.strptime(time_str.split('.')[0], "%H:%M:%S").strftime("%I:%M %p")
    except:
        return time_str

def get_day_name(day_num):
    days = ["Monday", "Tuesday", "Wednesday", "Thursday", 
            "Friday", "Saturday", "Sunday"]
    return days[day_num - 1] if 1 <= day_num <= 7 else "Unknown"

def print_diagnosis_result(result, expected=None):
    """Print formatted diagnosis results with all details"""
    print(f"\nDiagnosis: {result.get('condition', 'UNKNOWN')}")
    if expected:
        print(f"Expected: {expected}")
    print(f"Confidence: {result.get('confidence', 0)}%")
    
    if 'error' in result:
        print(f"\nError: {result['error']}")
        if 'details' in result:
            print(f"Details: {result['details']}")
        return
    
    context = result.get('context', {})
    
    # Print medications
    if context.get('medications'):
        print("\nRecommended Medications:")
        for med in context['medications']:
            print(f"- {med}")
    
    # Print precautions
    if context.get('precautions'):
        print("\nImportant Precautions:")
        for prec in context['precautions']:
            print(f"- {prec}")
    
    # Print remedies
    if context.get('remedies'):
        print("\nSuggested Remedies:")
        for rem in context['remedies']:
            print(f"- {rem}")
    
    # Print doctor information
    doctors = context.get('doctors', [])
    if doctors:
        print("\nRecommended Specialists:")
        for i, doctor in enumerate(doctors, 1):
            print(f"\n{i}. Dr. {doctor.get('Name', 'N/A')}")
            print(f"   Specialty: {doctor.get('SpecialtyName', 'N/A')}")
            print(f"   Experience: {doctor.get('YearsOfExperience', 'N/A')} years")
            print(f"   Rating: {doctor.get('Rating', 'N/A')}/5")
            print(f"   Clinic: {doctor.get('ClinicName', 'N/A')}")
            print(f"   Location: {doctor.get('Address', '')}, {doctor.get('City', '')}")
            print(f"   Contact: {doctor.get('Phone', 'N/A')}")
            print(f"   Fees: Consultation ₹{doctor.get('ConsultationFee', 0)} | Follow-up ₹{doctor.get('FollowUpFee', 0)}")
            print(f"   Availability: {get_day_name(int(doctor.get('DayOfWeek', 1)))} {format_time(str(doctor.get('StartTime')))} - {format_time(str(doctor.get('EndTime')))}")
    else:
        print("\nNo specialists found for this condition.")

def test_diagnosis():
    """Main test function"""
    print("=== Medical Diagnosis Tester ===")
    print("Initializing LLM handler...")
    start_time = time.time()
    
    try:
        llm = LLMHandler(use_local_index=True)
        print(f"Initialized in {time.time() - start_time:.2f}s")
        
        test_cases = [
            (["fever", "cough"], "influenza"),
            (["headache", "nausea"], "migraine"),
            (["chest pain"], "heart disease")
        ]
        
        for symptoms, expected in test_cases:
            print(f"\n{'-'*50}")
            print(f"Testing symptoms: {', '.join(symptoms)}")
            case_start = time.time()
            
            result = llm.diagnose_from_symptoms(symptoms)
            elapsed = time.time() - case_start
            
            print_diagnosis_result(result, expected)
            print(f"\n⏱️ Completed in {elapsed:.2f} seconds")
        
        print("\n" + "="*50)
        print("✅ All test cases completed successfully.")
        
    except Exception as e:
        print(f"\n❌ Error: {str(e)}")
        print("\n🚨 Troubleshooting Tips:")
        print("1. Check database connection")
        print("2. Verify FAISS index path")
        print("3. Make sure all SQL tables and columns exist and match the queries")

if __name__ == "__main__":
    test_diagnosis()
