// Global variables
let selectedSymptoms = [];

// DOM elements
const symptomInput = document.getElementById('symptom-input');
const selectedSymptomsList = document.getElementById('selected-symptoms-list');
const diagnoseBtn = document.getElementById('diagnose-btn');

// Initialize the page
document.addEventListener('DOMContentLoaded', function() {
    // Check if we're on the result page and need to get diagnosis
    if (window.location.pathname === '/result') {
        const urlParams = new URLSearchParams(window.location.search);
        const symptomsParam = urlParams.get('symptoms');
        
        if (symptomsParam) {
            const symptoms = symptomsParam.split(',');
            getDiagnosis(symptoms);
        }
    }
    
    // Set up event listeners
    if (symptomInput) {
        symptomInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                addCustomSymptom();
            }
        });
    }
    
    if (diagnoseBtn) {
        diagnoseBtn.addEventListener('click', submitSymptoms);
    }
    // Add click handlers for symptom cards
    document.querySelectorAll('.symptom-card').forEach(card => {
        card.addEventListener('click', function() {
            const symptom = this.getAttribute('data-symptom');
            addSymptom(symptom);
        });
    });
});

// Add symptom from card click
function addSymptom(symptom) {
    if (!selectedSymptoms.includes(symptom)) {
        selectedSymptoms.push(symptom);
        updateSelectedSymptomsList();
    }
}

// Add custom symptom from input
function addCustomSymptom() {
    const symptom = symptomInput.value.trim();
    if (symptom && !selectedSymptoms.includes(symptom)) {
        selectedSymptoms.push(symptom);
        symptomInput.value = '';
        updateSelectedSymptomsList();
    }
}

// Update the displayed list of selected symptoms
function updateSelectedSymptomsList() {
    if (selectedSymptomsList) {
        selectedSymptomsList.innerHTML = '';
        selectedSymptoms.forEach((symptom, index) => {
            const symptomElement = document.createElement('div');
            symptomElement.className = 'symptom-tag';
            symptomElement.innerHTML = `
                <span>${symptom}</span>
                <button onclick="removeSymptom(${index})"><i class="fas fa-times"></i></button>
            `;
            selectedSymptomsList.appendChild(symptomElement);
        });
    }
}

// Remove a symptom
function removeSymptom(index) {
    selectedSymptoms.splice(index, 1);
    updateSelectedSymptomsList();
}

// Submit symptoms for diagnosis
function submitSymptoms() {
    if (selectedSymptoms.length === 0) {
        alert('Please add at least one symptom');
        return;
    }
    
    // Encode symptoms for URL
    const symptomsParam = encodeURIComponent(selectedSymptoms.join(','));
    window.location.href = `/result?symptoms=${symptomsParam}`;
}

// Get diagnosis from backend - UPDATED VERSION
function getDiagnosis(symptoms) {
    console.log('Getting diagnosis for:', symptoms); // Debug log
    
    const loadingElement = document.getElementById('loading');
    const resultElement = document.getElementById('diagnosis-result');
    const errorElement = document.getElementById('error');
    
    // Show loading state
    if (loadingElement) loadingElement.style.display = 'block';
    if (resultElement) resultElement.style.display = 'none';
    if (errorElement) errorElement.style.display = 'none';
    
    // Ensure symptoms are properly formatted
    const formattedSymptoms = symptoms.map(s => s.trim().toLowerCase());
    
    fetch('/api/diagnose', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ symptoms: formattedSymptoms })
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
    })
    .then(data => {
        console.log('Diagnosis response:', data); // Debug log
        
        if (loadingElement) loadingElement.style.display = 'none';
        
        if (data.success && data.diagnosis) {
            displayDiagnosisResult(data.diagnosis);
            if (resultElement) resultElement.style.display = 'block';
            
            // Show specialists for the primary condition
            if (data.diagnosis.condition) {
                const specialistsSection = document.getElementById('condition-specialists');
                if (specialistsSection) {
                    specialistsSection.style.display = 'block';
                    searchSpecialists(data.diagnosis.condition);
                }
            }
        } else {
            displayError(data.error || 'No diagnosis could be determined');
        }
    })
    .catch(error => {
        console.error('Diagnosis error:', error); // Debug log
        if (loadingElement) loadingElement.style.display = 'none';
        displayError(error.message || 'Failed to connect to the server');
    });
}


// Display diagnosis results
function displayDiagnosisResult(diagnosis) {
    const resultElement = document.getElementById('diagnosis-result');
    
    let html = `
        <div class="diagnosis-card">
            <h3><i class="fas fa-diagnoses"></i> Preliminary Diagnosis</h3>
            
            <div class="diagnosis-main">
                <div>
                    <span class="condition">${diagnosis.condition || 'Unknown Condition'}</span>
                    ${diagnosis.confidence ? `<span class="confidence">${diagnosis.confidence}% confidence</span>` : ''}
                </div>
            </div>
            
            <div class="diagnosis-context">
                <div class="context-section">
                    <h4><i class="fas fa-info-circle"></i> Overview</h4>
                    <p>${diagnosis.context.overview || 'No overview available.'}</p>
                </div>
                
                ${diagnosis.context.remedies && diagnosis.context.remedies.length > 0 ? `
                <div class="context-section">
                    <h4><i class="fas fa-home"></i> Home Remedies</h4>
                    <ul>
                        ${diagnosis.context.remedies.map(remedy => `<li>${remedy}</li>`).join('')}
                    </ul>
                </div>
                ` : ''}
                
                ${diagnosis.context.precautions && diagnosis.context.precautions.length > 0 ? `
                <div class="context-section">
                    <h4><i class="fas fa-shield-alt"></i> Precautions</h4>
                    <ul>
                        ${diagnosis.context.precautions.map(precaution => `<li>${precaution}</li>`).join('')}
                    </ul>
                </div>
                ` : ''}
                
                ${diagnosis.context.medications && diagnosis.context.medications.length > 0 ? `
                <div class="context-section">
                    <h4><i class="fas fa-pills"></i> Medications</h4>
                    <ul>
                        ${diagnosis.context.medications.map(med => `<li>${med}</li>`).join('')}
                    </ul>
                </div>
                ` : ''}
            </div>
        </div>
    `;
    
    resultElement.innerHTML = html;
}

// Display error message
function displayError(message) {
    const errorElement = document.getElementById('error');
    document.getElementById('error-message').textContent = message;
    errorElement.style.display = 'block';
}

// Load top specialists
function loadTopSpecialists() {
    const container = document.getElementById('specialists-container');
    if (!container) return;
    
    fetch('/api/specialists?condition=general')
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            displaySpecialists(data.specialists, container);
        }
    })
    .catch(error => console.error('Error loading specialists:', error));
}

// Search specialists by condition
function searchSpecialists(condition) {
    const container = document.getElementById('specialists-list') || 
                      document.getElementById('specialists-container');
    
    if (!container) return;
    
    fetch(`/api/specialists?condition=${encodeURIComponent(condition)}`)
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            displaySpecialists(data.specialists, container);
        }
    })
    .catch(error => console.error('Error searching specialists:', error));
}

// Display specialists list
function displaySpecialists(specialists, container) {
    if (!container) return;
    
    container.innerHTML = specialists.map(specialist => `
        <div class="specialist-card">
            <div class="specialist-icon-container">
                <i class="fas fa-user-md specialist-icon"></i>
            </div>
            <h3>${specialist.name}</h3>
            <p>${specialist.specialty}</p>
            <div class="specialist-meta">
                <span class="rating"><i class="fas fa-star"></i> ${specialist.rating}</span>
                <span class="experience"><i class="fas fa-briefcase"></i> ${specialist.experience}</span>
            </div>
            <p class="location"><i class="fas fa-map-marker-alt"></i> ${specialist.location}</p>
            <div class="specialist-footer">
                <span class="fee">Fee: Rs. ${specialist.fee}</span>
                <span class="available">${specialist.available}</span>
            </div>
            <button class="book-btn" onclick="bookAppointment('${specialist.name}')">
                <i class="fas fa-calendar-check"></i> Book Now
            </button>
        </div>
    `).join('');
}

// Book appointment (placeholder)
function bookAppointment(doctorName) {
    alert(`Booking appointment with ${doctorName}\nThis would connect to a booking system in a real app.`);
}