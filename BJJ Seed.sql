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

-- Create Tournaments table (BJJ tournaments)
CREATE TABLE Tournaments (
    tournament_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    date DATE NOT NULL
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
    FOREIGN KEY (person2_id) REFERENCES People(person_id),
    FOREIGN KEY (tournament_id) REFERENCES Tournaments(tournament_id)
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

-- a. Selecting data from one table
SELECT * FROM People;

-- b. Selecting data from two or more tables using a JOIN condition
SELECT People.name, Schools.name AS school_name, MembershipAffiliation.join_date
FROM People
JOIN MembershipAffiliation ON People.person_id = MembershipAffiliation.person_id
JOIN Schools ON MembershipAffiliation.school_id = Schools.school_id;

-- c. Inserting a row into a table (Adding a new person to People table)
INSERT INTO People (name, age, belt_rank, gender) 
VALUES ('Andre Galvao', 41, 'Black Belt', 'Male');

-- Display the updated People table after INSERT
SELECT * FROM People;

-- d. Updating a row (Updating belt rank for Kron Gracie)
UPDATE People
SET belt_rank = 'Coral Belt'
WHERE name = 'Kron Gracie';

-- Display the updated People table after UPDATE
SELECT * FROM People;

-- e. Deleting a row (Deleting Andre Galvao from People table)
DELETE FROM People WHERE name = 'Andre Galvao';

-- Display the updated People table after DELETE
SELECT * FROM People;

-- Display data after modifications to verify correctness
SELECT * FROM MembershipAffiliation;
SELECT * FROM Rounds;
SELECT * FROM Tournaments;
