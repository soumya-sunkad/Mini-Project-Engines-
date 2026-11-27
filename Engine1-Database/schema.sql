-- ENGINE 1: Data & Integrity (MySQL only - no NoSQL)
-- Student Attendance Shortage Report System
CREATE DATABASE IF NOT EXISTS attendance_db;
USE attendance_db;

CREATE TABLE students (
    usn        VARCHAR(12)  PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    email      VARCHAR(120) NOT NULL UNIQUE,
    division   CHAR(1)      NOT NULL,
    semester   TINYINT      NOT NULL CHECK (semester BETWEEN 1 AND 8)
) ENGINE=InnoDB;

CREATE TABLE subjects (
    code       VARCHAR(10)  PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    semester   TINYINT      NOT NULL CHECK (semester BETWEEN 1 AND 8)
) ENGINE=InnoDB;

-- One row = one student, one subject, one class day
CREATE TABLE attendance (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    usn          VARCHAR(12) NOT NULL,
    subject_code VARCHAR(10) NOT NULL,
    class_date   DATE        NOT NULL,
    status       ENUM('P','A') NOT NULL,
    marked_at    TIMESTAMP   DEFAULT CURRENT_TIMESTAMP,
    -- Rule: no duplicate posting
    CONSTRAINT uq_attendance UNIQUE (usn, subject_code, class_date),
    -- Rule: no orphan record
    CONSTRAINT fk_att_student FOREIGN KEY (usn) REFERENCES students(usn) ON DELETE RESTRICT,
    CONSTRAINT fk_att_subject FOREIGN KEY (subject_code) REFERENCES subjects(code) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Audit trail: what was posted, which record, when
CREATE TABLE audit_log (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    action     VARCHAR(30)  NOT NULL,
    record_key VARCHAR(100) NOT NULL,
    details    VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE VIEW v_attendance_summary AS
SELECT s.usn, s.name, s.email, sub.code AS subject_code, sub.name AS subject_name,
       SUM(a.status='P') AS present,
       COUNT(*)          AS total,
       ROUND(100*SUM(a.status='P')/COUNT(*), 2) AS percentage
FROM attendance a
JOIN students s   ON s.usn  = a.usn
JOIN subjects sub ON sub.code = a.subject_code
GROUP BY s.usn, s.name, s.email, sub.code, sub.name;

CREATE INDEX idx_att_usn ON attendance(usn);
-- ==========================================
-- FACULTY TABLE
-- ==========================================

CREATE TABLE IF NOT EXISTS faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- ==========================================
-- FACULTY SUBJECT ALLOCATION
-- ==========================================

CREATE TABLE IF NOT EXISTS faculty_subject (
    allocation_id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_id INT NOT NULL,
    subject_code VARCHAR(20) NOT NULL,

    UNIQUE KEY unique_faculty_subject
    (faculty_id, subject_code),

    FOREIGN KEY (faculty_id)
    REFERENCES faculty(faculty_id)
    ON DELETE CASCADE,

    FOREIGN KEY (subject_code)
    REFERENCES subjects(code)
    ON DELETE CASCADE
) ENGINE=InnoDB;