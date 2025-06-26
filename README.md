# ImmuniTrackDB

A secure and scalable Vaccination Database Management System built using SQL and conceptualized with real-world relational assumptions. This system is designed to manage and monitor vaccine distribution, administration, and citizen records for public health monitoring.

---

## 📌 Project Overview

This project aims to create a comprehensive database solution that streamlines vaccination tracking for individuals, health workers, hospitals, suppliers, and governing authorities. The goal is to maintain accurate data records, ensure vaccine supply transparency, and facilitate public health analytics.

---

## 🎯 Key Features

- ✅ Track vaccine administration per individual with historical data.
- ✅ Real-time vaccine inventory management per center.
- ✅ Hospital-supplier relationships with supply logs.
- ✅ Export records to various countries.
- ✅ Citizen health profiles linked via Aadhaar.
- ✅ Normalized database schema (up to 3NF & BCNF).
- ✅ Advanced SQL queries for analytics and reporting.

---

## 📁 ER Model & Schema Design

The project supports the following relational tables:

- `VACCINE`
- `SUPPLIERS`
- `EXPORT`
- `INVENTORY`
- `SUPPLIES`
- `LOCATION`
- `VACCINATION_CENTER`
- `HOSPITAL`
- `HEALTH_WORKERS`
- `VACCINATION_RECORD`
- `CITIZENS`

Each table is normalized and includes relevant foreign key constraints to preserve data integrity.

---

## 🧠 Functional Dependencies

Examples of dependencies applied in normalization:
- `Pin Code → City, State`
- `Vaccine_ID → Name, Country, Supplier_ID, Date_of_approval`
- `Aadhar_number → Name, DOB, Gender, Pincode`
- Composite keys like `(Vaccination_ID, Center_ID) → Hospital_ID, Quantity`

---

## 🛠️ Technologies Used

- **Database**: Oracle/MySQL (SQL DDL + DML)
- **Tools**: SQL Client (like DBeaver, MySQL Workbench)
- **Concepts**: ER Modeling, Normalization (3NF, BCNF), Joins, Aggregates, Subqueries

---

## 📊 Sample SQL Queries

Here are some queries included in the system for analytics:

- Most vaccinated city
- Most common vaccinated age group
- Top-performing health worker(s)
- Country with highest vaccine exports
- City with most senior health workers
- Center with highest footfall

---

## 🔐 Data Privacy & Assumptions

- All Aadhaar numbers and personal details are fictional and anonymized.
- M:N and 1:M relationships modeled effectively (e.g., hospitals ↔ suppliers).
- Health workers are also treated as citizens for realistic linking.

---

## 🧪 Sample Insert Statements

Sample insertions include real-like data for:
- Vaccines (COVID-19, Mumps, Polio, etc.)
- Health workers across hospitals
- Export history across multiple nations
- Citizens with DOB, gender, and address

---

## 📦 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/ashutoshpradhan3/ImmuniTrackDB.git
   cd ImmuniTrackDB
2. Open SQL script in your preferred DBMS (MySQL / Oracle).

3. Run the schema + insert statements to initialize tables.

4. Explore sample queries or build your own for deeper analysis.
