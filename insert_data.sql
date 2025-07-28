-- Insert Symptoms (1-25)
INSERT INTO Symptom (SymptomID, SymptomName, SymptomCategory, CommonInDiseases) VALUES
(1, 'Fever', 'General', 'Flu, COVID-19, Dengue, Typhoid'),
(2, 'Cough', 'Respiratory', 'Flu, COVID-19, Asthma, Tuberculosis'),
(3, 'Burning urination', 'Urinary', 'UTI, Kidney stones'),
(4, 'Headache', 'Neurological', 'Migraine, Hypertension, COVID-19'),
(5, 'Shortness of breath', 'Respiratory', 'Asthma, COVID-19, Pneumonia'),
(6, 'Abdominal pain', 'Gastrointestinal', 'Gastroenteritis, Appendicitis'),
(7, 'Skin rash', 'Dermatological', 'Dengue, Measles, Allergies'),
(8, 'Facial pressure', 'ENT', 'Sinusitis, Migraine'),
(9, 'Chest pain', 'Cardiovascular', 'Heart disease, Pneumonia'),
(10, 'Jaundice', 'Hepatic', 'Hepatitis, Gallstones'),
(11, 'Seizures', 'Neurological', 'Epilepsy, Brain injury'),
(12, 'Fatigue', 'General', 'Anemia, Diabetes, Depression'),
(13, 'Dizziness', 'Neurological', 'Low BP, Vertigo, Anemia'),
(14, 'Excessive thirst', 'Endocrine', 'Diabetes, Dehydration'),
(15, 'Diarrhea', 'Gastrointestinal', 'Gastroenteritis, Food poisoning'),
(16, 'Stiff neck', 'Neurological', 'Meningitis, Muscle strain'),
(17, 'Red skin rash', 'Dermatological', 'Measles, Chickenpox'),
(18, 'Joint pain', 'Musculoskeletal', 'Arthritis, Dengue'),
(19, 'Itching', 'Dermatological', 'Allergies, Skin infections'),
(20, 'Belly bloating', 'Gastrointestinal', 'Indigestion, IBS'),
(21, 'Sneezing', 'Respiratory', 'Allergies, Common cold'),
(22, 'Sore throat', 'ENT', 'Tonsillitis, COVID-19'),
(23, 'Yellowish eyes', 'Hepatic', 'Jaundice, Hepatitis'),
(24, 'Muscle weakness', 'Neurological', 'Stroke, Myopathy'),
(25, 'Dry mouth', 'General', 'Diabetes, Dehydration');
GO

-- Insert Diseases (1-25)
INSERT INTO Disease (DiseaseID, DiseaseName, Description, ICD10Code, IsChronic, IsContagious, Prevalence, TypicalDuration) VALUES
(1, 'Flu', 'A common viral infection that attacks the respiratory system.', 'J11.1', 0, 1, 'Common', '1-2 weeks'),
(2, 'COVID-19', 'Respiratory illness caused by coronavirus SARS-CoV-2.', 'U07.1', 0, 1, 'Pandemic', '2-3 weeks'),
(3, 'UTI', 'Infection in any part of the urinary system.', 'N39.0', 0, 0, 'Common', '3-7 days with treatment'),
(4, 'Migraine', 'Neurological condition causing severe headaches.', 'G43.9', 1, 0, 'Common', '4-72 hours per episode'),
(5, 'Asthma', 'Chronic inflammatory disease of the airways.', 'J45.909', 1, 0, 'Common', 'Lifelong with episodic symptoms'),
(6, 'Typhoid', 'Bacterial infection due to Salmonella typhi.', 'A01.00', 0, 1, 'Endemic in some regions', '3-4 weeks with treatment'),
(7, 'Psoriasis', 'Chronic autoimmune skin condition.', 'L40.9', 1, 0, 'Moderate', 'Lifelong with flare-ups'),
(8, 'Tuberculosis', 'Infectious disease usually affecting lungs.', 'A15.9', 0, 1, 'Moderate', '6-9 months treatment'),
(9, 'Sinusitis', 'Inflammation of the sinuses.', 'J32.9', 0, 0, 'Common', '1-4 weeks'),
(10, 'Bronchitis', 'Inflammation of the bronchial tubes.', 'J20.9', 0, 0, 'Common', '1-3 weeks'),
(11, 'Dengue', 'Mosquito-borne viral infection.', 'A90', 0, 0, 'Seasonal in tropical areas', '1-2 weeks'),
(12, 'Pneumonia', 'Infection that inflames air sacs in lungs.', 'J18.9', 0, 1, 'Common', '2-6 weeks'),
(13, 'Hepatitis B', 'Viral infection that attacks the liver.', 'B16.9', 1, 1, 'Moderate', 'Chronic in 5-10% cases'),
(14, 'Epilepsy', 'Central nervous system disorder.', 'G40.909', 1, 0, 'Moderate', 'Lifelong'),
(15, 'Anemia', 'Deficiency of red blood cells or hemoglobin.', 'D64.9', 1, 0, 'Very common', 'Varies by cause'),
(16, 'Hypertension', 'Abnormally high blood pressure.', 'I10', 1, 0, 'Very common', 'Lifelong'),
(17, 'Diabetes Type 1', 'Autoimmune destruction of insulin-producing cells.', 'E10.9', 1, 0, 'Moderate', 'Lifelong'),
(18, 'Diabetes Type 2', 'Insulin resistance or deficiency.', 'E11.9', 1, 0, 'Very common', 'Lifelong'),
(19, 'Gastroenteritis', 'Inflammation of the digestive tract.', 'K52.9', 0, 1, 'Very common', '1-3 days'),
(20, 'Appendicitis', 'Inflammation of the appendix.', 'K35.80', 0, 0, 'Moderate', 'Requires surgery'),
(21, 'Meningitis', 'Inflammation of brain and spinal cord membranes.', 'G03.9', 0, 1, 'Rare', 'Weeks to months'),
(22, 'Measles', 'Highly contagious viral infection.', 'B05.9', 0, 1, 'Rare in vaccinated populations', '7-10 days'),
(23, 'Jaundice', 'Yellow discoloration from bilirubin buildup.', 'R17', 0, 0, 'Common in newborns', 'Varies by cause'),
(24, 'Arthritis', 'Inflammation of one or more joints.', 'M19.90', 1, 0, 'Common', 'Chronic'),
(25, 'Tonsillitis', 'Inflammation of the tonsils.', 'J03.90', 0, 1, 'Common in children', '3-7 days');
GO

-- Insert Doctor Specialties (1-25)
INSERT INTO DoctorSpecialty (SpecialtyName, Description, Category, IsSurgical, AverageYearsOfTraining) VALUES
('General Practitioner', 'Primary care physician for all ages', 'Primary Care', 0, 5),
('Infectious Disease Specialist', 'Treats infections like COVID-19, dengue', 'Internal Medicine', 0, 6),
('Urologist', 'Specializes in urinary tract and male reproductive system', 'Surgical', 1, 6),
('Neurologist', 'Treats brain and nervous system disorders', 'Internal Medicine', 0, 7),
('Immunologist', 'Manages immune system disorders', 'Internal Medicine', 0, 7),
('Pediatrician', 'Specializes in children''s health', 'Primary Care', 0, 6),
('Dermatologist', 'Treats skin, hair, and nail conditions', 'Clinical', 0, 6),
('Pulmonologist', 'Specializes in lung diseases', 'Internal Medicine', 0, 6),
('ENT Specialist', 'Ear, nose, and throat conditions', 'Surgical', 1, 6),
('Gastroenterologist', 'Digestive system disorders', 'Internal Medicine', 0, 6),
('Hepatologist', 'Liver disease specialist', 'Internal Medicine', 0, 7),
('Cardiologist', 'Heart and cardiovascular specialist', 'Internal Medicine', 0, 7),
('Endocrinologist', 'Hormone and metabolic disorders', 'Internal Medicine', 0, 7),
('Psychiatrist', 'Mental health and behavioral disorders', 'Clinical', 0, 7),
('Rheumatologist', 'Joint and autoimmune diseases', 'Internal Medicine', 0, 6),
('Nephrologist', 'Kidney disease specialist', 'Internal Medicine', 0, 7),
('Hematologist', 'Blood disorder specialist', 'Internal Medicine', 0, 7),
('Gynecologist', 'Women''s reproductive health', 'Surgical', 1, 6),
('Orthopedic Surgeon', 'Bone and joint surgery', 'Surgical', 1, 8),
('General Surgeon', 'Performs various surgeries', 'Surgical', 1, 8),
('Allergist', 'Allergy and immune reactions', 'Clinical', 0, 6),
('Oncologist', 'Cancer specialist', 'Internal Medicine', 0, 7),
('Physiatrist', 'Physical medicine and rehabilitation', 'Clinical', 0, 6),
('Geriatrician', 'Elderly patient care', 'Primary Care', 0, 6),
('Family Physician', 'Comprehensive care for all ages', 'Primary Care', 0, 5);
GO

-- Insert Doctors (1-25)
INSERT INTO Doctor (FirstName, LastName, Gender, DateOfBirth, LicenseNumber, YearsOfExperience, Qualification, PMDCNumber, Rating) VALUES
('Ayesha', 'Malik', 'F', '1975-03-15', 'PK-MED-12345', 12, 'MBBS, FCPS', '12345-A', 4.5),
('Farhan', 'Siddiqui', 'M', '1970-07-22', 'PK-MED-12346', 15, 'MBBS, FRCP', '12346-B', 4.7),
('Sara', 'Khan', 'F', '1968-11-05', 'PK-MED-12347', 18, 'MBBS, MD', '12347-C', 4.8),
('Imran', 'Ahmed', 'M', '1982-09-30', 'PK-MED-12348', 8, 'MBBS, MCPS', '12348-D', 4.2),
('Hina', 'Shah', 'F', '1972-05-18', 'PK-MED-12349', 20, 'MBBS, FCPS', '12349-E', 4.9),
('Ali', 'Raza', 'M', '1978-12-10', 'PK-MED-12350', 14, 'MBBS, FRCS', '12350-F', 4.6),
('Yasmin', 'Akhtar', 'F', '1965-02-28', 'PK-MED-12351', 22, 'MBBS, PhD', '12351-G', 4.7),
('Bilal', 'Hussain', 'M', '1980-08-15', 'PK-MED-12352', 10, 'MBBS, FCPS', '12352-H', 4.3),
('Nadia', 'Khan', 'F', '1977-04-20', 'PK-MED-12353', 13, 'MBBS, MD', '12353-I', 4.4),
('Omar', 'Farooq', 'M', '1985-01-12', 'PK-MED-12354', 5, 'MBBS, MCPS', '12354-J', 4.1),
('Fatima', 'Zahra', 'F', '1983-06-25', 'PK-MED-12355', 7, 'MBBS, FCPS', '12355-K', 4.2),
('Kamran', 'Ali', 'M', '1973-10-08', 'PK-MED-12356', 17, 'MBBS, FRCP', '12356-L', 4.8),
('Zainab', 'Hassan', 'F', '1981-07-30', 'PK-MED-12357', 9, 'MBBS, MD', '12357-M', 4.5),
('Usman', 'Rafique', 'M', '1976-03-22', 'PK-MED-12358', 14, 'MBBS, FCPS', '12358-N', 4.6),
('Sadia', 'Iqbal', 'F', '1984-11-15', 'PK-MED-12359', 6, 'MBBS, MCPS', '12359-O', 4.0),
('Tariq', 'Mehmood', 'M', '1969-09-05', 'PK-MED-12360', 21, 'MBBS, FRCS', '12360-P', 4.9),
('Aisha', 'Qureshi', 'F', '1980-12-18', 'PK-MED-12361', 10, 'MBBS, FCPS', '12361-Q', 4.3),
('Haroon', 'Yousaf', 'M', '1975-04-30', 'PK-MED-12362', 15, 'MBBS, MD', '12362-R', 4.7),
('Maria', 'Jamal', 'F', '1982-08-12', 'PK-MED-12363', 8, 'MBBS, MCPS', '12363-S', 4.1),
('Jawad', 'Ahmed', 'M', '1979-01-25', 'PK-MED-12364', 11, 'MBBS, FCPS', '12364-T', 4.4),
('Nida', 'Khalid', 'F', '1983-05-08', 'PK-MED-12365', 7, 'MBBS, MD', '12365-U', 4.2),
('Saad', 'Malik', 'M', '1974-07-20', 'PK-MED-12366', 16, 'MBBS, FRCP', '12366-V', 4.8),
('Hira', 'Nazir', 'F', '1986-02-14', 'PK-MED-12367', 4, 'MBBS, MCPS', '12367-W', 3.9),
('Asim', 'Riaz', 'M', '1971-10-28', 'PK-MED-12368', 19, 'MBBS, FCPS', '12368-X', 4.9),
('Rabia', 'Aslam', 'F', '1978-06-15', 'PK-MED-12369', 12, 'MBBS, MD', '12369-Y', 4.5);
GO

-- Corrected DoctorSpecialtyMapping insert (removing duplicates)
INSERT INTO DoctorSpecialtyMapping (DoctorID, SpecialtyID, IsPrimary, YearsInSpecialty) VALUES
-- Primary specialties (25 rows)
(1, 1, 1, 10), (2, 2, 1, 13), (3, 4, 1, 16), (4, 6, 1, 6), (5, 12, 1, 18),
(6, 19, 1, 12), (7, 13, 1, 20), (8, 3, 1, 8), (9, 18, 1, 11), (10, 5, 1, 3),
(11, 7, 1, 5), (12, 8, 1, 15), (13, 9, 1, 7), (14, 10, 1, 12), (15, 11, 1, 4),
(16, 14, 1, 19), (17, 15, 1, 8), (18, 16, 1, 13), (19, 17, 1, 6), (20, 20, 1, 9),
(21, 21, 1, 5), (22, 22, 1, 14), (23, 23, 1, 2), (24, 24, 1, 17), (25, 25, 1, 10),
-- Secondary specialties (modified to avoid duplicates)
(1, 25, 0, 5), (2, 1, 0, 3), (3, 14, 0, 5), 
/* Removed: (4, 6, 0, 8) - duplicate of primary specialty */
(5, 8, 0, 4), (6, 15, 0, 3), (7, 5, 0, 6), (8, 10, 0, 2), (9, 7, 0, 4), (10, 21, 0, 1),
(11, 18, 0, 2), (12, 12, 0, 7), (13, 3, 0, 3), (14, 11, 0, 5), (15, 16, 0, 2),
(16, 4, 0, 8), (17, 9, 0, 4), (18, 17, 0, 6), (19, 22, 0, 3), (20, 19, 0, 5),
(21, 5, 0, 2), (22, 24, 0, 7), (23, 25, 0, 1), (24, 1, 0, 10), (25, 6, 0, 4);
GO
-- Insert Clinics (1-25)
INSERT INTO Clinic (ClinicName, Address, City, Phone, Email, Website, Latitude, Longitude, Facilities, OpeningHours) VALUES
('Aga Khan University Hospital', 'Stadium Road, Karachi', 'Karachi', '021-111911911', 'aku@aku.edu', 'https://hospitals.aku.edu', 24.8607, 67.0011, 'Emergency, ICU, Lab, Pharmacy, Radiology', '24/7'),
('Liaquat National Hospital', 'National Stadium Rd, Karachi', 'Karachi', '021-111456456', 'info@lnh.edu.pk', 'https://www.lnh.edu.pk', 24.9068, 67.0312, 'Multi-specialty, ICU, ER, OPD', '24/7'),
('Shaukat Khanum Memorial Hospital', '7A Block R-3, Johar Town', 'Lahore', '042-111155666', 'info@skm.org.pk', 'https://shaukatkhanum.org.pk', 31.4799, 74.2666, 'Cancer treatment, Radiology, Lab', '8am-8pm'),
('Islamabad Clinic', 'Plot 26, F-8 Markaz', 'Islamabad', '051-111222333', 'info@islamabadclinic.com', 'https://islamabadclinic.com', 33.6844, 73.0479, 'OPD, Lab, Pharmacy', '9am-9pm'),
('Neurospinal Care Clinic', 'C-7/1, Block 7, KDA Scheme 5', 'Karachi', '021-35293333', 'info@ncc.com.pk', 'https://ncc.com.pk', 24.8765, 67.0345, 'Neurology, Spine care, Radiology', '9am-6pm'),
('Health Plus Clinic', 'D-12, Block 8, Clifton', 'Karachi', '021-35371234', 'healthplus@gmail.com', NULL, 24.8149, 67.0256, 'GP, Pediatrics, Gynecology', '10am-10pm'),
('The Doctors Lounge', 'E-11 Markaz', 'Islamabad', '051-2301234', 'doctorslounge@gmail.com', NULL, 33.6883, 73.0554, 'Multi-specialty clinic', '8am-10pm'),
('Lahore Medical Center', 'Main Boulevard Gulberg', 'Lahore', '042-35781234', 'info@lmc.com.pk', 'https://lmc.com.pk', 31.5204, 74.3587, 'Full hospital services', '24/7'),
('Karachi Surgical Hospital', 'SMCHS, Shahrah-e-Faisal', 'Karachi', '021-34567890', 'info@ksh.com.pk', 'https://ksh.com.pk', 24.8765, 67.0678, 'Surgical specialties', '24/7'),
('Punjab Cardiology Center', 'MM Alam Road', 'Lahore', '042-37894561', 'info@pcc.com.pk', 'https://pcc.com.pk', 31.4789, 74.2678, 'Cardiac care unit, Cath lab', '8am-8pm'),
('Islamabad Medical Complex', 'Blue Area', 'Islamabad', '051-2345678', 'info@imc.com.pk', 'https://imc.com.pk', 33.7234, 73.0908, 'Multi-specialty hospital', '24/7'),
('Rawalpindi General Hospital', 'The Mall Road', 'Rawalpindi', '051-55667788', 'info@rgh.com.pk', NULL, 33.6007, 73.0679, 'Government hospital', '24/7'),
('Karachi Children Hospital', 'Gulshan-e-Iqbal', 'Karachi', '021-36789012', 'info@kch.com.pk', 'https://kch.com.pk', 24.9123, 67.0987, 'Pediatrics, NICU', '24/7'),
('Lahore Orthopedic Center', 'Canal Bank Road', 'Lahore', '042-34561234', 'info@loc.com.pk', NULL, 31.4890, 74.2789, 'Orthopedics, Physiotherapy', '9am-9pm'),
('Islamabad Dental Hospital', 'F-10 Markaz', 'Islamabad', '051-22334455', 'info@idh.com.pk', 'https://idh.com.pk', 33.6901, 73.0423, 'Dental specialties', '10am-8pm'),
('Karachi Heart Institute', 'Korangi Crossing', 'Karachi', '021-35456789', 'info@khi.com.pk', 'https://khi.com.pk', 24.8345, 67.1123, 'Cardiology, Cardiac surgery', '24/7'),
('Lahore Skin Center', 'Defence Phase 5', 'Lahore', '042-37894512', 'info@lsc.com.pk', NULL, 31.4678, 74.3890, 'Dermatology, Cosmetology', '11am-9pm'),
('Islamabad Eye Hospital', 'G-9 Markaz', 'Islamabad', '051-22336677', 'info@ieh.com.pk', 'https://ieh.com.pk', 33.6789, 73.0345, 'Ophthalmology', '9am-6pm'),
('Karachi Gastro Center', 'Tariq Road', 'Karachi', '021-35671234', 'info@kgc.com.pk', NULL, 24.8567, 67.0234, 'Endoscopy, Gastroenterology', '8am-10pm'),
('Lahore ENT Hospital', 'Jail Road', 'Lahore', '042-36784567', 'info@leh.com.pk', 'https://leh.com.pk', 31.5567, 74.3123, 'ENT, Audiology', '9am-9pm'),
('Islamabad Physiotherapy Center', 'F-8 Markaz', 'Islamabad', '051-23459876', 'info@ipc.com.pk', NULL, 33.7001, 73.0567, 'Physical therapy', '8am-8pm'),
('Karachi Neuro Center', 'Clifton Block 2', 'Karachi', '021-35349876', 'info@knc.com.pk', 'https://knc.com.pk', 24.8234, 67.0345, 'Neurology, Neurosurgery', '24/7'),
('Lahore Diabetes Center', 'Garden Town', 'Lahore', '042-37895678', 'info@ldc.com.pk', NULL, 31.4789, 74.2890, 'Endocrinology, Diabetes care', '9am-5pm'),
('Islamabad Women Hospital', 'G-10 Markaz', 'Islamabad', '051-25678901', 'info@iwh.com.pk', 'https://iwh.com.pk', 33.7123, 72.9876, 'Obstetrics, Gynecology', '24/7'),
('Karachi Cancer Hospital', 'North Nazimabad', 'Karachi', '021-36782345', 'info@kch.com.pk', 'https://kch.com.pk', 24.9345, 67.0456, 'Oncology, Radiotherapy', '24/7');
GO

-- Insert Doctor-Clinic relationships (for all 25 doctors)
INSERT INTO DoctorClinic (DoctorID, ClinicID, ConsultationFee, FollowUpFee, AverageRating) VALUES
(1, 1, 2000.00, 1500.00, 4.5), (2, 2, 3000.00, 2500.00, 4.7), (3, 3, 4000.00, 3500.00, 4.8),
(4, 4, 1500.00, 1200.00, 4.2), (5, 5, 5000.00, 4500.00, 4.9), (6, 6, 3500.00, 3000.00, 4.6),
(7, 7, 4500.00, 4000.00, 4.7), (8, 8, 2500.00, 2000.00, 4.3), (9, 9, 3000.00, 2500.00, 4.4),
(10, 10, 2000.00, 1800.00, 4.1), (11, 11, 2500.00, 2200.00, 4.2), (12, 12, 3500.00, 3000.00, 4.8),
(13, 13, 1800.00, 1500.00, 4.5), (14, 14, 3200.00, 2800.00, 4.6), (15, 15, 1500.00, 1200.00, 4.0),
(16, 16, 4000.00, 3500.00, 4.9), (17, 17, 2200.00, 1800.00, 4.3), (18, 18, 3800.00, 3200.00, 4.7),
(19, 19, 2000.00, 1700.00, 4.1), (20, 20, 4500.00, 4000.00, 4.4), (21, 21, 1800.00, 1500.00, 4.2),
(22, 22, 5000.00, 4500.00, 4.8), (23, 23, 1200.00, 1000.00, 3.9), (24, 24, 3500.00, 3000.00, 4.9),
(25, 25, 2000.00, 1800.00, 4.5),
-- Additional clinic associations
(1, 6, 1800.00, 1500.00, 4.3), (2, 7, 2800.00, 2400.00, 4.6), (3, 8, 3800.00, 3200.00, 4.7),
(4, 9, 1300.00, 1100.00, 4.1), (5, 10, 4500.00, 4000.00, 4.8), (6, 11, 3200.00, 2800.00, 4.5),
(7, 12, 4200.00, 3800.00, 4.6), (8, 13, 2300.00, 2000.00, 4.2), (9, 14, 2800.00, 2400.00, 4.3),
(10, 15, 1800.00, 1500.00, 4.0), (11, 16, 2200.00, 1900.00, 4.1), (12, 17, 3200.00, 2800.00, 4.7),
(13, 18, 1600.00, 1400.00, 4.4), (14, 19, 3000.00, 2600.00, 4.5), (15, 20, 1300.00, 1100.00, 3.9),
(16, 21, 3800.00, 3400.00, 4.8), (17, 22, 2000.00, 1700.00, 4.2), (18, 23, 3500.00, 3000.00, 4.6),
(19, 24, 1800.00, 1500.00, 4.0), (20, 25, 4200.00, 3800.00, 4.3), (21, 1, 1600.00, 1400.00, 4.1),
(22, 2, 4500.00, 4000.00, 4.7), (23, 3, 1100.00, 900.00, 3.8), (24, 4, 3200.00, 2800.00, 4.8),
(25, 5, 1800.00, 1600.00, 4.4);
GO

-- Insert Doctor Availability (for all doctors)
INSERT INTO DoctorAvailability (DoctorClinicID, DayOfWeek, StartTime, EndTime, SlotDurationMinutes) VALUES
-- Doctor 1
(1, 1, '09:00', '12:00', 30), (1, 1, '17:00', '20:00', 30), (26, 3, '10:00', '14:00', 30),
-- Doctor 2
(2, 2, '10:00', '13:00', 20), (2, 4, '14:00', '18:00', 20), (27, 5, '09:00', '12:00', 20),
-- Doctor 3
(3, 3, '09:00', '13:00', 30), (3, 6, '10:00', '14:00', 30), (28, 1, '15:00', '19:00', 30),
-- Doctor 4
(4, 4, '08:00', '20:00', 15), (29, 2, '11:00', '15:00', 15),
-- Doctor 5
(5, 5, '10:00', '14:00', 15), (5, 2, '16:00', '20:00', 15), (30, 4, '09:00', '13:00', 15),
-- Doctor 6
(6, 6, '14:00', '17:00', 30), (6, 3, '18:00', '21:00', 30), (31, 1, '10:00', '14:00', 30),
-- Doctor 7
(7, 7, '09:00', '12:00', 20), (7, 2, '14:00', '18:00', 20), (32, 5, '10:00', '13:00', 20),
-- Doctor 8
(8, 1, '08:00', '12:00', 30), (8, 4, '16:00', '20:00', 30), (33, 6, '11:00', '15:00', 30),
-- Doctor 9
(9, 2, '10:00', '14:00', 20), (9, 5, '15:00', '19:00', 20), (34, 3, '09:00', '13:00', 20),
-- Doctor 10
(10, 3, '11:00', '15:00', 15), (10, 6, '16:00', '20:00', 15), (35, 4, '10:00', '14:00', 15),
-- Doctor 11
(11, 4, '09:00', '13:00', 30), (11, 7, '14:00', '18:00', 30), (36, 2, '11:00', '15:00', 30),
-- Doctor 12
(12, 5, '10:00', '14:00', 20), (12, 1, '15:00', '19:00', 20), (37, 3, '09:00', '13:00', 20),
-- Doctor 13
(13, 6, '11:00', '15:00', 15), (13, 2, '16:00', '20:00', 15), (38, 4, '10:00', '14:00', 15),
-- Doctor 14
(14, 7, '09:00', '12:00', 30), (14, 3, '14:00', '18:00', 30), (39, 5, '11:00', '15:00', 30),
-- Doctor 15
(15, 1, '10:00', '14:00', 20), (15, 4, '15:00', '19:00', 20), (40, 6, '09:00', '13:00', 20),
-- Doctor 16
(16, 2, '11:00', '15:00', 15), (16, 5, '16:00', '20:00', 15), (41, 3, '10:00', '14:00', 15),
-- Doctor 17
(17, 3, '09:00', '13:00', 30), (17, 6, '14:00', '18:00', 30), (42, 1, '11:00', '15:00', 30),
-- Doctor 18
(18, 4, '10:00', '14:00', 20), (18, 7, '15:00', '19:00', 20), (43, 2, '09:00', '13:00', 20),
-- Doctor 19
(19, 5, '11:00', '15:00', 15), (19, 1, '16:00', '20:00', 15), (44, 3, '10:00', '14:00', 15),
-- Doctor 20
(20, 6, '09:00', '13:00', 30), (20, 2, '14:00', '18:00', 30), (45, 4, '11:00', '15:00', 30),
-- Doctor 21
(21, 7, '10:00', '14:00', 20), (21, 3, '15:00', '19:00', 20), (46, 5, '09:00', '13:00', 20),
-- Doctor 22
(22, 1, '11:00', '15:00', 15), (22, 4, '16:00', '20:00', 15), (47, 6, '10:00', '14:00', 15),
-- Doctor 23
(23, 2, '09:00', '13:00', 30), (23, 5, '14:00', '18:00', 30), (48, 3, '11:00', '15:00', 30),
-- Doctor 24
(24, 3, '10:00', '14:00', 20), (24, 6, '15:00', '19:00', 20), (49, 1, '09:00', '13:00', 20),
-- Doctor 25
(25, 4, '11:00', '15:00', 15), (25, 7, '16:00', '20:00', 15), (50, 2, '10:00', '14:00', 15);
GO

-- Insert Patients (1-25)
INSERT INTO Patient (FirstName, LastName, DateOfBirth, Gender, Phone, Email, Address, City, BloodGroup, MedicalHistory, Allergies) VALUES
('Ali', 'Khan', '1985-03-15', 'Male', '03001234567', 'ali.khan@example.com', 'House 45, Street 10, DHA', 'Karachi', 'B+', 'Hypertension, Diabetes Type 2', 'Penicillin'),
('Fatima', 'Ahmed', '1990-07-22', 'Female', '03011234567', 'fatima.ahmed@example.com', 'Flat 301, Gulshan Heights', 'Lahore', 'A-', 'Asthma, Migraine', 'Sulfa drugs'),
('Bilal', 'Hussain', '1978-11-05', 'Male', '03021234567', 'bilal.hussain@example.com', '12-C Model Town', 'Islamabad', 'O+', 'High cholesterol', 'Shellfish'),
('Ayesha', 'Malik', '1995-02-18', 'Female', '03031234567', 'ayesha.malik@example.com', 'Plot 78, Bahria Town', 'Rawalpindi', 'AB+', NULL, 'Peanuts'),
('Usman', 'Raza', '1982-09-30', 'Male', '03041234567', 'usman.raza@example.com', 'House 23, Street 5, Clifton', 'Karachi', 'A+', 'GERD', 'Iodine contrast'),
('Sadia', 'Iqbal', '1988-05-12', 'Female', '03051234567', 'sadia.iqbal@example.com', 'Flat 45, Phase 5 DHA', 'Lahore', 'B-', 'Hypothyroidism', NULL),
('Kamran', 'Ali', '1975-08-25', 'Male', '03061234567', 'kamran.ali@example.com', 'House 89, Street 7, F-8', 'Islamabad', 'O-', 'Hypertension', 'Aspirin'),
('Zainab', 'Khan', '1992-12-03', 'Female', '03071234567', 'zainab.khan@example.com', 'Plot 34, Bahria Town', 'Rawalpindi', 'A+', 'Anemia', 'Latex'),
('Haroon', 'Shah', '1980-04-17', 'Male', '03081234567', 'haroon.shah@example.com', 'Flat 12, Gulshan-e-Iqbal', 'Karachi', 'AB-', 'Diabetes Type 1', 'Eggs'),
('Nadia', 'Akhtar', '1998-07-29', 'Female', '03091234567', 'nadia.akhtar@example.com', 'House 56, Street 9, Model Town', 'Lahore', 'O+', NULL, 'Dust mites'),
('Omar', 'Farooq', '1972-10-11', 'Male', '03101234567', 'omar.farooq@example.com', 'Flat 78, Blue Area', 'Islamabad', 'A-', 'Heart disease', 'Bee stings'),
('Hina', 'Riaz', '1987-01-23', 'Female', '03111234567', 'hina.riaz@example.com', 'Plot 67, DHA Phase 6', 'Karachi', 'B+', 'PCOS', 'Soy'),
('Tariq', 'Mehmood', '1969-06-14', 'Male', '03121234567', 'tariq.mehmood@example.com', 'House 34, Street 3, F-10', 'Islamabad', 'O+', 'Prostate issues', NULL),
('Maria', 'Qureshi', '1993-09-07', 'Female', '03131234567', 'maria.qureshi@example.com', 'Flat 23, Gulberg III', 'Lahore', 'A+', 'Migraine', 'Nuts'),
('Jawad', 'Ahmed', '1984-02-28', 'Male', '03141234567', 'jawad.ahmed@example.com', 'House 12, Clifton Block 2', 'Karachi', 'AB+', 'Ulcerative colitis', 'Dairy'),
('Rabia', 'Hassan', '1996-11-19', 'Female', '03151234567', 'rabia.hassan@example.com', 'Plot 45, Bahria Town Phase 7', 'Rawalpindi', 'O-', NULL, 'Pollen'),
('Saad', 'Malik', '1979-04-02', 'Male', '03161234567', 'saad.malik@example.com', 'Flat 56, DHA Phase 4', 'Karachi', 'A+', 'Sleep apnea', 'Shellfish'),
('Aisha', 'Siddiqui', '1991-08-15', 'Female', '03171234567', 'aisha.siddiqui@example.com', 'House 78, Street 5, E-11', 'Islamabad', 'B-', 'Depression', 'Sulfa drugs'),
('Asim', 'Riaz', '1976-12-27', 'Male', '03181234567', 'asim.riaz@example.com', 'Plot 89, Johar Town', 'Lahore', 'AB-', 'Hypertension, Diabetes', 'Penicillin'),
('Nida', 'Khalid', '1989-05-08', 'Female', '03191234567', 'nida.khalid@example.com', 'Flat 34, Gulshan-e-Iqbal', 'Karachi', 'O+', 'Asthma', 'Dust'),
('Faisal', 'Khan', '1973-07-21', 'Male', '03201234567', 'faisal.khan@example.com', 'House 67, Street 8, F-7', 'Islamabad', 'A+', 'High cholesterol', NULL),
('Sara', 'Jamal', '1997-02-12', 'Female', '03211234567', 'sara.jamal@example.com', 'Plot 12, DHA Phase 5', 'Karachi', 'B+', 'PCOS', 'Latex'),
('Zeeshan', 'Ali', '1981-10-04', 'Male', '03221234567', 'zeeshan.ali@example.com', 'Flat 45, Gulberg II', 'Lahore', 'O-', 'Epilepsy', 'Artificial colors'),
('Hira', 'Nazir', '1994-03-26', 'Female', '03231234567', 'hira.nazir@example.com', 'House 23, Street 9, G-9', 'Islamabad', 'A-', 'Migraine', 'Chocolate'),
('Adnan', 'Rafique', '1977-09-18', 'Male', '03241234567', 'adnan.rafique@example.com', 'Plot 78, Bahria Town Phase 8', 'Rawalpindi', 'AB+', 'Diabetes Type 2', 'Eggs');
GO

-- Insert Medical History for all patients
INSERT INTO MedicalHistory (PatientID, DiseaseID, DiagnosisDate, TreatmentDetails, IsCurrent) VALUES
(1, 16, '2020-05-15', 'Amlodipine 5mg daily, Low-sodium diet, Regular exercise', 1),
(1, 18, '2019-11-20', 'Metformin 500mg twice daily, HbA1c monitoring every 3 months', 1),
(2, 5, '2018-03-10', 'Salbutamol inhaler PRN (100mcg/dose), Fluticasone 250mcg daily', 1),
(2, 4, '2021-07-22', 'Sumatriptan 50mg PRN for migraines', 1),
(3, NULL, '2021-07-22', 'Atorvastatin 20mg nightly, Mediterranean diet', 1),
(4, NULL, NULL, 'Annual physical exams only', 1),
(5, 10, '2020-09-15', 'Omeprazole 20mg daily, Dietary modifications', 1),
(6, 13, '2022-01-10', 'Levothyroxine 50mcg daily, TSH monitoring yearly', 1),
(7, 16, '2018-11-05', 'Losartan 50mg daily, Regular BP monitoring', 1),
(8, 15, '2021-05-18', 'Iron supplements, Dietary changes', 1),
(9, 17, '2015-03-22', 'Insulin regimen, Carbohydrate counting', 1),
(10, NULL, NULL, 'No significant medical history', 1),
(11, 12, '2019-08-14', 'Atorvastatin 40mg, Low-fat diet, Regular exercise', 1),
(12, 24, '2020-12-03', 'Oral contraceptives for PCOS management', 1),
(13, 25, '2021-06-29', 'Tamsulosin 0.4mg daily, Annual PSA screening', 1),
(14, 4, '2019-04-17', 'Propranolol 40mg daily for migraine prevention', 1),
(15, 19, '2022-02-11', 'Mesalamine 1.2g daily, Regular colonoscopies', 1),
(16, NULL, NULL, 'No chronic conditions', 1),
(17, 21, '2020-10-05', 'CPAP therapy for sleep apnea', 1),
(18, 14, '2021-09-28', 'Sertraline 50mg daily, Cognitive behavioral therapy', 1),
(19, 16, '2017-07-15', 'Amlodipine 10mg + Metoprolol 50mg daily', 1),
(19, 18, '2018-04-22', 'Metformin 1000mg + Glimepiride 2mg daily', 1),
(20, 5, '2019-11-30', 'Budesonide-formoterol inhaler 160/4.5mcg twice daily', 1),
(21, NULL, '2022-01-10', 'Rosuvastatin 10mg daily for high cholesterol', 1),
(22, 24, '2021-08-19', 'Combined oral contraceptives for PCOS', 1),
(23, 11, '2016-05-14', 'Levetiracetam 500mg twice daily, Regular EEG monitoring', 1),
(24, 4, '2020-07-03', 'Topiramate 50mg daily for migraine prevention', 1),
(25, 18, '2019-12-15', 'Metformin 850mg twice daily, Lifestyle modifications', 1);
GO

-- Insert Precautions (1-25)
INSERT INTO Precaution (PrecautionText, Category, IsMedical, EffectivenessRating) VALUES
('Maintain adequate hydration (2-3 liters daily unless contraindicated)', 'General', 0, 5),
('Ensure 7-9 hours of quality sleep nightly', 'General', 0, 5),
('Practice regular hand hygiene with soap for 20+ seconds', 'Infectious', 0, 5),
('Use proper respiratory etiquette (cover coughs/sneezes)', 'Respiratory', 0, 5),
('Adhere to prescribed medication schedule without skipping doses', 'General', 1, 5),
('Maintain balanced diet rich in fruits and vegetables', 'Nutrition', 0, 4),
('Engage in regular physical activity (150 mins/week)', 'Exercise', 0, 5),
('Avoid tobacco in all forms', 'Lifestyle', 0, 5),
('Limit alcohol consumption', 'Lifestyle', 0, 4),
('Practice stress management techniques', 'Mental Health', 0, 4),
('Use mosquito repellents and nets in endemic areas', 'Infectious', 0, 5),
('Wear masks in crowded places during outbreaks', 'Infectious', 0, 5),
('Maintain healthy weight (BMI 18.5-24.9)', 'General', 0, 5),
('Limit processed and high-sugar foods', 'Nutrition', 0, 4),
('Practice safe food handling and preparation', 'Food Safety', 0, 5),
('Get recommended vaccinations on schedule', 'Preventive', 1, 5),
('Use sunscreen (SPF 30+) when outdoors', 'Dermatological', 0, 5),
('Practice good posture and ergonomics', 'Musculoskeletal', 0, 4),
('Limit screen time and take regular breaks', 'Eye Care', 0, 3),
('Monitor blood pressure regularly if hypertensive', 'Cardiovascular', 1, 5),
('Check blood sugar regularly if diabetic', 'Endocrine', 1, 5),
('Practice safe sex and use protection', 'Reproductive', 0, 5),
('Get regular health screenings as recommended', 'Preventive', 1, 5),
('Limit caffeine intake, especially with anxiety', 'Mental Health', 0, 3),
('Create allergen-free environment if with allergies', 'Allergy', 0, 5);
GO

-- Insert Disease Precautions (for all diseases)
INSERT INTO DiseasePrecaution (DiseaseID, PrecautionID, Priority, ScientificEvidence) VALUES
-- Flu
(1, 1, 1, 'Strong'), (1, 2, 2, 'Strong'), (1, 4, 3, 'Strong'), (1, 3, 4, 'Strong'),
-- COVID-19
(2, 3, 1, 'Strong'), (2, 4, 1, 'Strong'), (2, 12, 2, 'Strong'), (2, 1, 3, 'Moderate'),
-- UTI
(3, 1, 1, 'Strong'), (3, 15, 2, 'Moderate'), (3, 3, 3, 'Moderate'),
-- Migraine
(4, 2, 1, 'Moderate'), (4, 10, 2, 'Moderate'), (4, 24, 3, 'Moderate'),
-- Asthma
(5, 7, 1, 'Strong'), (5, 10, 2, 'Moderate'), (5, 19, 3, 'Moderate'),
-- Typhoid
(6, 15, 1, 'Strong'), (6, 11, 2, 'Strong'), (6, 3, 3, 'Strong'),
-- Psoriasis
(7, 17, 1, 'Strong'), (7, 10, 2, 'Moderate'), (7, 2, 3, 'Moderate'),
-- Tuberculosis
(8, 3, 1, 'Strong'), (8, 4, 1, 'Strong'), (8, 12, 2, 'Strong'),
-- Sinusitis
(9, 4, 1, 'Moderate'), (9, 1, 2, 'Moderate'), (9, 3, 3, 'Moderate'),
-- Bronchitis
(10, 4, 1, 'Strong'), (10, 3, 2, 'Strong'), (10, 8, 3, 'Strong'),
-- Dengue
(11, 11, 1, 'Strong'), (11, 1, 2, 'Strong'), (11, 2, 3, 'Moderate'),
-- Pneumonia
(12, 16, 1, 'Strong'), (12, 4, 2, 'Strong'), (12, 3, 3, 'Strong'),
-- Hepatitis B
(13, 16, 1, 'Strong'), (13, 22, 2, 'Strong'), (13, 9, 3, 'Moderate'),
-- Epilepsy
(14, 5, 1, 'Strong'), (14, 2, 2, 'Moderate'), (14, 10, 3, 'Moderate'),
-- Anemia
(15, 6, 1, 'Strong'), (15, 14, 2, 'Moderate'), (15, 7, 3, 'Moderate'),
-- Hypertension
(16, 6, 1, 'Strong'), (16, 7, 2, 'Strong'), (16, 8, 3, 'Strong'),
-- Diabetes Type 1
(17, 5, 1, 'Strong'), (17, 6, 2, 'Strong'), (17, 7, 3, 'Strong'),
-- Diabetes Type 2
(18, 6, 1, 'Strong'), (18, 7, 2, 'Strong'), (18, 13, 3, 'Strong'),
-- Gastroenteritis
(19, 15, 1, 'Strong'), (19, 1, 2, 'Strong'), (19, 3, 3, 'Strong'),
-- Appendicitis
(20, 15, 1, 'Moderate'), (20, 6, 2, 'Moderate'),
-- Meningitis
(21, 16, 1, 'Strong'), (21, 3, 2, 'Strong'), (21, 4, 3, 'Strong'),
-- Measles
(22, 16, 1, 'Strong'), (22, 3, 2, 'Strong'), (22, 4, 3, 'Strong'),
-- Jaundice
(23, 9, 1, 'Strong'), (23, 6, 2, 'Moderate'), (23, 1, 3, 'Moderate'),
-- Arthritis
(24, 7, 1, 'Strong'), (24, 18, 2, 'Strong'), (24, 13, 3, 'Moderate'),
-- Tonsillitis
(25, 3, 1, 'Strong'), (25, 4, 2, 'Strong'), (25, 16, 3, 'Moderate');
GO

-- Insert Medications (1-25)
INSERT INTO Medication (GenericName, BrandName, DosageForm, Strength, TherapeuticCategory, RequiresPrescription, Manufacturer) VALUES
('Paracetamol', 'Panadol', 'Tablet', '500mg', 'Analgesic/Antipyretic', 0, 'GSK'),
('Ibuprofen', 'Brufen', 'Tablet', '400mg', 'NSAID', 0, 'Abbott'),
('Amoxicillin', 'Amoxil', 'Capsule', '500mg', 'Antibiotic', 1, 'GSK'),
('Salbutamol', 'Ventolin', 'Inhaler', '100mcg/dose', 'Bronchodilator', 1, 'GSK'),
('Amlodipine', 'Norvasc', 'Tablet', '5mg', 'Calcium Channel Blocker', 1, 'Pfizer'),
('Metformin', 'Glucophage', 'Tablet', '500mg', 'Antidiabetic', 1, 'Merck'),
('Atorvastatin', 'Lipitor', 'Tablet', '20mg', 'Statin', 1, 'Pfizer'),
('Omeprazole', 'Losec', 'Capsule', '20mg', 'PPI', 1, 'AstraZeneca'),
('Sumatriptan', 'Imigran', 'Tablet', '50mg', 'Antimigraine', 1, 'GSK'),
('Levothyroxine', 'Synthroid', 'Tablet', '50mcg', 'Thyroid Hormone', 1, 'Abbott'),
('Losartan', 'Cozaar', 'Tablet', '50mg', 'ARB', 1, 'Merck'),
('Iron Supplement', 'Fero-Grad', 'Tablet', '325mg', 'Mineral Supplement', 0, 'Abbott'),
('Insulin Glargine', 'Lantus', 'Injection', '100IU/ml', 'Insulin', 1, 'Sanofi'),
('Rosuvastatin', 'Crestor', 'Tablet', '10mg', 'Statin', 1, 'AstraZeneca'),
('Ethinylestradiol + Drospirenone', 'Yasmin', 'Tablet', '0.03mg/3mg', 'Oral Contraceptive', 1, 'Bayer'),
('Tamsulosin', 'Flomax', 'Capsule', '0.4mg', 'Alpha Blocker', 1, 'Boehringer'),
('Propranolol', 'Inderal', 'Tablet', '40mg', 'Beta Blocker', 1, 'AstraZeneca'),
('Mesalamine', 'Asacol', 'Tablet', '1.2g', 'Anti-inflammatory', 1, 'Tillotts'),
('Sertraline', 'Zoloft', 'Tablet', '50mg', 'SSRI', 1, 'Pfizer'),
('Budesonide + Formoterol', 'Symbicort', 'Inhaler', '160mcg/4.5mcg', 'ICS + LABA', 1, 'AstraZeneca'),
('Levetiracetam', 'Keppra', 'Tablet', '500mg', 'Antiepileptic', 1, 'UCB'),
('Topiramate', 'Topamax', 'Tablet', '50mg', 'Antiepileptic', 1, 'Janssen'),
('Glimepiride', 'Amaryl', 'Tablet', '2mg', 'Sulfonylurea', 1, 'Sanofi'),
('Metoprolol', 'Lopressor', 'Tablet', '50mg', 'Beta Blocker', 1, 'Novartis'),
('Cetirizine', 'Zyrtec', 'Tablet', '10mg', 'Antihistamine', 0, 'Johnson & Johnson');
GO

-- Insert Diagnoses (for all patients)
INSERT INTO Diagnosis (PatientID, DiseaseID, ConfidenceLevel, Notes, IsFinalDiagnosis, CreatedBy) VALUES
(1, 16, 0.95, 'Primary hypertension diagnosed based on repeated elevated BP readings', 1, 1),
(1, 18, 0.90, 'Type 2 diabetes confirmed with HbA1c 7.5%', 1, 1),
(2, 5, 0.85, 'Mild persistent asthma confirmed with spirometry', 1, 2),
(2, 4, 0.80, 'Migraine without aura based on history and symptoms', 1, 4),
(3, NULL, 0.70, 'Hypercholesterolemia with LDL 160mg/dL', 1, 5),
(4, NULL, NULL, 'Routine checkup - no abnormalities detected', 1, 6),
(5, 10, 0.88, 'GERD diagnosed based on symptoms and response to PPI', 1, 10),
(6, 13, 0.92, 'Hypothyroidism with TSH 8.2 mIU/L', 1, 13),
(7, 16, 0.94, 'Stage 1 hypertension', 1, 12),
(8, 15, 0.85, 'Iron deficiency anemia with Hb 9.8 g/dL', 1, 17),
(9, 17, 0.98, 'Type 1 diabetes with positive autoantibodies', 1, 13),
(10, NULL, NULL, 'Annual physical - healthy', 1, 1),
(11, 12, 0.90, 'Coronary artery disease with LDL 180mg/dL', 1, 12),
(12, 24, 0.85, 'PCOS with irregular cycles and ultrasound findings', 1, 18),
(13, 25, 0.80, 'BPH with IPSS score 18', 1, 3),
(14, 4, 0.82, 'Migraine with aura, 4-6 episodes/month', 1, 4),
(15, 19, 0.88, 'Ulcerative colitis confirmed with colonoscopy', 1, 10),
(16, NULL, NULL, 'Well woman exam - normal', 1, 18),
(17, 21, 0.92, 'Obstructive sleep apnea with AHI 22', 1, 23),
(18, 14, 0.85, 'Major depressive disorder, recurrent', 1, 14),
(19, 16, 0.94, 'Hypertension stage 2', 1, 12),
(19, 18, 0.90, 'Type 2 diabetes with HbA1c 8.2%', 1, 13),
(20, 5, 0.86, 'Moderate persistent asthma', 1, 8),
(21, NULL, 0.75, 'Hyperlipidemia with total cholesterol 240mg/dL', 1, 12),
(22, 24, 0.84, 'PCOS with hirsutism and oligomenorrhea', 1, 18),
(23, 11, 0.95, 'Generalized epilepsy with tonic-clonic seizures', 1, 4),
(24, 4, 0.82, 'Chronic migraine with 8 headache days/month', 1, 4),
(25, 18, 0.89, 'Type 2 diabetes with HbA1c 7.8%', 1, 13);
GO

-- Insert Prescriptions (for all diagnoses)
INSERT INTO Prescription (DiagnosisID, MedicationID, Dosage, Frequency, Duration, Instructions) VALUES
(1, 5, '5mg', 'Once daily', '30 days', 'Take in morning with water. Avoid grapefruit. Monitor BP weekly.'),
(2, 6, '500mg', 'Twice daily', '30 days', 'Take with meals. Watch for lactic acidosis symptoms.'),
(3, 4, '2 puffs', 'Every 4-6 hours as needed', '90 days', 'Use spacer. Rinse mouth after use to prevent thrush.'),
(4, 9, '50mg', 'At onset of migraine', '10 tablets', 'Take at first sign of headache. Max 200mg/24hr.'),
(5, 7, '20mg', 'At bedtime', '30 days', 'Take in evening. Report muscle pain immediately.'),
(7, 5, '5mg', 'Once daily', '30 days', 'Monitor BP. Report swelling or palpitations.'),
(8, 12, '325mg', 'Once daily', '60 days', 'Take with orange juice. May cause dark stools.'),
(9, 17, '50mg', 'Once daily', '30 days', 'Take in morning. Do not stop abruptly.'),
(10, 11, '50mg', 'Once daily', '30 days', 'Monitor BP. Stay hydrated.'),
(11, 13, '20 units', 'At bedtime', '30 days', 'Inject subcutaneously in abdomen or thigh.'),
(12, 14, '10mg', 'At bedtime', '30 days', 'Avoid grapefruit. Report muscle pain.'),
(13, 15, '1 tablet', 'Daily', '21 days', 'Take at same time daily. 7-day break after pack.'),
(14, 16, '0.4mg', 'Once daily', '30 days', 'Take after evening meal. May cause dizziness.'),
(15, 17, '40mg', 'Once daily', '30 days', 'Take in morning. Monitor pulse.'),
(16, 18, '1.2g', 'Three times daily', '60 days', 'Take with water. Do not crush tablets.'),
(17, 19, '50mg', 'Once daily', '30 days', 'Take in morning. May take 4-6 weeks for full effect.'),
(19, 5, '10mg', 'Once daily', '30 days', 'Monitor BP. Report swelling.'),
(20, 6, '1000mg', 'Twice daily', '30 days', 'Take with meals. Avoid alcohol.'),
(21, 20, '2 puffs', 'Twice daily', '90 days', 'Rinse mouth after use to prevent thrush.'),
(22, 14, '10mg', 'At bedtime', '30 days', 'Avoid grapefruit. Report muscle pain.'),
(23, 21, '500mg', 'Twice daily', '30 days', 'Do not stop abruptly. May cause drowsiness.'),
(24, 22, '50mg', 'At bedtime', '30 days', 'May cause tingling or weight loss.'),
(25, 6, '850mg', 'Twice daily', '30 days', 'Take with meals. Avoid excessive alcohol.');
GO

-- Insert Remedies (for all diseases)
INSERT INTO Remedy (DiseaseID, RemedyText, Category, EvidenceLevel) VALUES
(1, 'Increase fluid intake (warm herbal teas, broth) to prevent dehydration', 'Hydration', 'Strong'),
(1, 'Rest and sleep 8-10 hours daily to support immune function', 'Lifestyle', 'Strong'),
(2, 'Isolate for minimum 5 days from symptom onset + 24hr fever-free', 'Infection Control', 'Strong'),
(2, 'Prone positioning if experiencing breathing difficulties', 'Respiratory Support', 'Moderate'),
(3, 'Increase water intake to flush out bacteria', 'Hydration', 'Moderate'),
(3, 'Drink unsweetened cranberry juice (may prevent bacterial adhesion)', 'Nutrition', 'Limited'),
(4, 'Apply cold compress to forehead or neck during migraine', 'Symptom Relief', 'Moderate'),
(4, 'Rest in quiet, dark room during attacks', 'Environment', 'Strong'),
(5, 'Breathing exercises (pursed-lip breathing) during attacks', 'Respiratory', 'Moderate'),
(5, 'Identify and avoid personal asthma triggers', 'Prevention', 'Strong'),
(6, 'Oral rehydration solution to prevent dehydration', 'Hydration', 'Strong'),
(6, 'Bland diet (BRAT - bananas, rice, applesauce, toast)', 'Nutrition', 'Moderate'),
(7, 'Moisturize skin regularly with fragrance-free creams', 'Skin Care', 'Strong'),
(7, 'Short, lukewarm showers (hot water worsens dryness)', 'Bathing', 'Moderate'),
(8, 'Complete full course of antibiotics as prescribed', 'Medication', 'Strong'),
(8, 'Cover mouth when coughing, dispose tissues properly', 'Infection Control', 'Strong'),
(9, 'Steam inhalation with warm water (may relieve congestion)', 'Respiratory', 'Limited'),
(9, 'Stay hydrated to thin mucus secretions', 'Hydration', 'Moderate'),
(10, 'Humidify air to ease breathing', 'Environment', 'Moderate'),
(10, 'Avoid smoke and other lung irritants', 'Prevention', 'Strong'),
(11, 'Papaya leaf extract (may help increase platelet count)', 'Herbal', 'Limited'),
(11, 'Stay well-hydrated to manage fever', 'Hydration', 'Strong'),
(12, 'Practice deep breathing exercises to expand lungs', 'Respiratory', 'Moderate'),
(12, 'Get pneumococcal and flu vaccines as recommended', 'Prevention', 'Strong'),
(13, 'Avoid alcohol to protect liver', 'Lifestyle', 'Strong'),
(13, 'Eat balanced diet with adequate protein', 'Nutrition', 'Moderate'),
(14, 'Maintain regular sleep schedule to prevent seizures', 'Lifestyle', 'Moderate'),
(14, 'Wear medical alert bracelet with condition info', 'Safety', 'Strong'),
(15, 'Iron-rich foods (red meat, spinach, lentils) if deficient', 'Nutrition', 'Strong'),
(15, 'Vitamin C with iron meals to enhance absorption', 'Nutrition', 'Moderate'),
(16, 'DASH diet (rich in fruits, vegetables, low-fat dairy)', 'Nutrition', 'Strong'),
(16, 'Limit sodium to <2g/day', 'Nutrition', 'Strong'),
(17, 'Regular blood glucose monitoring', 'Self-Care', 'Strong'),
(17, 'Carbohydrate counting for meal planning', 'Nutrition', 'Strong'),
(18, 'Portion control and balanced meals', 'Nutrition', 'Strong'),
(18, '150 mins moderate exercise weekly', 'Exercise', 'Strong'),
(19, 'BRAT diet during acute phase (bananas, rice, applesauce, toast)', 'Nutrition', 'Moderate'),
(19, 'Oral rehydration solutions to prevent dehydration', 'Hydration', 'Strong'),
(20, 'Seek immediate medical care for severe abdominal pain', 'Emergency', 'Strong'),
(21, 'Meningitis is medical emergency - seek immediate care', 'Emergency', 'Strong'),
(22, 'Isolate until 4 days after rash appears', 'Infection Control', 'Strong'),
(23, 'Monitor for pale stools or dark urine (signs of worsening)', 'Monitoring', 'Strong'),
(24, 'Low-impact exercise (swimming, cycling) for joint mobility', 'Exercise', 'Strong'),
(25, 'Saltwater gargles for throat pain relief', 'Symptom Relief', 'Moderate');
GO

-- Insert Appointments (for all patients)
INSERT INTO Appointment (
    PatientID, 
    DoctorID, 
    ClinicID,
    ScheduledDateTime, 
    EndDateTime,
    Purpose, 
    Status, 
    ConsultationFee,
    DiagnosisID,
    CalendarEventID,
    PatientRating,
    DoctorFeedback
) VALUES
(1, 1, 1, '2023-01-10 10:00:00', '2023-01-10 10:30:00', 'Hypertension follow-up', 'Completed', 2000, 1, 'CAL123', 4, 'Patient compliant with medications'),
(1, 13, 5, '2023-02-15 14:30:00', '2023-02-15 15:00:00', 'Diabetes management', 'Completed', 3500, 2, 'CAL124', 5, 'Needs to improve dietary habits'),
(2, 8, 3, '2023-01-12 11:00:00', '2023-01-12 11:30:00', 'Asthma checkup', 'Completed', 2500, 3, 'CAL125', 4, 'Proper inhaler technique demonstrated'),
(2, 4, 7, '2023-03-05 09:30:00', '2023-03-05 10:00:00', 'Migraine evaluation', 'Completed', 3000, 4, 'CAL126', 4, 'Frequency of headaches decreasing'),
(3, 12, 2, '2023-02-20 16:00:00', '2023-02-20 16:30:00', 'Cholesterol review', 'Completed', 2800, 5, 'CAL127', 5, 'LDL levels improved with statin'),
(4, 1, 6, '2023-01-25 12:00:00', '2023-01-25 12:30:00', 'Annual physical', 'Completed', 1500, 6, 'CAL128', 5, 'Healthy patient, no concerns'),
(5, 10, 10, '2023-02-10 15:00:00', '2023-02-10 15:30:00', 'GERD symptoms', 'Completed', 2200, 7, 'CAL129', 4, 'Responding well to PPI therapy'),
(6, 13, 15, '2023-03-15 10:30:00', '2023-03-15 11:00:00', 'Hypothyroidism follow-up', 'Completed', 1800, 8, 'CAL130', 4, 'TSH within normal range'),
(7, 12, 12, '2023-01-18 14:00:00', '2023-01-18 14:30:00', 'BP check', 'Completed', 2000, 9, 'CAL131', 5, 'BP well controlled on current regimen'),
(8, 17, 17, '2023-02-22 11:30:00', '2023-02-22 12:00:00', 'Anemia follow-up', 'Completed', 1900, 10, 'CAL132', 4, 'Hemoglobin improving with iron'),
(9, 13, 13, '2023-03-08 09:00:00', '2023-03-08 09:30:00', 'Diabetes education', 'Completed', 2500, 11, 'CAL133', 5, 'Good understanding of carb counting'),
(10, 1, 1, '2023-01-30 13:00:00', '2023-01-30 13:30:00', 'Routine checkup', 'Completed', 1500, 12, 'CAL134', 5, 'No health issues identified'),
(11, 12, 12, '2023-02-14 16:30:00', '2023-02-14 17:00:00', 'Cardiac risk assessment', 'Completed', 3000, 13, 'CAL135', 4, 'Statin therapy initiated'),
(12, 18, 18, '2023-03-20 10:00:00', '2023-03-20 10:30:00', 'PCOS management', 'Completed', 2200, 14, 'CAL136', 4, 'Regular cycles on OCPs'),
(13, 3, 8, '2023-01-15 15:30:00', '2023-01-15 16:00:00', 'BPH symptoms', 'Completed', 2800, 15, 'CAL137', 5, 'IPSS score improved with medication'),
(14, 4, 4, '2023-02-28 14:00:00', '2023-02-28 14:30:00', 'Migraine prevention', 'Completed', 2500, 16, 'CAL138', 4, 'Reduction in headache frequency'),
(15, 10, 19, '2023-03-12 11:00:00', '2023-03-12 11:30:00', 'UC flare-up', 'Completed', 2300, 17, 'CAL139', 4, 'Responding to mesalamine'),
(16, 18, 24, '2023-01-20 12:30:00', '2023-01-20 13:00:00', 'Annual exam', 'Completed', 1800, 18, 'CAL140', 5, 'Normal exam, Pap smear done'),
(17, 23, 22, '2023-02-25 09:30:00', '2023-02-25 10:00:00', 'Sleep study follow-up', 'Completed', 3200, 19, 'CAL141', 4, 'Tolerating CPAP well'),
(18, 14, 14, '2023-03-18 16:00:00', '2023-03-18 16:30:00', 'Depression follow-up', 'Completed', 2500, 20, 'CAL142', 4, 'Mood improved with medication'),
(19, 12, 16, '2023-01-05 10:30:00', '2023-01-05 11:00:00', 'Hypertension + diabetes', 'Completed', 3500, 21, 'CAL143', 5, 'BP and sugars at target'),
(19, 13, 13, '2023-02-08 14:30:00', '2023-02-08 15:00:00', 'Diabetes follow-up', 'Completed', 2800, 22, 'CAL144', 4, 'HbA1c improving but needs better diet'),
(20, 8, 8, '2023-03-22 11:30:00', '2023-03-22 12:00:00', 'Asthma control', 'Completed', 2400, 23, 'CAL145', 5, 'Good inhaler technique'),
(21, 12, 12, '2023-01-28 15:00:00', '2023-01-28 15:30:00', 'High cholesterol', 'Completed', 2000, 24, 'CAL146', 4, 'Starting statin therapy'),
(22, 18, 18, '2023-02-18 10:00:00', '2023-02-18 10:30:00', 'PCOS follow-up', 'Completed', 2200, 25, 'CAL147', 4, 'Regular cycles on treatment'),
(23, 4, 4, '2023-03-25 13:30:00', '2023-03-25 14:00:00', 'Seizure control', 'Completed', 3000, 26, 'CAL148', 5, 'No seizures in 6 months'),
(24, 4, 4, '2023-01-08 16:30:00', '2023-01-08 17:00:00', 'Migraine prevention', 'Completed', 2500, 27, 'CAL149', 4, 'Topiramate effective but causing tingling'),
(25, 13, 13, '2023-02-20 09:00:00', '2023-02-20 09:30:00', 'Diabetes education', 'Completed', 2000, 28, 'CAL150', 5, 'Understanding diet modifications well');
GO
