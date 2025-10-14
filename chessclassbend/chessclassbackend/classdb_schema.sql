-- DDL: Create tables for classdb
CREATE DATABASE IF NOT EXISTS classdb;
USE classdb;

CREATE TABLE teacher (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    topic VARCHAR(255) NOT NULL,
    teacher_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    duration INT NOT NULL, -- duration in minutes
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)
);

-- New table for class schedule days
CREATE TABLE class_schedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    day_of_week ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
    FOREIGN KEY (class_id) REFERENCES class(id)
);

CREATE TABLE class_student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    student_id INT NOT NULL,
    attended BOOLEAN DEFAULT FALSE,
    commentary TEXT,
    FOREIGN KEY (class_id) REFERENCES class(id),
    FOREIGN KEY (student_id) REFERENCES student(id)
);

-- DML: Insert fake data
INSERT INTO teacher (name, email) VALUES
('Alice Smith', 'alice.smith@school.com'),
('Bob Johnson', 'bob.johnson@school.com');

INSERT INTO student (name, email) VALUES
('Charlie Brown', 'charlie.brown@student.com'),
('Daisy Miller', 'daisy.miller@student.com'),
('Ethan Clark', 'ethan.clark@student.com');

INSERT INTO class (topic, teacher_id, start_time, duration) VALUES
('Chess Openings', 1, '2025-10-15 17:00:00', 90),
('Endgame Strategies', 2, '2025-10-16 18:00:00', 60);

-- New DML for class schedules
INSERT INTO class_schedule (class_id, day_of_week) VALUES
(1, 'Monday'),
(1, 'Wednesday'),
(2, 'Saturday');

INSERT INTO class_student (class_id, student_id, attended, commentary) VALUES
(1, 1, TRUE, 'Participated actively.'),
(1, 2, FALSE, 'Was sick.'),
(1, 3, TRUE, 'Asked good questions.'),
(2, 1, TRUE, 'Enjoyed the class.'),
(2, 2, TRUE, NULL),
(2, 3, FALSE, 'Missed due to family event.');
