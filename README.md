# Hospital-Management-System-Database-Project
## Overview
The Hospital Management System Database Project is designed to simulate the management of hospital operations, including patient care, room assignments, doctor-patient relationships, prescriptions, and billing. This database is structured to manage multiple entities such as patients, doctors, nurses, ward boys, and rooms, adhering to specific business rules and relationships.

## Business Rules
* Doctor-Patient Relationships:
  * Each patient is assigned to one doctor.
  *A doctor can treat multiple patients.
* Nurse-Patient Relationships:
  * Each patient is cared for by one nurse.
  * A nurse can care for multiple patients.
* Ward Boy-Patient and Room Relationships:
  * Each patient is served by one ward boy.
  * Each room is maintained by one ward boy.
  * A ward boy can maintain multiple rooms and care for multiple patients.
* Prescriptions and Drugs:
  * Each doctor provides prescriptions for patients.
  * Each prescription contains one or more drugs.
  * Each drug has a unique ID and name.
* Billing:
  * Bills are generated based on the number of days a patient stays in a room and the treatment received.
  * Room costs are calculated per day.
  * Drug costs are calculated based on the number of drugs prescribed.

* Billing Calculation:
  * Room Cost: ndays * room_day_cost (default: 100)
  * Prescription Cost: ndrugs * unit_drug_cost (default: 150)
  * Total Prescription Cost: prescription_cost * nprescriptions
  * Total Bill Cost: total_prescriptions_cost + total_room_cost

## Database Structure
The project utilizes a relational database with the following key tables:
* Room: Stores room details (room_id, room_type, ward_boy_id).
* Doctor: Stores doctor details (doctor_id, fname, lname, specialization).
* Nurse: Stores nurse details (nurse_id, fname, lname, supervisor_id).
* Ward Boys: Stores ward boy details (WB_Id, fname, lname, nurse_id).
* Patient: Stores patient details (patient_id, fname, lname, age, phone, disease, room_num, doctor_id, nurse_id, ward_boy_id).
* Drug: Stores drug details (drug_id, drug_name).
* Prescriptions: Manages prescriptions (prescription_id, patient_id, doctor_id, drug_id).
* Bill: Manages billing details (bill_id, ndays, total_room_cost, ndrugs, prescription_cost, npreciptions, total_prescriptions_cost, total_Bill_cost, patient_id, prescription_id).

## Conclusion
This project demonstrates a robust hospital management system with interrelated entities and dynamic billing functionality. It handles key hospital operations such as patient treatment, room assignments, staff management, and billing based on real-world scenarios.

