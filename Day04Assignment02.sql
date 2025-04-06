-- 2020ICT101 - IT3223(P) - Day04 - Assignment02

Setting environment for using XAMPP for Windows.
Achira Wijesuriya@DESKTOP-8FO0AKP c:\xampp
# mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 8
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

-- Create the database with Name of Construction
MariaDB [(none)]> CREATE DATABASE Construction;
Query OK, 1 row affected (0.013 sec)

MariaDB [(none)]> USE Construction;
Database changed
MariaDB [Construction]> CREATE TABLE Worker (
    ->     Worker_ID INT PRIMARY KEY,
    ->     Worker_name VARCHAR(50),
    ->     Hourly_rate DECIMAL(5,2),
    ->     Skill_type VARCHAR(30),
    ->     Supervisor_ID INT
    -> );
Query OK, 0 rows affected (0.009 sec)

MariaDB [Construction]> CREATE TABLE Building (
    ->     Building_ID INT PRIMARY KEY,
    ->     Building_Address VARCHAR(100),
    ->     Type_of_Bldg VARCHAR(30),
    ->     Qlty_Level INT,
    ->     Status INT
    -> );
Query OK, 0 rows affected (0.019 sec)

MariaDB [Construction]> CREATE TABLE Assignment (
    ->     Worker_ID INT,
    ->     Building_ID INT,
    ->     Start_date DATE,
    ->     Num_days INT,
    ->     FOREIGN KEY (Worker_ID) REFERENCES Worker(Worker_ID),
    ->     FOREIGN KEY (Building_ID) REFERENCES Building(Building_ID)
    -> );
Query OK, 0 rows affected (0.033 sec)

MariaDB [Construction]> INSERT INTO Worker VALUES
    -> (1235, 'M.Faraday', 12.5, 'Electric', 1311),
    -> (1412, 'C.Nemo', 13.75, 'Plumbing', 1520),
    -> (2920, 'R.Garret', 10, 'Roofing', 2920),
    -> (3231, 'P.Mason', 17.4, 'Framing', 3231),
    -> (1520, 'H.Rickover', 11.75, 'Plumbing', 1520),
    -> (1311, 'C.Coulomb', 15.5, 'Electric', 1311),
    -> (3001, 'J.Barrister', 8.2, 'Framing', 3231);
Query OK, 7 rows affected (0.060 sec)
Records: 7  Duplicates: 0  Warnings: 0

MariaDB [Construction]> INSERT INTO Building VALUES
    -> (312, '123 Elm', 'Office', 2, 2),
    -> (435, '456 Maple', 'Retail', 1, 1),
    -> (515, '789 Oak', 'Residence', 3, 1),
    -> (210, '1011 Brich', 'Office', 3, 1),
    -> (111, '1213 Aspen', 'Office', 4, 1),
    -> (460, '1415 Beech', 'Warehouse', 3, 3);
Query OK, 6 rows affected (0.014 sec)
Records: 6  Duplicates: 0  Warnings: 0

MariaDB [Construction]> INSERT INTO Assignment VALUES
    -> (1235, 312, '2016-10-10', 5),
    -> (1412, 312, '2016-10-01', 10),
    -> (1235, 515, '2016-10-17', 22),
    -> (2920, 460, '2016-10-05', 18),
    -> (1412, 460, '2016-12-08', 18),
    -> (2920, 435, '2016-10-28', 10),
    -> (2920, 210, '2016-11-10', 15),
    -> (3231, 111, '2016-10-10', 8),
    -> (1412, 435, '2016-10-15', 15),
    -> (1412, 515, '2016-11-05', 8),
    -> (3231, 312, '2016-10-24', 20),
    -> (1520, 515, '2016-10-09', 14),
    -> (1311, 435, '2016-10-08', 12),
    -> (1412, 210, '2016-11-15', 12),
    -> (1412, 111, '2016-12-01', 4),
    -> (3001, 111, '2016-10-08', 14),
    -> (1311, 460, '2016-10-23', 24),
    -> (1520, 312, '2016-10-30', 17),
    -> (3001, 210, '2016-10-27', 14);
Query OK, 19 rows affected (0.010 sec)
Records: 19  Duplicates: 0  Warnings: 0

-- 01. Who are the plumbers?
MariaDB [Construction]> SELECT * FROM Worker WHERE Skill_type = 'Plumbing';
+-----------+-------------+-------------+------------+---------------+
| Worker_ID | Worker_name | Hourly_rate | Skill_type | Supervisor_ID |
+-----------+-------------+-------------+------------+---------------+
|      1412 | C.Nemo      |       13.75 | Plumbing   |          1520 |
|      1520 | H.Rickover  |       11.75 | Plumbing   |          1520 |
+-----------+-------------+-------------+------------+---------------+
2 rows in set (0.001 sec)

-- 02. List all data about office buildings?
MariaDB [Construction]> SELECT * FROM Building WHERE Type_of_Bldg = 'Office';
+-------------+------------------+--------------+------------+--------+
| Building_ID | Building_Address | Type_of_Bldg | Qlty_Level | Status |
+-------------+------------------+--------------+------------+--------+
|         111 | 1213 Aspen       | Office       |          4 |      1 |
|         210 | 1011 Brich       | Office       |          3 |      1 |
|         312 | 123 Elm          | Office       |          2 |      2 |
+-------------+------------------+--------------+------------+--------+
3 rows in set (0.001 sec)

-- 03. What is the weekly (5 days, 8 hours per day) wage rate for each electrician?
MariaDB [Construction]> SELECT Worker_name, Hourly_rate * 8 * 5 AS Weekly_Wage
    -> FROM Worker
    -> WHERE Skill_type = 'Electric';
+-------------+-------------+
| Worker_name | Weekly_Wage |
+-------------+-------------+
| M.Faraday   |      500.00 |
| C.Coulomb   |      620.00 |
+-------------+-------------+
2 rows in set (0.002 sec)

-- 04. What are the lowest and highest hourly wages?
MariaDB [Construction]> SELECT MIN(Hourly_rate) AS MinRate, MAX(Hourly_rate) AS MaxRate FROM Worker;
+---------+---------+
| MinRate | MaxRate |
+---------+---------+
|    8.20 |   17.40 |
+---------+---------+
1 row in set (0.001 sec)

--05. How many different skill types are there?
MariaDB [Construction]> SELECT COUNT(DISTINCT Skill_type) AS SkillTypes FROM Worker;
+------------+
| SkillTypes |
+------------+
|          4 |
+------------+
1 row in set (0.001 sec)

-- 06. Who gets hourly rate between $10 and $12?
MariaDB [Construction]> SELECT * FROM Worker WHERE Hourly_rate BETWEEN 10 AND 12;
+-----------+-------------+-------------+------------+---------------+
| Worker_ID | Worker_name | Hourly_rate | Skill_type | Supervisor_ID |
+-----------+-------------+-------------+------------+---------------+
|      1520 | H.Rickover  |       11.75 | Plumbing   |          1520 |
|      2920 | R.Garret    |       10.00 | Roofing    |          2920 |
+-----------+-------------+-------------+------------+---------------+
2 rows in set (0.000 sec)

-- 07. What are the skill types of workers assigned to building 435?
MariaDB [Construction]> SELECT DISTINCT Skill_type
    -> FROM Worker
    -> WHERE Worker_ID IN (SELECT Worker_ID FROM Assignment WHERE Building_ID = 435);
+------------+
| Skill_type |
+------------+
| Electric   |
| Plumbing   |
| Roofing    |
+------------+
3 rows in set (0.001 sec)

-- 08. List the workers name with the names of their supervisors?
MariaDB [Construction]> SELECT W.Worker_name AS Worker, S.Worker_name AS Supervisor
    -> FROM Worker W
    -> LEFT JOIN Worker S ON W.Supervisor_ID = S.Worker_ID;
+-------------+------------+
| Worker      | Supervisor |
+-------------+------------+
| M.Faraday   | C.Coulomb  |
| C.Coulomb   | C.Coulomb  |
| C.Nemo      | H.Rickover |
| H.Rickover  | H.Rickover |
| R.Garret    | R.Garret   |
| J.Barrister | P.Mason    |
| P.Mason     | P.Mason    |
+-------------+------------+
7 rows in set (0.001 sec)

-- 09. List the building id and name of workers assigned to office buildings?
MariaDB [Construction]> SELECT A.Building_ID, W.Worker_name
    -> FROM Assignment A
    -> JOIN Building B ON A.Building_ID = B.Building_ID
    -> JOIN Worker W ON A.Worker_ID = W.Worker_ID
    -> WHERE B.Type_of_Bldg = 'Office';
+-------------+-------------+
| Building_ID | Worker_name |
+-------------+-------------+
|         111 | P.Mason     |
|         111 | C.Nemo      |
|         111 | J.Barrister |
|         210 | R.Garret    |
|         210 | C.Nemo      |
|         210 | J.Barrister |
|         312 | M.Faraday   |
|         312 | C.Nemo      |
|         312 | P.Mason     |
|         312 | H.Rickover  |
+-------------+-------------+
10 rows in set (0.012 sec)

-- 10. List workers who receive a higher hourly wage than their supervisors?
MariaDB [Construction]> SELECT W.Worker_name
    -> FROM Worker W
    -> JOIN Worker S ON W.Supervisor_ID = S.Worker_ID
    -> WHERE W.Hourly_rate > S.Hourly_rate;
+-------------+
| Worker_name |
+-------------+
| C.Nemo      |
+-------------+
1 row in set (0.000 sec)

-- 11. For each supervisor managing more than one worker, what is the highest hourly wage paid to a worker reporting to that supervisor?
MariaDB [Construction]> SELECT Supervisor_ID, MAX(Hourly_rate) AS HighestRate
    -> FROM Worker
    -> WHERE Supervisor_ID != Worker_ID
    -> GROUP BY Supervisor_ID
    -> HAVING COUNT(*) > 1;
Empty set (0.001 sec)

-- 12. List the earnings of all plumbers?
MariaDB [Construction]> SELECT W.Worker_name, SUM(A.Num_days * 8 * W.Hourly_rate) AS TotalEarnings
    -> FROM Worker W
    -> JOIN Assignment A ON W.Worker_ID = A.Worker_ID
    -> WHERE W.Skill_type = 'Plumbing'
    -> GROUP BY W.Worker_name;
+-------------+---------------+
| Worker_name | TotalEarnings |
+-------------+---------------+
| C.Nemo      |       7370.00 |
| H.Rickover  |       2914.00 |
+-------------+---------------+
2 rows in set (0.002 sec)

-- 13. What is the maximum earning of plumber? 
MariaDB [Construction]> SELECT MAX(TotalEarnings) AS MaxPlumberEarning FROM (
    ->     SELECT W.Worker_name, SUM(A.Num_days * 8 * W.Hourly_rate) AS TotalEarnings
    ->     FROM Worker W
    ->     JOIN Assignment A ON W.Worker_ID = A.Worker_ID
    ->     WHERE W.Skill_type = 'Plumbing'
    ->     GROUP BY W.Worker_name
    -> ) AS Sub;
+-------------------+
| MaxPlumberEarning |
+-------------------+
|           7370.00 |
+-------------------+
1 row in set (0.002 sec)

-- 14. Create the following user accounts
-- (Manager, localhost, 1234)
MariaDB [Construction]> CREATE USER 'Manager'@'localhost' IDENTIFIED BY '1234';
Query OK, 0 rows affected (0.015 sec)

-- (StaffMA, localhost, 7894)
MariaDB [Construction]> CREATE USER 'StaffMA'@'localhost' IDENTIFIED BY '7894';
Query OK, 0 rows affected (0.002 sec)

-- (Admin, localhost, xyz03)
MariaDB [Construction]> CREATE USER 'Admin'@'localhost' IDENTIFIED BY 'xyz03';
Query OK, 0 rows affected (0.002 sec)

-- (StaffEmp, localhost, pqr25)
MariaDB [Construction]> CREATE USER 'StaffEmp'@'localhost' IDENTIFIED BY 'pqr25';
Query OK, 0 rows affected (0.002 sec)

-- (Officer, localhost, abc196)
MariaDB [Construction]> CREATE USER 'Officer'@'localhost' IDENTIFIED BY 'abc196';
Query OK, 0 rows affected (0.002 sec)

-- (Worker, localhost, qwerty)
MariaDB [Construction]> CREATE USER 'Worker'@'localhost' IDENTIFIED BY 'qwerty';
Query OK, 0 rows affected (0.011 sec)

-- 15. For the Admin user, give all privileges to all tables in the Construction database.
MariaDB [Construction]> GRANT ALL PRIVILEGES ON Construction.* TO 'Admin'@'localhost';
Query OK, 0 rows affected (0.012 sec)

-- 16.
-- Manager - Can view data, add any new data, modify existing data, Create new tables on Construction Database.
MariaDB [Construction]> GRANT SELECT, INSERT, UPDATE, CREATE ON Construction.* TO 'Manager'@'localhost';
Query OK, 0 rows affected (0.012 sec)

-- StaffMA - Able to view data, add any new data on Construction Database.
MariaDB [Construction]> GRANT SELECT, INSERT ON Construction.* TO 'StaffMA'@'localhost';
Query OK, 0 rows affected (0.012 sec)

-- StaffEmp - Can View all data in the assignment table and also Update only the building ID and start date columns in the assignment table
MariaDB [Construction]> GRANT SELECT, UPDATE(Building_ID, Start_date) ON Construction.Assignment TO 'StaffEmp'@'localhost';
Query OK, 0 rows affected (0.012 sec)

-- Officer - Can View data, add new data, Modify existing data These privileges apply only to the building and assignment tables.
MariaDB [Construction]> GRANT SELECT, INSERT, UPDATE ON Construction.Building TO 'Officer'@'localhost';
Query OK, 0 rows affected (0.012 sec)

MariaDB [Construction]> GRANT SELECT, INSERT, UPDATE ON Construction.Assignment TO 'Officer'@'localhost';
Query OK, 0 rows affected (0.002 sec)

-- Worker - give all privileges to Access only the worker table
MariaDB [Construction]> GRANT ALL PRIVILEGES ON Construction.Worker TO 'Worker'@'localhost';
Query OK, 0 rows affected (0.012 sec)

MariaDB [Construction]> EXIT;
Bye


-- 17. Login to Manager and view all data
Achira Wijesuriya@DESKTOP-8FO0AKP c:\xampp
# mysql -u Manager -p
Enter password: ****
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 9
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> USE Construction;
Database changed
MariaDB [Construction]> SELECT * FROM Worker;
+-----------+-------------+-------------+------------+---------------+
| Worker_ID | Worker_name | Hourly_rate | Skill_type | Supervisor_ID |
+-----------+-------------+-------------+------------+---------------+
|      1235 | M.Faraday   |       12.50 | Electric   |          1311 |
|      1311 | C.Coulomb   |       15.50 | Electric   |          1311 |
|      1412 | C.Nemo      |       13.75 | Plumbing   |          1520 |
|      1520 | H.Rickover  |       11.75 | Plumbing   |          1520 |
|      2920 | R.Garret    |       10.00 | Roofing    |          2920 |
|      3001 | J.Barrister |        8.20 | Framing    |          3231 |
|      3231 | P.Mason     |       17.40 | Framing    |          3231 |
+-----------+-------------+-------------+------------+---------------+
7 rows in set (0.003 sec)

MariaDB [Construction]> SELECT * FROM Building;
+-------------+------------------+--------------+------------+--------+
| Building_ID | Building_Address | Type_of_Bldg | Qlty_Level | Status |
+-------------+------------------+--------------+------------+--------+
|         111 | 1213 Aspen       | Office       |          4 |      1 |
|         210 | 1011 Brich       | Office       |          3 |      1 |
|         312 | 123 Elm          | Office       |          2 |      2 |
|         435 | 456 Maple        | Retail       |          1 |      1 |
|         460 | 1415 Beech       | Warehouse    |          3 |      3 |
|         515 | 789 Oak          | Residence    |          3 |      1 |
+-------------+------------------+--------------+------------+--------+
6 rows in set (0.001 sec)

MariaDB [Construction]> SELECT * FROM Assignment;
+-----------+-------------+------------+----------+
| Worker_ID | Building_ID | Start_date | Num_days |
+-----------+-------------+------------+----------+
|      1235 |         312 | 2016-10-10 |        5 |
|      1412 |         312 | 2016-10-01 |       10 |
|      1235 |         515 | 2016-10-17 |       22 |
|      2920 |         460 | 2016-10-05 |       18 |
|      1412 |         460 | 2016-12-08 |       18 |
|      2920 |         435 | 2016-10-28 |       10 |
|      2920 |         210 | 2016-11-10 |       15 |
|      3231 |         111 | 2016-10-10 |        8 |
|      1412 |         435 | 2016-10-15 |       15 |
|      1412 |         515 | 2016-11-05 |        8 |
|      3231 |         312 | 2016-10-24 |       20 |
|      1520 |         515 | 2016-10-09 |       14 |
|      1311 |         435 | 2016-10-08 |       12 |
|      1412 |         210 | 2016-11-15 |       12 |
|      1412 |         111 | 2016-12-01 |        4 |
|      3001 |         111 | 2016-10-08 |       14 |
|      1311 |         460 | 2016-10-23 |       24 |
|      1520 |         312 | 2016-10-30 |       17 |
|      3001 |         210 | 2016-10-27 |       14 |
+-----------+-------------+------------+----------+
19 rows in set (0.001 sec)

MariaDB [Construction]> EXIT;
Bye


-- 18. Login to StaffEmp and Check whether he can only access Assignment Table or not 
Achira Wijesuriya@DESKTOP-8FO0AKP c:\xampp
# mysql -u StaffEmp -p
Enter password: *****
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 10
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> USE Construction;
Database changed
MariaDB [Construction]> SELECT * FROM Assignment;
+-----------+-------------+------------+----------+
| Worker_ID | Building_ID | Start_date | Num_days |
+-----------+-------------+------------+----------+
|      1235 |         312 | 2016-10-10 |        5 |
|      1412 |         312 | 2016-10-01 |       10 |
|      1235 |         515 | 2016-10-17 |       22 |
|      2920 |         460 | 2016-10-05 |       18 |
|      1412 |         460 | 2016-12-08 |       18 |
|      2920 |         435 | 2016-10-28 |       10 |
|      2920 |         210 | 2016-11-10 |       15 |
|      3231 |         111 | 2016-10-10 |        8 |
|      1412 |         435 | 2016-10-15 |       15 |
|      1412 |         515 | 2016-11-05 |        8 |
|      3231 |         312 | 2016-10-24 |       20 |
|      1520 |         515 | 2016-10-09 |       14 |
|      1311 |         435 | 2016-10-08 |       12 |
|      1412 |         210 | 2016-11-15 |       12 |
|      1412 |         111 | 2016-12-01 |        4 |
|      3001 |         111 | 2016-10-08 |       14 |
|      1311 |         460 | 2016-10-23 |       24 |
|      1520 |         312 | 2016-10-30 |       17 |
|      3001 |         210 | 2016-10-27 |       14 |
+-----------+-------------+------------+----------+
19 rows in set (0.001 sec)

MariaDB [Construction]> SELECT * FROM Worker;
ERROR 1142 (42000): SELECT command denied to user 'StaffEmp'@'localhost' for table `construction`.`worker`
MariaDB [Construction]> SELECT * FROM Building;
ERROR 1142 (42000): SELECT command denied to user 'StaffEmp'@'localhost' for table `construction`.`building`

-- 19. Update the Start_Date as ‘2016-10-10’ where Building =515
MariaDB [Construction]> UPDATE Assignment
    -> SET Start_date = '2016-10-10'
    -> WHERE Building_ID = 515;
Query OK, 3 rows affected (0.012 sec)
Rows matched: 3  Changed: 3  Warnings: 0

MariaDB [Construction]> EXIT;
Bye


-- 20. Login to Worker Account and Check whether he can only access Worker Table, View all data in the Worker Table 
Achira Wijesuriya@DESKTOP-8FO0AKP c:\xampp
# mysql -u Worker -p
Enter password: ******
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 11
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> USE Construction;
Database changed
MariaDB [Construction]> SELECT * FROM Worker;
+-----------+-------------+-------------+------------+---------------+
| Worker_ID | Worker_name | Hourly_rate | Skill_type | Supervisor_ID |
+-----------+-------------+-------------+------------+---------------+
|      1235 | M.Faraday   |       12.50 | Electric   |          1311 |
|      1311 | C.Coulomb   |       15.50 | Electric   |          1311 |
|      1412 | C.Nemo      |       13.75 | Plumbing   |          1520 |
|      1520 | H.Rickover  |       11.75 | Plumbing   |          1520 |
|      2920 | R.Garret    |       10.00 | Roofing    |          2920 |
|      3001 | J.Barrister |        8.20 | Framing    |          3231 |
|      3231 | P.Mason     |       17.40 | Framing    |          3231 |
+-----------+-------------+-------------+------------+---------------+
7 rows in set (0.001 sec)

MariaDB [Construction]> SELECT * FROM Assignment;
ERROR 1142 (42000): SELECT command denied to user 'Worker'@'localhost' for table `construction`.`assignment`
MariaDB [Construction]> SELECT * FROM Building;
ERROR 1142 (42000): SELECT command denied to user 'Worker'@'localhost' for table `construction`.`building`
MariaDB [Construction]>