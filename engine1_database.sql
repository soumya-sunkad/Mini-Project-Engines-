DROP DATABASE IF EXISTS attendance_db;

CREATE DATABASE attendance_db;

USE attendance_db;

-- Create Faculty Table
CREATE TABLE faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL DEFAULT 'BCA',
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Create Course Table
CREATE TABLE course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_title VARCHAR(120) NOT NULL,
    total_hours INT NOT NULL CHECK (total_hours > 0),
    credits INT NOT NULL CHECK (credits > 0)
);

-- Create Student Table
CREATE TABLE student (
    usn VARCHAR(20) PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    semester INT NOT NULL CHECK (semester BETWEEN 1 AND 6),
    section CHAR(1) NOT NULL CHECK (section IN ('A', 'B', 'C')),
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Verify Tables
SHOW TABLES;