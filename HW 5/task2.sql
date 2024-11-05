
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


-- Task 2:

-- 1
SELECT SUM(bill_total) AS Income -- Calculates the total sum of all 'bill_total' values
FROM restBill;

-- 2
SELECT SUM(bill_total) AS `Feb Income` -- Calculates the total income for February 2016
FROM restBill
WHERE bill_date BETWEEN 160201 AND 160229; -- Filters records for bills with dates in February 2016

-- 3
SELECT AVG(bill_total) AS average_bill -- Calculates the average of the 'bill_total' values
FROM restBill
WHERE table_no = 002; -- Filters for bills associated with table number 002

-- 4
SELECT 
    MIN(no_of_seats) AS Min,
    MAX(no_of_seats) AS Max,
    AVG(no_of_seats) AS Avg -- Finds the min. and max. number of seats available in the 'Blue' room and calculates the average number of seats in the 'Blue' room
FROM restRest_table
WHERE room_name = 'Blue'; -- Filters for the 'Blue' room

-- 5
SELECT COUNT(DISTINCT table_no) AS distinct_tables -- Counts the distinct table numbers served by specific waiters
FROM restBill
WHERE waiter_no IN (004, 002); -- Filters so only bills served by waiters 004 or 002 are included


-- Task 3:

-- 1
SELECT DISTINCT 
    CONCAT(restStaff.first_name, ' ', restStaff.surname) AS waiter_name
FROM restBill
INNER JOIN restStaff 
    ON restBill.waiter_no = restStaff.staff_no  -- Join condition: matching waiter_no with staff_no
WHERE restBill.cust_name = 'Tanya Singh';  -- Filters for customer name 'Tanya Singh'

-- 2
SELECT restRoom_management.room_date
FROM restRoom_management
INNER JOIN restStaff 
    ON restRoom_management.headwaiter = restStaff.staff_no  -- Join condition: matching headwaiter with staff_no
WHERE restStaff.first_name = 'Charles' 
    AND restRoom_management.room_name = 'Green' 
    AND restRoom_management.room_date BETWEEN 160201 AND 160229;  -- Filters by February 2016 dates

-- 3
SELECT 
    restStaff.first_name, 
    restStaff.surname
FROM restStaff
WHERE restStaff.headwaiter = (
    SELECT restStaff.headwaiter 
    FROM restStaff 
    WHERE restStaff.first_name = 'Zoe' 
    AND restStaff.surname = 'Ball'  -- finding the headwaiter for Zoe Ball
);

-- 4
SELECT 
    restBill.cust_name, 
    restBill.bill_total, 
    CONCAT(restStaff.first_name, ' ', restStaff.surname) AS waiter_name
FROM restBill
INNER JOIN restStaff 
    ON restBill.waiter_no = restStaff.staff_no  -- Join condition: matching waiter_no with staff_no
ORDER BY restBill.bill_total DESC;  -- bill total displayed in descending order

 -- 5
SELECT DISTINCT 
    CONCAT(restStaff.first_name, ' ', restStaff.surname) AS waiter_name
FROM restBill
INNER JOIN restStaff 
    ON restBill.waiter_no = restStaff.staff_no  -- Join condition: matching waiter_no with staff_no
WHERE restBill.table_no IN (
    SELECT DISTINCT restBill.table_no 
    FROM restBill 
    WHERE restBill.bill_no IN (00014, 00017)  -- Filters for specific bill numbers
);

-- 6
SELECT DISTINCT 
    CONCAT(restStaff.first_name, ' ', restStaff.surname) AS waiter_name
FROM restStaff
WHERE restStaff.staff_no IN (
    SELECT DISTINCT restBill.waiter_no
    FROM restBill
    WHERE restBill.table_no IN (
        SELECT restRest_table.table_no 
        FROM restRest_table 
        WHERE restRest_table.room_name = 'Blue'  -- finds tables in the 'Blue' room
    )
) 
OR restStaff.staff_no IN (
    SELECT restRoom_management.headwaiter 
    FROM restRoom_management
    WHERE restRoom_management.room_name = 'Blue' 
    AND restRoom_management.room_date = 160312  -- finds headwaiter for the specific date
);