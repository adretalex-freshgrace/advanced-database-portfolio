# Hospital/Clinic Management System
## Entities and Business Rules

### 1. Purpose
This document defines the main entities, their attributes, and the business rules for the Hospital/Clinic Management System. It will guide the design of the Entity-Relationship (ER) diagram and relational database schema.

### 2. Entities and Attributes

#### 2.1 Patient
Stores information about patients receiving medical care.

- PatientID (Primary Key)
- FirstName
- LastName
- DateOfBirth
- Gender
- Phone
- Email
- Address

#### 2.2 Doctor
Stores information about doctors working at the clinic.

- DoctorID (Primary Key)
- FirstName
- LastName
- Specialisation
- Phone
- Email

#### 2.3 Appointment
Stores appointments booked between patients and doctors.

- AppointmentID (Primary Key)
- PatientID (Foreign Key)
- DoctorID (Foreign Key)
- AppointmentDate
- AppointmentTime
- Status
- Notes

#### 2.4 Diagnosis
Stores diagnoses recorded during patient consultations.

- DiagnosisID (Primary Key)
- AppointmentID (Foreign Key)
- DiagnosisDescription
- DiagnosisDate
- Notes

#### 2.5 Prescription
Stores medicines prescribed following a diagnosis.

- PrescriptionID (Primary Key)
- DiagnosisID (Foreign Key)
- MedicineName
- Dosage
- Frequency
- StartDate
- EndDate

#### 2.6 Laboratory Record
Stores laboratory tests and their results for patients.

- LabRecordID (Primary Key)
- PatientID (Foreign Key)
- TestName
- TestDate
- Result
- Comments

### 3. Business Rules

1. A patient can book many appointments, but each appointment belongs to one patient.
2. A doctor can attend many appointments, but each appointment is assigned to one doctor.
3. An appointment can have zero or many diagnoses, but each diagnosis belongs to one appointment.
4. A diagnosis can have zero or many prescriptions, but each prescription belongs to one diagnosis.
5. A patient can have many laboratory records, but each laboratory record belongs to one patient.
6. Every primary key must uniquely identify a record in its table.
7. Every foreign key must reference an existing record in the related table.
8. Essential information, such as patient names and appointment dates, must not be empty.
9. Appointment status must use approved values, such as Booked, Completed, or Cancelled.
10. A doctor should not be assigned overlapping appointments.

### 4. Entity Relationships

- Patient → Appointment: One-to-Many (1:N)
- Doctor → Appointment: One-to-Many (1:N)
- Appointment → Diagnosis: One-to-Many (1:N)
- Diagnosis → Prescription: One-to-Many (1:N)
- Patient → Laboratory Record: One-to-Many (1:N)

### 5. Conclusion

These entities, attributes, and business rules provide the foundation for the ER diagram and relational schema. They help organise clinic information, establish relationships between records, and maintain data integrity.
