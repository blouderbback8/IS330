-- BJJ Init.sql: Create the database and tables for BJJ Lineage Tracking

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
