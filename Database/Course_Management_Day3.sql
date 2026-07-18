=====DAY-3=====
****US21: Fetch All Available Courses:****
SELECT * FROM courses;

****US22: Register a New User:****
INSERT INTO users (full_name, email, phone)
VALUES ('Rohit Sharma', 'rohit@gmail.com', '7777777777');
**Verify:**
SELECT * FROM users;

****US23: Fetch User by Email:****
SELECT *
FROM users
WHERE email = 'samir@gmail.com';

****US24: Enroll a Student in a Course:****
INSERT INTO enrollments (user_id, course_id)
VALUES (4,2);
**Verify:**
SELECT * FROM enrollments;

****US25: Update Course Details:****
UPDATE courses
SET duration = '6 Months'
WHERE course_id = 1;
**Verify:**
SELECT * FROM courses;

****US26: Delete an Enrollment (Drop a Course):****
DELETE FROM enrollments
WHERE enrollment_id = 4;
**Verify:**
SELECT * FROM enrollments;

****US27: Use WHERE Clause:****
**Example 1: Find a specific course**
SELECT *
FROM courses
WHERE course_name = 'Python Programming';
**Example 2: Find users by name**
SELECT *
FROM users
WHERE full_name = 'Samir Rao';

****US28: Sort Data Using ORDER BY:****
**Sort by Course Name (Ascending)**
SELECT *
FROM courses
ORDER BY course_name ASC;
**Sort by Start Date (Descending)**
SELECT *
FROM courses
ORDER BY start_date DESC;

****US29: JOIN Query:****
SELECT
    u.user_id,
    u.full_name,
    u.email,
    c.course_name,
    c.duration,
    e.enrollment_date
FROM enrollments e
JOIN users u
ON e.user_id = u.user_id
JOIN courses c
ON e.course_id = c.course_id;

****US30: Test All Queries:****
**Users:**
SELECT * FROM users;
**Courses:**
SELECT * FROM courses;
**Enrollments:**
SELECT * FROM enrollments;
**Search:**
SELECT *
FROM users
WHERE email = 'samir@gmail.com';
**Sort:**
SELECT *
FROM courses
ORDER BY course_name;
**JOIN:**
SELECT
    u.full_name,
    c.course_name,
    e.enrollment_date
FROM enrollments e
JOIN users u ON e.user_id = u.user_id
JOIN courses c ON e.course_id = c.course_id
