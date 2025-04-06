# IT3223-(P) Day04-Assignment02
## 2020ICT101

### 🏗️ Construction Database Management

This assignment contains SQL scripts to create and manage a **Construction** database. It includes tables for workers, buildings, and assignments, as well as user roles and access privileges.

### 📁 Database Name
`Construction`

---

### 🗂️ Tables

#### 🧑‍🔧 Worker
- `Worker_ID`
- `Worker_name`
- `Hourly_rate`
- `Skill_type`
- `Supervisor_ID`

#### 🏢 Building
- `Building_ID`
- `Building_Address`
- `Type_of_Bldg`
- `Qlty_Level`
- `Status`

#### 📋 Assignment
- `Worker_ID`
- `Building_ID`
- `Start_date`
- `Num_days`

---

### 🔐 User Accounts

| Username   | Host      | Password | Role      | Privileges                                               |
|------------|-----------|----------|-----------|----------------------------------------------------------|
| Admin      | localhost | xyz03    | Admin     | All privileges on all tables                             |
| Manager    | localhost | 1234     | Manager   | View, insert, update data; create tables                 |
| StaffMA    | localhost | 7894     | StaffMA   | View and insert data                                     |
| StaffEmp   | localhost | pqr25    | StaffEmp  | View and update Building_ID, Start_date in Assignment    |
| Officer    | localhost | abc196   | Officer   | Full access to Building and Assignment only              |
| Worker     | localhost | qwerty   | Worker    | All privileges on Worker table only                      |