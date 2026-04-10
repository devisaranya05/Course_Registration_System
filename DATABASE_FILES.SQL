USE course_registration_system;

CREATE TABLE admins (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(150) NOT NULL,
    department VARCHAR(100) NOT NULL,
    faculty VARCHAR(100),
    duration INT, -- in weeks
    fee DECIMAL(10,2),
    max_capacity INT NOT NULL,
    status ENUM('Upcoming', 'Ongoing', 'Completed') DEFAULT 'Upcoming',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Active', 'Dropped') DEFAULT 'Active',

    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON DELETE CASCADE,

    UNIQUE(student_id, course_id)
);

CREATE TABLE deadlines (
    deadline_id INT PRIMARY KEY AUTO_INCREMENT,
    registration_start DATE NOT NULL,
    registration_end DATE NOT NULL
);

ALTER TABLE courses 
ADD registration_start DATE,
ADD registration_end DATE;

ALTER TABLE registrations
ADD payment_status ENUM('Pending','Paid') DEFAULT 'Pending',
ADD payment_mode VARCHAR(50);

ALTER TABLE courses ADD credits INT AFTER duration;

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    amount DECIMAL(10,2),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50),

    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

USE course_registration_system;

ALTER TABLE payments
ADD transaction_id VARCHAR(50);

ALTER TABLE courses
ADD COLUMN start_date DATE,
ADD COLUMN end_date DATE,
ADD COLUMN status VARCHAR(20);

ALTER TABLE courses 
ADD start_date DATE AFTER registration_end,
ADD end_date DATE AFTER start_date;?

UPDATE courses 
SET start_date = '2026-03-01', end_date = '2026-04-01'
WHERE course_name = 'Java Programming';

UPDATE courses 
SET start_date = '2026-03-04', end_date = '2026-04-04'
WHERE course_name = 'CPP';

UPDATE courses 
SET start_date = '2026-03-01', end_date = '2026-04-01'
WHERE course_name = 'C Programming';

