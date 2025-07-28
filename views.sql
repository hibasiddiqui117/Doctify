
-- Create views for common queries
CREATE VIEW vw_DoctorSchedule AS
SELECT 
    d.DoctorID,
    d.FirstName + ' ' + d.LastName AS DoctorName,
    ds.SpecialtyName,
    c.ClinicName,
    c.City,
    da.DayOfWeek,
    da.StartTime,
    da.EndTime,
    dc.ConsultationFee
FROM Doctor d
JOIN DoctorSpecialtyMapping dsm ON d.DoctorID = dsm.DoctorID
JOIN DoctorSpecialty ds ON dsm.SpecialtyID = ds.SpecialtyID
JOIN DoctorClinic dc ON d.DoctorID = dc.DoctorID
JOIN Clinic c ON dc.ClinicID = c.ClinicID
JOIN DoctorAvailability da ON dc.DoctorClinicID = da.DoctorClinicID
WHERE d.IsActive = 1 AND dc.IsActive = 1 AND da.IsActive = 1;
GO

CREATE VIEW vw_PatientMedicalHistory AS
SELECT 
    p.PatientID,
    p.FirstName + ' ' + p.LastName AS PatientName,
    p.DateOfBirth,
    p.BloodGroup,
    d.DiseaseName,
    mh.DiagnosisDate,
    mh.TreatmentDetails,
    mh.IsCurrent
FROM Patient p
LEFT JOIN MedicalHistory mh ON p.PatientID = mh.PatientID
LEFT JOIN Disease d ON mh.DiseaseID = d.DiseaseID;
GO

CREATE VIEW vw_AppointmentDetails AS
SELECT 
    a.AppointmentID,
    p.FirstName + ' ' + p.LastName AS PatientName,
    doc.FirstName + ' ' + doc.LastName AS DoctorName,
    ds.SpecialtyName,
    c.ClinicName,
    a.ScheduledDateTime,
    a.EndDateTime,
    a.Status,
    a.Purpose,
    a.ConsultationFee,
    d.DiseaseName AS Diagnosis,  -- Changed from diag.DiseaseName to d.DiseaseName
    a.PatientRating
FROM Appointment a
JOIN Patient p ON a.PatientID = p.PatientID
JOIN Doctor doc ON a.DoctorID = doc.DoctorID
JOIN DoctorSpecialtyMapping dsm ON doc.DoctorID = dsm.DoctorID AND dsm.IsPrimary = 1
JOIN DoctorSpecialty ds ON dsm.SpecialtyID = ds.SpecialtyID
JOIN Clinic c ON a.ClinicID = c.ClinicID
LEFT JOIN Diagnosis diag ON a.DiagnosisID = diag.DiagnosisID
LEFT JOIN Disease d ON diag.DiseaseID = d.DiseaseID;  -- Added this join to get DiseaseName
GO
