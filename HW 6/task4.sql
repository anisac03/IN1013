-- Drop the database if it exists
--DROP DATABASE IF EXISTS restaurant_database;

-- Create the database
--CREATE DATABASE restaurant_database;

-- Use the new database
--USE restaurant_database;

-- Drop tables if they exist
--DROP TABLE IF EXISTS restStaff, restRest_table, restBill, restRoom_management;

CREATE TABLE restStaff (
    staff_no INTEGER PRIMARY KEY,
    first_name VARCHAR(15),
    surname VARCHAR(15),
    headwaiter INTEGER,
    FOREIGN KEY (headwaiter) REFERENCES restStaff(staff_no)
);

CREATE TABLE restRest_table (
    table_no INTEGER PRIMARY KEY,
    no_of_seats INTEGER,
    room_name VARCHAR(5)
);

CREATE TABLE restRoom_management (
    room_name VARCHAR(15),
    room_date INTEGER,
    headwaiter INTEGER,
    FOREIGN KEY (headwaiter) REFERENCES restStaff (staff_no),
    PRIMARY KEY (room_name, room_date)
);

create table restBill (
    bill_no INTEGER PRIMARY KEY,
    bill_date INTEGER,
    bill_total DECIMAL(6,2),
    cust_name CHAR(20),
    covers INTEGER,
    table_no INTEGER,
    waiter_no INTEGER,
    FOREIGN KEY (table_no) REFERENCES restRest_table (table_no),
    FOREIGN KEY (waiter_no) REFERENCES restStaff (staff_no)
);


INSERT INTO restStaff VALUES
    (005, 'Alphonso', 'Moss', NULL),
    (006, 'Jack', 'Hunt', NULL),
    (010, 'Charles','Watson', NULL),
    (001, 'John', 'Paul', 005),
    (002, 'Paul', 'Smith', 006),
    (003, 'Zoe', 'Ball', 005),
    (004, 'Sam', 'Pitt', 006),
    (007, 'Jimmy', 'Smith', 005),
    (008, 'Tim', 'Jackson', 005),
    (009, 'David', 'Campbell', 006),
    (011, 'Chris', 'Smart', 010);

INSERT INTO restRest_table VALUES
    (001, 7, 'Blue'),
    (002, 6, 'Blue'),
    (003, 10, 'Blue'),
    (004, 7, 'Red'),
    (005, 4, 'Red'),
    (006, 7, 'Red'),
    (007, 6, 'Red'),
    (008, 6, 'Green'),
    (009, 5, 'Green');

INSERT INTO restRoom_management VALUES
    ('Blue', 160312, 005),
    ('Blue', 160105, 005),   
    ('Blue', 160210, 006),
    ('Blue', 160215, 005),
    ('Blue', 150614, 005),
    ('Red', 160307, 006),
    ('Red', 151231, 006),
    ('Red', 160111, 006),
    ('Red', 160312, 005),
    ('Red', 160210, 005),
    ('Red', 160115, 006),
    ('Green', 160105, 010),
    ('Green', 160111, 010),
    ('Green', 160215, 010),
    ('Green', 151231, 010);
       
INSERT INTO restBill VALUES
    (00001, 160312, 200.99, 'Tony Beebee', 3, 001, 002),
    (00002, 160105, 500.47, 'David Hookman', 7, 002, 003),         
    (00003, 151231, 400.33, 'Jack Pitt', 4, 005, 004),         
    (00004, 151231, 600.91, 'Bob Crow', 2, 004, 004),             
    (00005, 150614, 400.23, 'Beck Smith', 7, 006, 002),
    (00007, 160111, 237.37, 'Terry Jones', 4, 004, 002),
    (00008, 160111, 396.00, 'Tony Beebee', 2, 005, 004),
    (00009, 160111, 101.00, 'Tanya Singh', 1, 006, 004),
    (00010, 160111, 272.01, 'Bob Crow', 3, 008, 011),
    (00011, 160111, 777.11, 'Nerida Smith', 5, 009, 011),
    (00012, 160312, 1665.27, 'David Hookman', 10, 003, 003),
    (00013, 160312, 831.00, 'Tanya Singh', 4, 001, 008),
    (00014, 151231, 555.66, 'Terry Jones', 3, 008, 011),
    (00015, 151231, 102.35, 'Sunil Shah', 2, 009, 011),
    (00016, 160111, 232.11, 'Bob Crow', 4, 009, 011),
    (00017, 160210, 311.11, 'Tanya Singh', 2, 001, 003),
    (00018, 160210, 89.99, 'Bob Crow', 3, 006, 009),
    (00019, 160210, 109.31, 'Nerida Smith', 2, 008, 011),
    (00020, 160215, 444.44, 'Bob Crow', 4, 001, 007),
    (00021, 160215, 131.11, 'Nancy Smith', 2, 009, 011),
    (00022, 160312, 545.01, 'Sunil Shah', 4, 006, 004);

-- 1
SELECT DISTINCT restBill.cust_name
FROM restBill
INNER JOIN restStaff ON restBill.waiter_no = restStaff.staff_no  -- Joins with restStaff to get waiter details
INNER JOIN restRest_table ON restBill.table_no = restRest_table.table_no  -- Joins with restRest_table to get table details
INNER JOIN restRoom_management ON restRest_table.room_name = restRoom_management.room_name  -- Joins with restRoom_management to get room details
AND restBill.bill_date = restRoom_management.room_date  -- Ensures the bill date matches the room date
WHERE restStaff.first_name = 'Charles'  -- Only considers rows where the waiter's name is Charles
AND restBill.bill_total > 450.00;  -- Only considers bills greater than 450

-- 2
SELECT CONCAT(restStaff.first_name, ' ', restStaff.surname) AS headwaiter_name
FROM restBill
INNER JOIN restStaff ON restBill.waiter_no = restStaff.staff_no  -- Joins with restStaff to get waiter details
INNER JOIN restRest_table ON restBill.table_no = restRest_table.table_no  -- Joins with restRest_table to get table details
INNER JOIN restRoom_management ON restRest_table.room_name = restRoom_management.room_name  -- Joins with restRoom_management for room details
AND restBill.bill_date = restRoom_management.room_date  -- Ensures the bill date matches the room date
WHERE restBill.cust_name = 'Nerida'  -- Filters for the customer Nerida
AND restBill.bill_date = 20160111  -- Filters for the specific date, YYYYMMDD format
AND restRoom_management.room_date = 20160111  -- Ensures the room date matches, YYYYMMDD format
AND restRoom_management.headwaiter IS NOT NULL;  -- Ensures there's a headwaiter for that day

-- 3
SELECT restBill.cust_name
FROM restBill
WHERE restBill.bill_total = (
    SELECT MIN(bill_total) FROM restBill  -- Subquery to find the smallest bill total
);

-- 4
SELECT CONCAT(restStaff.first_name, ' ', restStaff.surname) AS waiter_name
FROM restStaff
LEFT JOIN restBill ON restStaff.staff_no = restBill.waiter_no  -- Left join to include waiters even if they don't have associated bills
WHERE restBill.bill_no IS NULL;  -- Filter for waiters who have not taken any bills

-- 5
SELECT restBill.cust_name, 
       CONCAT(restStaff.first_name, ' ', restStaff.surname) AS headwaiter_name,
       restRoom_management.room_name
FROM restBill
INNER JOIN restStaff ON restBill.waiter_no = restStaff.staff_no  -- Joins with restStaff to get waiter details
INNER JOIN restRest_table ON restBill.table_no = restRest_table.table_no  -- Joins with restRest_table for table details
INNER JOIN restRoom_management ON restRest_table.room_name = restRoom_management.room_name  -- Joins with restRoom_management for room details
AND restBill.bill_date = restRoom_management.room_date  -- Ensures the bill date matches the room date
WHERE restBill.bill_total = (SELECT MAX(bill_total) FROM restBill);  -- Filters for the largest bill
