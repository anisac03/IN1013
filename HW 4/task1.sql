-- DROP DATABASE IF EXISTS pet_database;
-- CREATE DATABASE pet_database;
-- USE pet_database;

DROP TABLE IF EXISTS petPet, petEvent;

CREATE TABLE petPet ( petname VARCHAR(15), owner VARCHAR(20), species VARCHAR(45), gender CHAR(1), birth DATE, death DATE, 
PRIMARY KEY (petname));

CREATE TABLE petEvent (petname VARCHAR(15), eventdate DATE, eventtype VARCHAR(45), remark VARCHAR(255),
FOREIGN KEY (petname) REFERENCES petPet(petname), PRIMARY KEY (eventdate));

