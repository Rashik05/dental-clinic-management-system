/*
    Dental Clinic Management System
    MySQL Create Script
*/

DROP DATABASE IF EXISTS DentalClinicDB;

CREATE DATABASE DentalClinicDB;

USE DentalClinicDB;

-- 1. Patient
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DateOfBirth DATE,
    Address VARCHAR(200)
) ENGINE=InnoDB;

-- 2. Insurance
CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY,
    PolicyNumber VARCHAR(50) UNIQUE NOT NULL,
    ProviderName VARCHAR(100),
    CoveragePercentage DECIMAL(5,2) NOT NULL CHECK (CoveragePercentage BETWEEN 0 AND 100),
    MaxCoverage DECIMAL(10,2) NOT NULL CHECK (MaxCoverage >= 0),
    CoverageType VARCHAR(50)
) ENGINE=InnoDB;

-- 3. Dentist
CREATE TABLE Dentist (
    DentistID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Specialization VARCHAR(100),
    PhoneNumber VARCHAR(15) UNIQUE
) ENGINE=InnoDB;

-- 4. DentistSchedule
CREATE TABLE DentistSchedule (
    DentistID INT,
    ScheduleDay VARCHAR(20),
    StartTime TIME,
    EndTime TIME,
    PRIMARY KEY (DentistID, ScheduleDay, StartTime),
    FOREIGN KEY (DentistID) REFERENCES Dentist(DentistID)
        ON DELETE CASCADE,
    CHECK (EndTime > StartTime)
) ENGINE=InnoDB;

CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY,
    AppointmentDate DATE,
    AppointmentTime TIME,
    Status VARCHAR(20),
    DentistID INT,
    PatientID INT,
    Notes TEXT,
    FOREIGN KEY (DentistID) REFERENCES Dentist(DentistID)
        ON DELETE CASCADE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 6. Payment
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    AppointmentID INT UNIQUE,
    PaymentDate DATE,
    PaymentStatus VARCHAR(20),
    TotalAmount DECIMAL(10,2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
        ON DELETE CASCADE,
    CHECK (TotalAmount >= 0)
) ENGINE=InnoDB;

-- 7. Installment
CREATE TABLE Installment (
    PaymentID INT,
    InstallmentID INT,
    AmountPaid DECIMAL(10,2),
    DueDate DATE,
    InstallmentStatus VARCHAR(20),
    PRIMARY KEY (PaymentID, InstallmentID),
    FOREIGN KEY (PaymentID) REFERENCES Payment(PaymentID)
        ON DELETE CASCADE,
    CHECK (AmountPaid >= 0)
) ENGINE=InnoDB;

-- 8. PatientInsuranceCoverage
CREATE TABLE PatientInsuranceCoverage (
    PatientID INT,
    InsuranceID INT,
    PRIMARY KEY (PatientID, InsuranceID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
        ON DELETE CASCADE,
    FOREIGN KEY (InsuranceID) REFERENCES Insurance(InsuranceID)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- 9. PatientReferral
CREATE TABLE PatientReferral (
    PatientID INT,
    ReferredPatientID INT,
    ReferralDate DATE,
    Relationship VARCHAR(50),
    PRIMARY KEY (PatientID, ReferredPatientID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
        ON DELETE CASCADE,
    FOREIGN KEY (ReferredPatientID) REFERENCES Patient(PatientID)
        ON DELETE CASCADE
) ENGINE=InnoDB;