****US31: Add indexes to frequently queried columns like email****
-- Index on email
CREATE INDEX idx_users_email
ON users(email);

-- Index on course title
CREATE INDEX idx_courses_title
ON courses(title);

-- Index on enrollments user_id
CREATE INDEX idx_enrollments_user
ON enrollments(user_id);

-- Index on enrollments course_id
CREATE INDEX idx_enrollments_course
ON enrollments(course_id);

****US32: Ensure Cascade Delete functionality for enrollments****
**If foreign keys already exist, first drop them**
ALTER TABLE enrollments
DROP CONSTRAINT fk_user;
ALTER TABLE enrollments
DROP CONSTRAINT fk_course;
**Now recreate them with ON DELETE CASCADE**
ALTER TABLE enrollments
ADD CONSTRAINT fk_user
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE;
ALTER TABLE enrollments
ADD CONSTRAINT fk_course
FOREIGN KEY (course_id)
REFERENCES courses(course_id)
ON DELETE CASCADE;

****US33: Count how many students are in each course****
**Particular course**
SELECT
course_id,
COUNT(user_id) AS total_students
FROM enrollments
WHERE course_id = 1
GROUP BY course_id;
**Every course**
SELECT
c.course_id,
c.title,
COUNT(e.user_id) AS total_students
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_id, c.title;

****US34: Enforce password length constraints****
ALTER TABLE users
ADD CONSTRAINT chk_password_length
CHECK (LENGTH(password) >= 8);

****US35: Create a View for dashboard****
CREATE VIEW course_dashboard AS
SELECT
c.course_id,
c.title,
COUNT(e.user_id) AS total_students
FROM courses c
LEFT JOIN enrollments e
ON c.course_id = e.course_id
GROUP BY c.course_id,c.title;
**Use**
SELECT * FROM course_dashboard;

****US36: Prevent duplicate enrollments****
**First create a unique constraint**
ALTER TABLE enrollments
ADD CONSTRAINT unique_enrollment
UNIQUE(user_id,course_id);
**Now duplicate insert:**
INSERT INTO enrollments(user_id,course_id)
VALUES(1,1);
**Again**
INSERT INTO enrollments(user_id,course_id)
VALUES(1,1);

****US37: Optimize course search by title****
**Since title is indexed (US31)**
SELECT *
FROM courses
WHERE title ILIKE '%Java%';
**Exact match**
SELECT *
FROM courses
WHERE title='Java Programming';

****US38: Document every index****
COMMENT ON INDEX idx_users_email IS
'Improves login and email lookup performance';
COMMENT ON INDEX idx_courses_title IS
'Optimizes searching courses by title';
COMMENT ON INDEX idx_enrollments_user IS
'Speeds up retrieval of enrollments by user';
COMMENT ON INDEX idx_enrollments_course IS
'Speeds up retrieval of students enrolled in a course';
**View comments**
SELECT *
FROM pg_indexes
WHERE tablename='users';

****US39: Seed the database with sample data****
**Users**
INSERT INTO users(name,email,password)
VALUES
('Rahul','rahul@gmail.com','password123'),
('Priya','priya@gmail.com','password456'),
('Amit','amit@gmail.com','password789');
**Courses**
INSERT INTO courses(title,description)
VALUES
('Java','Core Java Programming'),
('Python','Python for Beginners'),
('DBMS','Database Management System');
**Enrollments**
INSERT INTO enrollments(user_id,course_id)
VALUES
(1,1),
(1,2),
(2,1),
(3,3);

****US40: Verify seeded data doesn't violate constraints****
**Check duplicate emails**
SELECT
email,
COUNT(*)
FROM users
GROUP BY email
HAVING COUNT(*)>1;
**Check duplicate enrollments**
SELECT
user_id,
course_id,
COUNT(*)
FROM enrollments
GROUP BY user_id,course_id
HAVING COUNT(*)>1;
**Check orphan enrollments**
SELECT *
FROM enrollments e
LEFT JOIN users u
ON e.user_id=u.user_id
WHERE u.user_id IS NULL;
**Check orphan courses**
SELECT *
FROM enrollments e
LEFT JOIN courses c
ON e.course_id=c.course_id
WHERE c.course_id IS NULL;
