Let's use your Hospital/Clinic Management System to show how a database develops from the first design to the second and then the third normal form. The idea is to start with a table that has problems, examine those problems, and improve the design step by step.

# Database Normalisation: From 1NF to 3NF

## Step 1: First Normal Form (1NF) — The Initial Design

Imagine a hospital wants to keep records of patients, doctors, appointments, and diagnoses. At first, the hospital stores everything in one table.

### Initial table: Hospital Records

| AppointmentID | PatientID | PatientName | DoctorID | DoctorName | DoctorSpecialisation | AppointmentDate | Diagnosis           |
| ------------- | --------- | ----------- | -------- | ---------- | -------------------- | --------------- | ------------------- |
| A001          | P001      | John Musa   | D001     | Dr. Peter  | Cardiology           | 2026-10-10      | Heart disease       |
| A002          | P002      | Mary James  | D002     | Dr. Grace  | Paediatrics          | 2026-10-11      | Fever               |
| A003          | P001      | John Musa   | D001     | Dr. Peter  | Cardiology           | 2026-10-15      | High blood pressure |

In this design, the hospital can record appointments, but there are problems.

Problems with the initial design:

1. Patient names are repeated when a patient books multiple appointments.
2. Doctor names and specialisations are repeated.
3. If Dr. Peter changes specialisation details, several rows might need updating.
4. If the hospital deletes a patient's only appointment, it might accidentally lose other information stored in that row.

### How do we achieve 1NF?

First Normal Form requires every cell to contain a single value. We must not store multiple phone numbers, diagnoses, or appointments in one cell. Each row must represent one appointment, and every appointment must have a unique identifier.

Our initial table already satisfies 1NF because every cell contains one value and each appointment has a unique `AppointmentID`.

However, 1NF does not mean that the database design is complete or efficient. Patient and doctor information is still repeated.

The next step is to improve the design.

## Step 2: Second Normal Form (2NF) — Separating Data That Belongs Together

Second Normal Form requires a table to satisfy 1NF and have every non-key attribute depend on the whole primary key, rather than only part of a composite key.

In our initial design, `AppointmentID` is the primary key. Because it is a single-column key, the table does not have a partial dependency on part of a composite key. Therefore, it technically already satisfies 2NF.

Nevertheless, we can improve the design by separating patient, doctor, and appointment information into their own tables. This reduces repeated information and makes the database easier to manage.

### Table 1: Patient

| PatientID (PK) | PatientName |
| -------------- | ----------- |
| P001           | John Musa   |
| P002           | Mary James  |

The Patient table stores each patient's details once.

### Table 2: Doctor

| DoctorID (PK) | DoctorName | Specialisation |
| ------------- | ---------- | -------------- |
| D001          | Dr. Peter  | Cardiology     |
| D002          | Dr. Grace  | Paediatrics    |

The Doctor table stores each doctor's details once.

### Table 3: Appointment

| AppointmentID (PK) | PatientID (FK) | DoctorID (FK) | AppointmentDate |
| ------------------ | -------------- | ------------- | --------------- |
| A001               | P001           | D001          | 2026-10-10      |
| A002               | P002           | D002          | 2026-10-11      |
| A003               | P001           | D001          | 2026-10-15      |

The Appointment table connects each patient to the doctor they are visiting and records the appointment date.

- `AppointmentID` is the primary key.
- `PatientID` is a foreign key referencing the Patient table.
- `DoctorID` is a foreign key referencing the Doctor table.

### Why is this design better?

John Musa's name is stored only once in the Patient table, even though he has two appointments. Dr. Peter's name and specialisation are also stored only once in the Doctor table.

This reduces duplication and makes updates easier.

Important distinction: The separation above is a useful database redesign, but because the original table used a single-column primary key, it is not strictly a correction for a 2NF violation. It prepares the database for a cleaner, well-structured design.

## Step 3: Third Normal Form (3NF) — Removing Indirect Dependencies

Third Normal Form requires a table to satisfy 2NF and ensures that non-key attributes do not depend on other non-key attributes.

Let's imagine that, in our improved design, we add a doctor's department name and department phone number directly to the Doctor table.

### Doctor table before the 3NF improvement

| DoctorID (PK) | DoctorName | DepartmentID | DepartmentName | DepartmentPhone |
| ------------- | ---------- | ------------ | -------------- | --------------- |
| D001          | Dr. Peter  | DEP01        | Cardiology     | 08011111111     |
| D002          | Dr. Grace  | DEP02        | Paediatrics    | 08022222222     |
| D003          | Dr. James  | DEP01        | Cardiology     | 08011111111     |

This table contains repeated department information. For example, the Cardiology department name and phone number appear for both Dr. Peter and Dr. James.

The dependency is:

`DoctorID → DepartmentID → DepartmentName, DepartmentPhone`

This means the department name and phone number depend on `DepartmentID`, not directly on `DoctorID`. This is a transitive dependency.

### How do we achieve 3NF?

We create a separate Department table and keep only `DepartmentID` in the Doctor table.

### Table 1: Department

| DepartmentID (PK) | DepartmentName | DepartmentPhone |
| ----------------- | -------------- | --------------- |
| DEP01             | Cardiology     | 08011111111     |
| DEP02             | Paediatrics    | 08022222222     |

### Table 2: Doctor after the 3NF improvement

| DoctorID (PK) | DoctorName | DepartmentID (FK) |
| ------------- | ---------- | ----------------- |
| D001          | Dr. Peter  | DEP01             |
| D002          | Dr. Grace  | DEP02             |
| D003          | Dr. James  | DEP01             |

Now the department's name and phone number are stored only in the Department table. The Doctor table refers to the department through `DepartmentID`.

### Why is this better?

1. Less duplication: Department details are stored once.
2. Easier updates: If the department phone number changes, we update one row.
3. Better accuracy: Doctors assigned to the same department reference the same department record.
4. Fewer data problems: We reduce the risk of inconsistent department details.

## Final design after the improvements

### PATIENT

PatientID (PK), PatientName

One patient can have many appointments

### APPOINTMENT

AppointmentID (PK), PatientID (FK), DoctorID (FK), AppointmentDate

Each appointment is with one doctor

### DOCTOR

DoctorID (PK), DoctorName, DepartmentID (FK)

Many doctors can belong to one department

### DEPARTMENT

DepartmentID (PK), DepartmentName, DepartmentPhone

Here, PK means primary key and FK means foreign key. The arrows describe the relationships between the tables.

## Summary of the three stages

| Stage | What we do                                                                                                                               | Result                                                                       |
| ----- | ---------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| 1NF   | Ensure each cell contains one value and each appointment has a unique ID.                                                                | A basic, valid table structure.                                              |
| 2NF   | Ensure every non-key attribute depends on the whole primary key; separate patient, doctor, and appointment records for a cleaner design. | Less repeated patient and doctor information.                                |
| 3NF   | Remove the indirect dependency between doctor and department details.                                                                    | Department information is stored separately and referenced by a foreign key. |

Conclusion: The main lesson is that normalisation improves the database gradually. First, we make the data atomic. Second, we ensure attributes depend on the whole key. Third, we remove indirect dependencies. For the Hospital Management System, this gives us a more organised database that is easier to maintain, update, and expand.
