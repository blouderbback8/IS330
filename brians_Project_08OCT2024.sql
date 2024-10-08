-- Create a new database for BJJ Lineage Tracking
DROP DATABASE IF EXISTS bjj_lineage;
CREATE DATABASE bjj_lineage;
USE bjj_lineage;

-- Create Users table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- Create People table (BJJ fighters and instructors)
CREATE TABLE People (
    person_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    belt_rank VARCHAR(50),
    gender VARCHAR(10)
);

-- Create Schools table (BJJ schools)
CREATE TABLE Schools (
    school_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- Create MembershipAffiliation table (Links People to Schools)
CREATE TABLE MembershipAffiliation (
    membership_id INT AUTO_INCREMENT PRIMARY KEY,
    person_id INT,
    school_id INT,
    join_date DATE,
    FOREIGN KEY (person_id) REFERENCES People(person_id),
    FOREIGN KEY (school_id) REFERENCES Schools(school_id)
);

-- Create Instructions table (Links Teachers to Students)
CREATE TABLE Instructions (
    instruction_id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_id INT,
    student_id INT,
    date DATE,
    FOREIGN KEY (teacher_id) REFERENCES People(person_id),
    FOREIGN KEY (student_id) REFERENCES People(person_id)
);

-- Create Rounds table (Tracks Rounds Between People in Tournaments)
CREATE TABLE Rounds (
    round_id INT AUTO_INCREMENT PRIMARY KEY,
    person1_id INT,
    person2_id INT,
    tournament_id INT,
    round_date DATE,
    FOREIGN KEY (person1_id) REFERENCES People(person_id),
    FOREIGN KEY (person2_id) REFERENCES People(person_id)
);

-- Create Tournaments table (BJJ tournaments)
CREATE TABLE Tournaments (
    tournament_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100),
    date DATE
);

-- Insert BJJ fighters into People table
INSERT INTO People (name, age, belt_rank, gender) VALUES
('Brian Ortega', 32, 'Black Belt', 'Male'),
('Kron Gracie', 35, 'Black Belt', 'Male'),
('Mackenzie Dern', 30, 'Black Belt', 'Female'),
('Rickson Gracie', 65, 'Red Belt', 'Male'),
('Helio Gracie', 95, 'Red Belt', 'Male'),
('Gordon Ryan', 28, 'Black Belt', 'Male');

-- Insert BJJ schools into Schools table
INSERT INTO Schools (name, location) VALUES
('Gracie Academy', 'Rio de Janeiro, Brazil'),
('10th Planet Jiu-Jitsu', 'Los Angeles, USA'),
('Alliance Jiu-Jitsu', 'Sao Paulo, Brazil');

-- Insert membership affiliations into MembershipAffiliation table (Links People to Schools)
INSERT INTO MembershipAffiliation (person_id, school_id, join_date) VALUES
(1, 1, '2010-01-01'), -- Brian Ortega joins Gracie Academy
(2, 1, '2005-01-01'), -- Kron Gracie joins Gracie Academy
(3, 2, '2012-06-15'), -- Mackenzie Dern joins 10th Planet
(4, 1, '1980-01-01'), -- Rickson Gracie joins Gracie Academy
(6, 3, '2018-03-10'); -- Gordon Ryan joins Alliance Jiu-Jitsu

-- Insert teacher-student relationships into Instructions table (Links Teachers to Students)
INSERT INTO Instructions (teacher_id, student_id, date) VALUES
(4, 1, '2010-01-01'), -- Rickson Gracie teaches Brian Ortega
(4, 2, '2005-01-01'), -- Rickson Gracie teaches Kron Gracie
(5, 4, '1980-01-01'); -- Helio Gracie teaches Rickson Gracie

-- Insert BJJ tournaments into Tournaments table
INSERT INTO Tournaments (name, location, date) VALUES
('IBJJF World Championship', 'Los Angeles, USA', '2023-06-15'),
('UFC 264', 'Las Vegas, USA', '2021-07-10'),
('ADCC 2022', 'Abu Dhabi, UAE', '2022-09-18');

-- Insert rounds (matches between fighters) into Rounds table
INSERT INTO Rounds (person1_id, person2_id, tournament_id, round_date) VALUES
(1, 2, 1, '2023-06-15'), -- Brian Ortega vs. Kron Gracie in IBJJF World Championship
(6, 3, 2, '2021-07-10'); -- Gordon Ryan vs. Mackenzie Dern in UFC 264

-- Display the results for all tables
SELECT * FROM Users;
SELECT * FROM People;
SELECT * FROM Schools;
SELECT * FROM MembershipAffiliation;
SELECT * FROM Instructions;
SELECT * FROM Rounds;
SELECT * FROM Tournaments;

SELECT p1.name AS person1, p2.name AS person2, t.name AS tournament_name, r.round_date
FROM Rounds r
JOIN People p1 ON r.person1_id = p1.person_id
JOIN People p2 ON r.person2_id = p2.person_id
JOIN Tournaments t ON r.tournament_id = t.tournament_id
WHERE t.name = 'IBJJF World Championship';
-- 1. Find all students taught by Rickson Gracie: 
-- This could be useful for tracking the lineage of students under a specific teacher.

SELECT p.name AS student_name
FROM Instructions i
JOIN People p ON i.student_id = p.person_id
WHERE i.teacher_id = (SELECT person_id FROM People WHERE name = 'Rickson Gracie');

-- 2. List all members of Gracie Academy:
-- Useful for identifying everyone associated with a specific BJJ school.

SELECT p.name AS person_name
FROM MembershipAffiliation ma
JOIN People p ON ma.person_id = p.person_id
WHERE ma.school_id = (SELECT school_id FROM Schools WHERE name = 'Gracie Academy');

-- 3. Find all rounds that took place in a specific tournament (e.g., IBJJF World Championship):
-- Helps track matchups in a specific tournament.

SELECT p1.name AS person1, p2.name AS person2, t.name AS tournament_name, r.round_date
FROM Rounds r
JOIN People p1 ON r.person1_id = p1.person_id
JOIN People p2 ON r.person2_id = p2.person_id
JOIN Tournaments t ON r.tournament_id = t.tournament_id
WHERE t.name = 'IBJJF World Championship';
