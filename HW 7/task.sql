
-- Task 7:

-- 1) Creating the view `samsBills` to display the bills taken by Sam Pitt
CREATE VIEW samsBills AS
SELECT restStaff.first_name, restStaff.surname, restBill.bill_date, restBill.cust_name, restBill.bill_total  
FROM restBill                  
JOIN restStaff ON restBill.waiter_no = restStaff.staff_no  -- joining 'restBill' with 'restStaff' to get the waiter's name based on 'waiter_no'
WHERE restStaff.first_name = 'Sam' AND restStaff.surname = 'Pitt'; -- filtering the data to include only bills taken by Sam Pitt
SELECT * FROM samsBills; -- need to select all from 'samBills' so that the bills Sam Pitt has taken can be displayed

-- 2) Selecting all bills from the 'samsBills' view where the bill total is greater than £400
SELECT * FROM samsBills
WHERE bill_total > 400;  -- filtering bills with a total greater than £400

-- 3) Creating the view 'roomTotals' to show the total sum of bills for each room
CREATE VIEW roomTotals AS
SELECT restRest_table.room_name,  
SUM(restBill.bill_total) AS total_sum  -- total sum of bills for that room
FROM restBill                   
JOIN restRest_table ON restBill.table_no = restRest_table.table_no  -- joining 'restBill' with 'restRest_table' to connect bills with rooms
GROUP BY restRest_table.room_name;  -- grouping the results by room name to get total sums for each room
SELECT * FROM roomTotals; -- need to select all rows from the 'roomTotals' view to display the room totals

-- 4) Creating the view 'teamTotals' to show the total sum of bills for each team
CREATE VIEW teamTotals AS
SELECT CONCAT(restStaff.first_name, ' ', restStaff.surname) AS headwaiter_name, -- concatenates first and last name of the waiter to create the full name
SUM(restBill.bill_total) AS total_sum  -- total sum of bills for that team
FROM restBill                   
JOIN restStaff ON restBill.waiter_no = restStaff.staff_no  -- joining 'restBill' with 'restStaff' to get the waiter's full name
GROUP BY restStaff.staff_no, restStaff.first_name, restStaff.surname;  -- grouping by the staff to get totals for each waiter
SELECT * FROM teamTotals;-- need to select all rows from the 'teamTotals' view to display the total sums for each headwaiter
