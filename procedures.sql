-- 1. Search Doctors by Specialty
CREATE PROCEDURE sp_SearchDoctorsBySpecialty
    @SpecialtyID INT = NULL,
    @City NVARCHAR(50) = NULL,
    @MinRating DECIMAL(3,1) = NULL,
    @MaxFee DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        d.DoctorID,
        d.FirstName + ' ' + d.LastName AS DoctorName,
        d.YearsOfExperience,
        d.Rating,
        ds.SpecialtyName,
        c.ClinicName,
        c.Address,
        c.City,
        c.Phone,
        dc.ConsultationFee,
        dc.FollowUpFee,
        (SELECT STRING_AGG(CONVERT(NVARCHAR, da.DayOfWeek) + ': ' + 
                CONVERT(NVARCHAR, da.StartTime, 108) + ' - ' + 
                CONVERT(NVARCHAR, da.EndTime, 108), ', ')
         FROM DoctorAvailability da
         WHERE da.DoctorClinicID = dc.DoctorClinicID AND da.IsActive = 1) AS Availability
    FROM Doctor d
    JOIN DoctorSpecialtyMapping dsm ON d.DoctorID = dsm.DoctorID
    JOIN DoctorSpecialty ds ON dsm.SpecialtyID = ds.SpecialtyID
    JOIN DoctorClinic dc ON d.DoctorID = dc.DoctorID
    JOIN Clinic c ON dc.ClinicID = c.ClinicID
    WHERE (ds.SpecialtyID = @SpecialtyID OR @SpecialtyID IS NULL)
      AND (c.City = @City OR @City IS NULL)
      AND (d.Rating >= @MinRating OR @MinRating IS NULL)
      AND (dc.ConsultationFee <= @MaxFee OR @MaxFee IS NULL)
      AND d.IsActive = 1
      AND dc.IsActive = 1
    ORDER BY ds.SpecialtyName, d.Rating DESC;
END;
GO

-- 2. Book Appointment
CREATE PROCEDURE sp_BookAppointment
    @PatientID INT,
    @DoctorID INT,
    @ClinicID INT,
    @AppointmentDateTime DATETIME,
    @Purpose NVARCHAR(255) = NULL,
    @CalendarEventID NVARCHAR(100) = NULL,
    @AppointmentID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @SlotDuration INT = 30; -- Default 30 minutes
    DECLARE @ConsultationFee DECIMAL(10,2);
    DECLARE @EndDateTime DATETIME;
    DECLARE @Result INT = 0;
    DECLARE @DoctorClinicID INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Get doctor-clinic relationship and consultation fee
        SELECT @DoctorClinicID = DoctorClinicID, @ConsultationFee = ConsultationFee
        FROM DoctorClinic
        WHERE DoctorID = @DoctorID 
          AND ClinicID = @ClinicID
          AND IsActive = 1;
        
        IF @DoctorClinicID IS NULL
        BEGIN
            SET @Result = 1; -- Doctor not available at specified clinic
            RAISERROR('Doctor not available at specified clinic', 16, 1);
        END;
        
        -- Check if the doctor is available at the requested time
        IF NOT EXISTS (
            SELECT 1 
            FROM DoctorAvailability da
            WHERE da.DoctorClinicID = @DoctorClinicID
              AND da.DayOfWeek = DATEPART(WEEKDAY, @AppointmentDateTime)
              AND CAST(@AppointmentDateTime AS TIME) >= da.StartTime
              AND DATEADD(MINUTE, @SlotDuration, CAST(@AppointmentDateTime AS TIME)) <= da.EndTime
              AND da.IsActive = 1
        )
        BEGIN
            SET @Result = 2; -- Doctor not available at requested time
            RAISERROR('Doctor not available at requested time', 16, 1);
        END;
        
        -- Calculate end time
        SET @EndDateTime = DATEADD(MINUTE, @SlotDuration, @AppointmentDateTime);
        
        -- Check for conflicting appointments
        IF EXISTS (
            SELECT 1 
            FROM Appointment 
            WHERE DoctorID = @DoctorID 
              AND ClinicID = @ClinicID
              AND ((ScheduledDateTime <= @AppointmentDateTime AND EndDateTime > @AppointmentDateTime)
                   OR (ScheduledDateTime < @EndDateTime AND EndDateTime >= @EndDateTime)
                   OR (ScheduledDateTime >= @AppointmentDateTime AND EndDateTime <= @EndDateTime))
              AND Status IN ('Scheduled', 'Confirmed')
        )
        BEGIN
            SET @Result = 3; -- Time slot not available
            RAISERROR('Time slot not available', 16, 1);
        END;
        
        -- Insert the new appointment if no errors
        IF @Result = 0
        BEGIN
            INSERT INTO Appointment (
                PatientID,
                DoctorID,
                ClinicID,
                ScheduledDateTime,
                EndDateTime,
                Purpose,
                Status,
                ConsultationFee,
                CalendarEventID,
                CreatedDate
            )
            VALUES (
                @PatientID,
                @DoctorID,
                @ClinicID,
                @AppointmentDateTime,
                @EndDateTime,
                @Purpose,
                'Scheduled',
                @ConsultationFee,
                @CalendarEventID,
                GETDATE()
            );
            
            SET @AppointmentID = SCOPE_IDENTITY();
            
            COMMIT TRANSACTION;
            RETURN 0; -- Success
        END
        ELSE
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN @Result; -- Return error code
        END
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        DECLARE @ErrorMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error booking appointment: %s', 16, 1, @ErrorMsg);
        RETURN -1; -- General error
    END CATCH
END;
GO

-- 3. Get Patient Appointments (FIXED)
CREATE PROCEDURE sp_GetPatientAppointments
    @PatientID INT,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @Status NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        a.AppointmentID,
        a.ScheduledDateTime,
        a.EndDateTime,
        d.FirstName + ' ' + d.LastName AS DoctorName,
        ds.SpecialtyName,
        c.ClinicName,
        a.Status,
        a.Purpose,
        a.ConsultationFee,
        dis.DiseaseName AS Diagnosis,
        a.PatientRating
    FROM Appointment a
    JOIN Doctor d ON a.DoctorID = d.DoctorID
    JOIN DoctorSpecialtyMapping dsm ON d.DoctorID = dsm.DoctorID AND dsm.IsPrimary = 1
    JOIN DoctorSpecialty ds ON dsm.SpecialtyID = ds.SpecialtyID
    JOIN Clinic c ON a.ClinicID = c.ClinicID
    LEFT JOIN Diagnosis diag ON a.DiagnosisID = diag.DiagnosisID
    LEFT JOIN Disease dis ON diag.DiseaseID = dis.DiseaseID
    WHERE a.PatientID = @PatientID
      AND (@StartDate IS NULL OR CAST(a.ScheduledDateTime AS DATE) >= @StartDate)
      AND (@EndDate IS NULL OR CAST(a.ScheduledDateTime AS DATE) <= @EndDate)
      AND (@Status IS NULL OR a.Status = @Status)
    ORDER BY a.ScheduledDateTime DESC;
END;
GO

-- 4. Update Appointment Status
CREATE PROCEDURE sp_UpdateAppointmentStatus
    @AppointmentID INT,
    @Status NVARCHAR(20),
    @DoctorFeedback NVARCHAR(MAX) = NULL,
    @PatientRating TINYINT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate status
        IF @Status NOT IN ('Scheduled', 'Completed', 'Cancelled', 'No-Show', 'Confirmed')
        BEGIN
            RAISERROR('Invalid appointment status', 16, 1);
        END;
        
        -- Update appointment
        UPDATE Appointment
        SET 
            Status = @Status,
            DoctorFeedback = CASE WHEN @DoctorFeedback IS NOT NULL THEN @DoctorFeedback ELSE DoctorFeedback END,
            PatientRating = CASE WHEN @PatientRating IS NOT NULL THEN @PatientRating ELSE PatientRating END,
            ModifiedDate = GETDATE()
        WHERE AppointmentID = @AppointmentID;
        
        -- Update doctor's average rating if patient rating was provided
        IF @PatientRating IS NOT NULL AND @Status = 'Completed'
        BEGIN
            UPDATE d
            SET d.Rating = (
                SELECT AVG(CAST(a.PatientRating AS DECIMAL(3,1)))
                FROM Appointment a
                WHERE a.DoctorID = d.DoctorID
                  AND a.Status = 'Completed'
                  AND a.PatientRating IS NOT NULL
            )
            FROM Doctor d
            JOIN Appointment a ON d.DoctorID = a.DoctorID
            WHERE a.AppointmentID = @AppointmentID;
            
            -- Update doctor-clinic rating
            UPDATE dc
            SET dc.AverageRating = (
                SELECT AVG(CAST(a.PatientRating AS DECIMAL(3,1)))
                FROM Appointment a
                WHERE a.DoctorID = dc.DoctorID
                  AND a.ClinicID = dc.ClinicID
                  AND a.Status = 'Completed'
                  AND a.PatientRating IS NOT NULL
            )
            FROM DoctorClinic dc
            JOIN Appointment a ON dc.DoctorID = a.DoctorID AND dc.ClinicID = a.ClinicID
            WHERE a.AppointmentID = @AppointmentID;
        END;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        DECLARE @ErrorMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error updating appointment: %s', 16, 1, @ErrorMsg);
    END CATCH
END;
GO

-- 5. Get Doctor Appointments (FIXED)
CREATE PROCEDURE sp_GetDoctorAppointments
    @DoctorID INT,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @Status NVARCHAR(20) = NULL,
    @ClinicID INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        a.AppointmentID,
        a.ScheduledDateTime,
        a.EndDateTime,
        p.FirstName + ' ' + p.LastName AS PatientName,
        p.DateOfBirth,
        p.Gender,
        c.ClinicName,
        a.Status,
        a.Purpose,
        a.ConsultationFee,
        dis.DiseaseName AS Diagnosis,
        a.PatientRating
    FROM Appointment a
    JOIN Patient p ON a.PatientID = p.PatientID
    JOIN Clinic c ON a.ClinicID = c.ClinicID
    LEFT JOIN Diagnosis diag ON a.DiagnosisID = diag.DiagnosisID
    LEFT JOIN Disease dis ON diag.DiseaseID = dis.DiseaseID
    WHERE a.DoctorID = @DoctorID
      AND (@StartDate IS NULL OR CAST(a.ScheduledDateTime AS DATE) >= @StartDate)
      AND (@EndDate IS NULL OR CAST(a.ScheduledDateTime AS DATE) <= @EndDate)
      AND (@Status IS NULL OR a.Status = @Status)
      AND (@ClinicID IS NULL OR a.ClinicID = @ClinicID)
    ORDER BY a.ScheduledDateTime;
END;
GO

-- 6. Record Diagnosis
CREATE PROCEDURE sp_RecordDiagnosis
    @PatientID INT,
    @DiseaseID INT = NULL,
    @ConfidenceLevel DECIMAL(3,2) = NULL,
    @Notes NVARCHAR(MAX) = NULL,
    @IsFinalDiagnosis BIT = 0,
    @CreatedBy INT,
    @DiagnosisID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate disease exists if provided
        IF @DiseaseID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Disease WHERE DiseaseID = @DiseaseID)
        BEGIN
            RAISERROR('Invalid DiseaseID provided', 16, 1);
        END;
        
        -- Insert diagnosis
        INSERT INTO Diagnosis (
            PatientID,
            DiseaseID,
            ConfidenceLevel,
            Notes,
            IsFinalDiagnosis,
            CreatedBy
        )
        VALUES (
            @PatientID,
            @DiseaseID,
            @ConfidenceLevel,
            @Notes,
            @IsFinalDiagnosis,
            @CreatedBy
        );
        
        SET @DiagnosisID = SCOPE_IDENTITY();
        
        -- Update medical history if final diagnosis
        IF @IsFinalDiagnosis = 1 AND @DiseaseID IS NOT NULL
        BEGIN
            -- Set previous diagnoses of same disease as not current
            UPDATE MedicalHistory
            SET IsCurrent = 0
            WHERE PatientID = @PatientID
              AND DiseaseID = @DiseaseID;
              
            -- Add new current diagnosis to medical history
            INSERT INTO MedicalHistory (
                PatientID,
                DiseaseID,
                DiagnosisDate,
                IsCurrent
            )
            VALUES (
                @PatientID,
                @DiseaseID,
                GETDATE(),
                1
            );
        END;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        DECLARE @ErrorMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error recording diagnosis: %s', 16, 1, @ErrorMsg);
    END CATCH
END;
GO

-- 7. Add Prescription
CREATE PROCEDURE sp_AddPrescription
    @DiagnosisID INT,
    @MedicationID INT,
    @Dosage NVARCHAR(50),
    @Frequency NVARCHAR(50),
    @Duration NVARCHAR(50),
    @Instructions NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate diagnosis exists
        IF NOT EXISTS (SELECT 1 FROM Diagnosis WHERE DiagnosisID = @DiagnosisID)
        BEGIN
            RAISERROR('Invalid DiagnosisID provided', 16, 1);
        END;
        
        -- Validate medication exists
        IF NOT EXISTS (SELECT 1 FROM Medication WHERE MedicationID = @MedicationID)
        BEGIN
            RAISERROR('Invalid MedicationID provided', 16, 1);
        END;
        
        -- Insert prescription
        INSERT INTO Prescription (
            DiagnosisID,
            MedicationID,
            Dosage,
            Frequency,
            Duration,
            Instructions
        )
        VALUES (
            @DiagnosisID,
            @MedicationID,
            @Dosage,
            @Frequency,
            @Duration,
            @Instructions
        );
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        DECLARE @ErrorMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error adding prescription: %s', 16, 1, @ErrorMsg);
    END CATCH
END;
GO

-- 8. Get Patient Prescriptions (FIXED)
CREATE PROCEDURE sp_GetPatientPrescriptions
    @PatientID INT,
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @IsActive BIT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        pr.PrescriptionID,
        diag.DiagnosisDate,
        d.DiseaseName,
        m.GenericName,
        m.BrandName,
        m.DosageForm,
        m.Strength,
        pr.Dosage,
        pr.Frequency,
        pr.Duration,
        pr.Instructions,
        CASE 
            WHEN diag.DiagnosisDate IS NULL THEN 1
            WHEN DATEADD(DAY, 
                CASE 
                    WHEN pr.Duration LIKE '%day%' THEN TRY_CAST(REPLACE(pr.Duration, ' days', '') AS INT)
                    WHEN pr.Duration LIKE '%week%' THEN TRY_CAST(REPLACE(pr.Duration, ' weeks', '') AS INT) * 7
                    WHEN pr.Duration LIKE '%month%' THEN TRY_CAST(REPLACE(pr.Duration, ' months', '') AS INT) * 30
                    ELSE 30 -- Default to 30 days if format not recognized
                END, diag.DiagnosisDate) >= GETDATE() THEN 1
            ELSE 0
        END AS IsActive
    FROM Prescription pr
    JOIN Diagnosis diag ON pr.DiagnosisID = diag.DiagnosisID
    LEFT JOIN Disease d ON diag.DiseaseID = d.DiseaseID
    JOIN Medication m ON pr.MedicationID = m.MedicationID
    WHERE diag.PatientID = @PatientID
      AND (@StartDate IS NULL OR CAST(diag.DiagnosisDate AS DATE) >= @StartDate)
      AND (@EndDate IS NULL OR CAST(diag.DiagnosisDate AS DATE) <= @EndDate)
      AND (@IsActive IS NULL OR 
          (CASE 
              WHEN diag.DiagnosisDate IS NULL THEN 1
              WHEN DATEADD(DAY, 
                  CASE 
                      WHEN pr.Duration LIKE '%day%' THEN TRY_CAST(REPLACE(pr.Duration, ' days', '') AS INT)
                      WHEN pr.Duration LIKE '%week%' THEN TRY_CAST(REPLACE(pr.Duration, ' weeks', '') AS INT) * 7
                      WHEN pr.Duration LIKE '%month%' THEN TRY_CAST(REPLACE(pr.Duration, ' months', '') AS INT) * 30
                      ELSE 30
                  END, diag.DiagnosisDate) >= GETDATE() THEN 1
              ELSE 0
          END) = @IsActive)
    ORDER BY diag.DiagnosisDate DESC;
END;
GO