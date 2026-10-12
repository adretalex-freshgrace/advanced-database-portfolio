-- MIT 8103 Advanced Database Systems
-- Case study: Hospital/Clinic Management System
-- Database: MySQL 8.0+
-- Run this script in MySQL Workbench or another MySQL client.
-- The comments below explain what each part of the script does.

-- Create the clinic database if it does not already exist.
CREATE DATABASE IF NOT EXISTS ClinicManagement;
-- Select the clinic database for the following commands.
USE ClinicManagement;

-- Store information about patients.
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender VARCHAR(20),
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE,
    Address VARCHAR(255)
);

-- Store information about doctors.
CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialisation VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE
);

-- Store appointments and link each one to a patient and doctor.
CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Booked',
    Notes TEXT,
    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    CONSTRAINT fk_appointment_doctor
        FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    CONSTRAINT chk_appointment_status
        CHECK (Status IN ('Booked', 'Completed', 'Cancelled'))
);

-- Store diagnoses recorded for appointments.
CREATE TABLE Diagnosis (
    DiagnosisID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    DiagnosisDescription TEXT NOT NULL,
    DiagnosisDate DATE NOT NULL,
    Notes TEXT,
    CONSTRAINT fk_diagnosis_appointment
        FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

-- Store medicines prescribed for a diagnosis.
CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    DiagnosisID INT NOT NULL,
    MedicineName VARCHAR(100) NOT NULL,
    Dosage VARCHAR(100) NOT NULL,
    Frequency VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    CONSTRAINT fk_prescription_diagnosis
        FOREIGN KEY (DiagnosisID) REFERENCES Diagnosis(DiagnosisID),
    CONSTRAINT chk_prescription_dates
        CHECK (EndDate IS NULL OR StartDate IS NULL OR EndDate >= StartDate)
);

-- Store laboratory tests and results for patients.
CREATE TABLE LaboratoryRecord (
    LabRecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    TestName VARCHAR(100) NOT NULL,
    TestDate DATE NOT NULL,
    Result TEXT,
    Comments TEXT,
    CONSTRAINT fk_lab_patient
        FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

-- Check that all six tables were created successfully.
SHOW TABLES;

-- Display each table's columns, data types, and keys.
DESCRIBE Patient;
DESCRIBE Doctor;
DESCRIBE Appointment;
DESCRIBE Diagnosis;
DESCRIBE Prescription;
DESCRIBE LaboratoryRecord;
