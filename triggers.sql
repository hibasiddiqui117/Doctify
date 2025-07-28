-- Create indexes for performance optimization
CREATE INDEX IX_Patient_Email ON Patient(Email);
CREATE INDEX IX_Patient_Phone ON Patient(Phone);
CREATE INDEX IX_Appointment_PatientID ON Appointment(PatientID);
CREATE INDEX IX_Appointment_DoctorID ON Appointment(DoctorID);
CREATE INDEX IX_Appointment_Status ON Appointment(Status);
CREATE INDEX IX_Appointment_DateTime ON Appointment(ScheduledDateTime, EndDateTime);
CREATE INDEX IX_Diagnosis_PatientID ON Diagnosis(PatientID);
CREATE INDEX IX_Diagnosis_DiseaseID ON Diagnosis(DiseaseID);
CREATE INDEX IX_Doctor_Specialty ON DoctorSpecialtyMapping(SpecialtyID);
CREATE INDEX IX_DoctorClinic_Clinic ON DoctorClinic(ClinicID);
GO


-- Create triggers for audit logging
CREATE TRIGGER trg_Patient_Audit
ON Patient
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ActionType NVARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @ActionType = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @ActionType = 'INSERT';
    ELSE
        SET @ActionType = 'DELETE';
    
    -- For updates and inserts, log the new values
    IF @ActionType IN ('INSERT', 'UPDATE')
    BEGIN
        INSERT INTO AuditLog (TableName, RecordID, ActionType, NewValues, ChangedBy, ChangeDate)
        SELECT 
            'Patient',
            i.PatientID,
            @ActionType,
            (SELECT 
                i.PatientID AS PatientID,
                i.FirstName,
                i.LastName,
                i.DateOfBirth,
                i.Gender,
                i.Phone,
                i.Email,
                i.Address,
                i.City,
                i.BloodGroup,
                i.IsActive
             FOR JSON PATH),
            i.ModifiedBy,
            GETDATE()
        FROM inserted i;
    END;
    
    -- For updates and deletes, log the old values
    IF @ActionType IN ('UPDATE', 'DELETE')
    BEGIN
        INSERT INTO AuditLog (TableName, RecordID, ActionType, OldValues, ChangedBy, ChangeDate)
        SELECT 
            'Patient',
            d.PatientID,
            @ActionType,
            (SELECT 
                d.PatientID AS PatientID,
                d.FirstName,
                d.LastName,
                d.DateOfBirth,
                d.Gender,
                d.Phone,
                d.Email,
                d.Address,
                d.City,
                d.BloodGroup,
                d.IsActive
             FOR JSON PATH),
            SYSTEM_USER,
            GETDATE()
        FROM deleted d;
    END;
END;
GO

CREATE TRIGGER trg_Appointment_Audit
ON Appointment
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ActionType NVARCHAR(20);
    
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
        SET @ActionType = 'UPDATE';
    ELSE IF EXISTS (SELECT * FROM inserted)
        SET @ActionType = 'INSERT';
    ELSE
        SET @ActionType = 'DELETE';
    
    -- For updates and inserts, log the new values
    IF @ActionType IN ('INSERT', 'UPDATE')
    BEGIN
        INSERT INTO AuditLog (TableName, RecordID, ActionType, NewValues, ChangedBy, ChangeDate)
        SELECT 
            'Appointment',
            i.AppointmentID,
            @ActionType,
            (SELECT 
                i.AppointmentID,
                i.PatientID,
                i.DoctorID,
                i.ClinicID,
                i.ScheduledDateTime,
                i.EndDateTime,
                i.Status,
                i.Purpose,
                i.ConsultationFee,
                i.DiagnosisID,
                i.PatientRating
             FOR JSON PATH),
            SYSTEM_USER,
            GETDATE()
        FROM inserted i;
    END;
    
    -- For updates and deletes, log the old values
    IF @ActionType IN ('UPDATE', 'DELETE')
    BEGIN
        INSERT INTO AuditLog (TableName, RecordID, ActionType, OldValues, ChangedBy, ChangeDate)
        SELECT 
            'Appointment',
            d.AppointmentID,
            @ActionType,
            (SELECT 
                d.AppointmentID,
                d.PatientID,
                d.DoctorID,
                d.ClinicID,
                d.ScheduledDateTime,
                d.EndDateTime,
                d.Status,
                d.Purpose,
                d.ConsultationFee,
                d.DiagnosisID,
                d.PatientRating
             FOR JSON PATH),
            SYSTEM_USER,
            GETDATE()
        FROM deleted d;
    END;
END;
GO

PRINT 'Database setup completed successfully with 25 records in each table';
GO