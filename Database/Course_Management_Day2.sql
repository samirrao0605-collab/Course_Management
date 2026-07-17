===Write the SQL Code:===
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
**Verify the Table:**
SELECT * FROM users;
Check the Table Structure:
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'users';

****Insert Sample Users:****
INSERT INTO users (full_name, email, phone)
VALUES
('Samir Rao', 'samir@gmail.com', '9876543210'),
('Rahul Das', 'rahul@gmail.com', '9999999999'),
('Anjali Sharma', 'anjali@gmail.com', '8888888888');
**View the Data:**
SELECT * FROM users;

****Create the courses Table (US12):****
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    duration VARCHAR(30),
    start_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
**Verify the table:**
SELECT * FROM courses;

****Insert Sample Courses:****
INSERT INTO courses
(course_name, description, duration, start_date)
VALUES
('Java Programming','Learn Java from basic to advanced','3 Months','2026-08-01'),
('Python Programming','Python for beginners','2 Months','2026-09-01'),
('Web Development','HTML, CSS, JavaScript','4 Months','2026-08-15');
**Check the data:**
SELECT * FROM courses;

****Create the enrollments Table (US13):****
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,

    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id),

    CONSTRAINT fk_course
        FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);
****Insert Enrollment Data:****
INSERT INTO enrollments (user_id, course_id)
VALUES
(1,1),
(1,2),
(2,3),
(3,1);
Verify:
SELECT * FROM enrollments;

**Verify All Tables (US18):**
SELECT * FROM users;
SELECT * FROM courses;
SELECT * FROM enrollments;
