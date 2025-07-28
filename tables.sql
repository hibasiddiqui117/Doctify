-- Drop database if exists
IF DB_ID('doctify_db') IS NOT NULL
    DROP DATABASE doctify_db;
GO

-- Create the database
CREATE DATABASE doctify_db;
GO

USE doctify_db;
GO

-- Create tables with proper schema
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other', 'Unknown')),
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100) UNIQUE CHECK (Email LIKE '%_@__%.__%'),
    Address NVARCHAR(200),
    City NVARCHAR(50),
    BloodGroup NVARCHAR(5),
    MedicalHistory NVARCHAR(MAX),
    Allergies NVARCHAR(MAX),
    RegistrationDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE(),
    ModifiedBy NVARCHAR(100)
);
GO

CREATE TABLE Symptom (
    SymptomID INT PRIMARY KEY,
    SymptomName VARCHAR(100) NOT NULL UNIQUE,
    SymptomCategory NVARCHAR(50),
    CommonInDiseases NVARCHAR(500)
);
GO

CREATE TABLE Disease (
    DiseaseID INT PRIMARY KEY,
    DiseaseName VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT,
    ICD10Code VARCHAR(20),
    IsChronic BIT DEFAULT 0,
    IsContagious BIT DEFAULT 0,
    Prevalence NVARCHAR(50),
    TypicalDuration NVARCHAR(50)
);
GO

CREATE TABLE Diagnosis (
    DiagnosisID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    DiseaseID INT,
    DiagnosisDate DATETIME DEFAULT GETDATE(),
    ConfidenceLevel DECIMAL(3,2),
    Notes NVARCHAR(MAX),
    IsFinalDiagnosis BIT DEFAULT 0,
    CreatedBy INT,
    CONSTRAINT FK_Diagnosis_Patient FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    CONSTRAINT FK_Diagnosis_Disease FOREIGN KEY (DiseaseID) REFERENCES Disease(DiseaseID)
);
GO


CREATE TABLE Precaution (
    PrecautionID INT PRIMARY KEY IDENTITY(1,1),
    PrecautionText VARCHAR(255) NOT NULL,
    Category NVARCHAR(50),
    IsMedical BIT DEFAULT 0,
    EffectivenessRating INT CHECK (EffectivenessRating BETWEEN 1 AND 5)
);
GO

CREATE TABLE DiseasePrecaution (
    DiseasePrecautionID INT PRIMARY KEY IDENTITY(1,1),
    DiseaseID INT NOT NULL,
    PrecautionID INT NOT NULL,
    Priority TINYINT,
    ScientificEvidence NVARCHAR(50),
    CONSTRAINT FK_DiseasePrecaution_Disease FOREIGN KEY (DiseaseID) REFERENCES Disease(DiseaseID),
    CONSTRAINT FK_DiseasePrecaution_Precaution FOREIGN KEY (PrecautionID) REFERENCES Precaution(PrecautionID),
    CONSTRAINT UQ_DiseasePrecaution UNIQUE (DiseaseID, PrecautionID)
);
GO

CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F', 'O')),
    DateOfBirth DATE,
    LicenseNumber NVARCHAR(50) UNIQUE,
    YearsOfExperience INT,
    Qualification NVARCHAR(100),
    PMDCNumber NVARCHAR(50),
    IsActive BIT DEFAULT 1,
    Bio NVARCHAR(MAX),
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE(),
    Rating DECIMAL(3,1) CHECK (Rating BETWEEN 0 AND 5)
);
GO

CREATE TABLE DoctorSpecialty (
    SpecialtyID INT PRIMARY KEY IDENTITY(1,1),
    SpecialtyName NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(500),
    Category NVARCHAR(50),
    IsSurgical BIT DEFAULT 0,
    AverageYearsOfTraining INT,
    CertificationRequired BIT DEFAULT 1
);
GO

CREATE TABLE DoctorSpecialtyMapping (
    DoctorSpecialtyMappingID INT PRIMARY KEY IDENTITY(1,1),
    DoctorID INT NOT NULL,
    SpecialtyID INT NOT NULL,
    IsPrimary BIT DEFAULT 0,
    YearsInSpecialty INT,
    CONSTRAINT FK_DoctorSpecialtyMapping_Doctor FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    CONSTRAINT FK_DoctorSpecialtyMapping_Specialty FOREIGN KEY (SpecialtyID) REFERENCES DoctorSpecialty(SpecialtyID),
    CONSTRAINT UQ_DoctorSpecialtyMapping UNIQUE (DoctorID, SpecialtyID)
);
GO

CREATE TABLE Clinic (
    ClinicID INT PRIMARY KEY IDENTITY(1,1),
    ClinicName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    Website NVARCHAR(255),
    IsActive BIT DEFAULT 1,
    Latitude DECIMAL(10,8),
    Longitude DECIMAL(11,8),
    Facilities NVARCHAR(MAX),
    OpeningHours NVARCHAR(100)
);
GO

CREATE TABLE DoctorClinic (
    DoctorClinicID INT PRIMARY KEY IDENTITY(1,1),
    DoctorID INT NOT NULL,
    ClinicID INT NOT NULL,
    ConsultationFee DECIMAL(10,2) NOT NULL,
    FollowUpFee DECIMAL(10,2),
    IsActive BIT DEFAULT 1,
    AverageRating DECIMAL(3,1),
    CONSTRAINT FK_DoctorClinic_Doctor FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    CONSTRAINT FK_DoctorClinic_Clinic FOREIGN KEY (ClinicID) REFERENCES Clinic(ClinicID),
    CONSTRAINT UQ_DoctorClinic UNIQUE (DoctorID, ClinicID)
);
GO

CREATE TABLE DoctorAvailability (
    AvailabilityID INT PRIMARY KEY IDENTITY(1,1),
    DoctorClinicID INT NOT NULL,
    DayOfWeek TINYINT NOT NULL CHECK (DayOfWeek BETWEEN 1 AND 7),
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    SlotDurationMinutes INT DEFAULT 30,
    IsActive BIT DEFAULT 1,
    CONSTRAINT FK_DoctorAvailability_DoctorClinic FOREIGN KEY (DoctorClinicID) REFERENCES DoctorClinic(DoctorClinicID),
    CONSTRAINT CHK_ValidTime CHECK (StartTime < EndTime)
);
GO

CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    ClinicID INT NOT NULL,
    ScheduledDateTime DATETIME NOT NULL,
    EndDateTime DATETIME NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled', 'No-Show', 'Confirmed')),
    Purpose NVARCHAR(255),
    Notes NVARCHAR(MAX),
    ConsultationFee DECIMAL(10,2),
    DiagnosisID INT,
    CalendarEventID NVARCHAR(100),
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME DEFAULT GETDATE(),
    PatientRating TINYINT CHECK (PatientRating BETWEEN 1 AND 5),
    DoctorFeedback NVARCHAR(MAX),
    CONSTRAINT FK_Appointment_Patient FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    CONSTRAINT FK_Appointment_Doctor FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    CONSTRAINT FK_Appointment_Clinic FOREIGN KEY (ClinicID) REFERENCES Clinic(ClinicID),
    CONSTRAINT FK_Appointment_Diagnosis FOREIGN KEY (DiagnosisID) REFERENCES Diagnosis(DiagnosisID),
    CONSTRAINT CHK_AppointmentTime CHECK (ScheduledDateTime < EndDateTime)
);
GO

CREATE TABLE MedicalHistory (
    MedicalHistoryID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    DiseaseID INT,
    DiagnosisDate DATE,
    TreatmentDetails TEXT,
    Notes TEXT,
    IsCurrent BIT DEFAULT 0,
    CONSTRAINT FK_MedicalHistory_Patient FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    CONSTRAINT FK_MedicalHistory_Disease FOREIGN KEY (DiseaseID) REFERENCES Disease(DiseaseID)
);
GO

CREATE TABLE Medication (
    MedicationID INT PRIMARY KEY IDENTITY(1,1),
    GenericName NVARCHAR(100) NOT NULL,
    BrandName NVARCHAR(100),
    DosageForm NVARCHAR(50) CHECK (DosageForm IN ('Tablet', 'Capsule', 'Syrup', 'Injection', 'Inhaler', 'Cream', 'Ointment', 'Drops', 'Suppository', 'Patch')),
    Strength NVARCHAR(50) NOT NULL,
    TherapeuticCategory NVARCHAR(100),
    IsControlled BIT DEFAULT 0,
    RequiresPrescription BIT DEFAULT 1,
    Manufacturer NVARCHAR(100),
    LastUpdated DATETIME DEFAULT GETDATE(),
    CONSTRAINT UQ_Medication UNIQUE (GenericName, Strength, DosageForm)
);
GO

CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY IDENTITY(1,1),
    DiagnosisID INT NOT NULL,
    MedicationID INT NOT NULL,
    Dosage NVARCHAR(50) NOT NULL,
    Frequency NVARCHAR(50) NOT NULL,
    Duration NVARCHAR(50) NOT NULL,
    Instructions NVARCHAR(MAX),
    CONSTRAINT FK_Prescription_Diagnosis FOREIGN KEY (DiagnosisID) REFERENCES Diagnosis(DiagnosisID),
    CONSTRAINT FK_Prescription_Medication FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
);
GO

CREATE TABLE Remedy (
    RemedyID INT PRIMARY KEY IDENTITY(1,1),
    DiseaseID INT NOT NULL,
    RemedyText NVARCHAR(500) NOT NULL,
    Category NVARCHAR(50),
    EvidenceLevel NVARCHAR(50),
    CONSTRAINT FK_Remedy_Disease FOREIGN KEY (DiseaseID) REFERENCES Disease(DiseaseID)
);
GO

CREATE TABLE AuditLog (
    AuditLogID INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(100) NOT NULL,
    RecordID INT NOT NULL,
    ActionType NVARCHAR(20) NOT NULL CHECK (ActionType IN ('INSERT', 'UPDATE', 'DELETE')),
    OldValues NVARCHAR(MAX),
    NewValues NVARCHAR(MAX),
    ChangedBy NVARCHAR(100),
    ChangeDate DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
    LastLogin DATETIME NULL,
    IsActive BIT NOT NULL DEFAULT 1
);
GO