--drop database lms;
CREATE DATABASE LMS;
GO 

USE LMS;
GO

CREATE SCHEMA Institutions;
GO
CREATE SCHEMA Programs;
GO
CREATE SCHEMA Students;
GO

-- Begin the transaction
BEGIN TRANSACTION;

-- TESTING CREATE QUERY
--------------------------------

-- A. Institutions --
--- Phase 1 Data Import
-- 1-Institutions
CREATE TABLE Institutions.Institutions (
    institution_id INT IDENTITY(1,1) PRIMARY KEY,
    institution_name VARCHAR(50),
    institution_address VARCHAR(255),
    institution_city VARCHAR(50),
    institution_country VARCHAR(50)
);

-- 2-Semesters
CREATE TABLE Institutions.Semesters (
    semester_id INT IDENTITY(1,1) PRIMARY KEY,
    semester_name VARCHAR(50)
);

-- 3-TimeSlots
CREATE TABLE Institutions.TimeSlots (
    time_slot_id INT IDENTITY(1,1) PRIMARY KEY,
    time_slot_start_time TIME,
    time_slot_end_time TIME,
    day_of_week VARCHAR(9)
);

-- 4-Programs 
CREATE TABLE Institutions.Programs (
    program_id INT IDENTITY(1,1) PRIMARY KEY,
    program_name VARCHAR(50),
    program_creation_date DATE
);

-- 5-Departments
CREATE TABLE Institutions.Departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name VARCHAR(50)
);


-- 6-Instructors
CREATE TABLE Institutions.Instructors (
    instructor_id INT IDENTITY(1,1) PRIMARY KEY,
    instructor_first_name VARCHAR(50),
    instructor_last_name VARCHAR(50),
    instructor_gender VARCHAR(7) CHECK(instructor_gender IN ('Male', 'Female')),
    instructor_date_of_birth DATE,
    instructor_hire_date DATE,
    instructor_salary INT CHECK(instructor_salary BETWEEN 2000 AND 50000),
    instructor_phone VARCHAR(15),
    instructor_address VARCHAR(255),
    instructor_city VARCHAR(50),
    instructor_country VARCHAR(50),
    instructor_email VARCHAR(100) UNIQUE NOT NULL CHECK(instructor_email LIKE '%@%.com'),
    instructor_password VARCHAR(20) NOT NULL,
    instructor_supervisor INT,
    instructor_institution_department_id INT,
    CONSTRAINT fk_instructor_supervisor FOREIGN KEY(instructor_supervisor) REFERENCES Institutions.Instructors(instructor_id)
);
--- Phase 2 Data Import
-- 7-Classrooms
CREATE TABLE Institutions.ClassRooms (
    classroom_id INT IDENTITY(1,1) PRIMARY KEY,
    classroom_name VARCHAR(50) NULL,
    institution_id INT REFERENCES Institutions.Institutions(institution_id)
);

-- 8- InstitutionsPrograms
CREATE TABLE Institutions.InstitutionPrograms (
    institution_program_id INT IDENTITY(1,1) PRIMARY KEY,
    institution_id INT REFERENCES Institutions.Institutions(institution_id),
    program_id INT REFERENCES Institutions.Programs(program_id),
    program_manager_id INT REFERENCES Institutions.Instructors(instructor_id) NULL,
    program_assignment_date DATE,
);

-- 9- InstitutionsDepartments
CREATE TABLE Institutions.InstitutionDepartments (
	institution_department_id INT IDENTITY(1,1) PRIMARY KEY,
    institution_id INT REFERENCES Institutions.Institutions(institution_id),
    department_id INT REFERENCES Institutions.Departments(department_id),
    department_open_date DATE,
    department_manager_id INT REFERENCES Institutions.Instructors(instructor_id),
    department_manager_assignment_date DATE,
);

-- 10. Instructors (institutions_department_id)
ALTER TABLE Institutions.Instructors
ADD CONSTRAINT fk_instructor_institution_department
FOREIGN KEY(instructor_institution_department_id) REFERENCES Institutions.InstitutionDepartments (institution_department_id);

-- B. Programs --
-- Phase 3 Data Import
-- 11-Courses
CREATE TABLE Programs.Courses (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    course_name VARCHAR(50),
    course_creation_date DATE,
    course_year_number INT,
    course_credit_hours INT
);

-- 12-Assessments
CREATE TABLE Programs.Assessments (
    assessment_id INT IDENTITY(1,1) PRIMARY KEY,
    assessment_name VARCHAR(50)
);

--- Phase 4 Data Import
-- 13-CoursePrerequisites
CREATE TABLE Programs.CoursePrerequisites (
    course_id INT REFERENCES Programs.Courses(course_id),
    prerequisite_id INT REFERENCES Programs.Courses(course_id),
    PRIMARY KEY (course_id, prerequisite_id)
);

-- 14-Topics
CREATE TABLE Programs.Topics (
    topic_id INT IDENTITY(1,1) PRIMARY KEY,
    topic_name VARCHAR(50),
    topic_creation_date DATE,
    course_id INT REFERENCES Programs.Courses(course_id)
);

-- 15-Exams
CREATE TABLE Programs.Exams (
    exam_id INT IDENTITY(1,1) PRIMARY KEY,
    exam_name VARCHAR(50),
    exam_creation_date DATE,
    course_id INT REFERENCES Programs.Courses(course_id)
);

--- Phase 5 Data Import 
-- 16-Questions
CREATE TABLE Programs.Questions (
    question_id INT IDENTITY(1,1) PRIMARY KEY,
    question_text VARCHAR(MAX),
    exam_id INT REFERENCES Programs.Exams(exam_id),
    topic_id INT REFERENCES Programs.Topics(topic_id)
);

--- Phase 6 Data Import
-- 17-Answers
CREATE TABLE Programs.Answers (
    answer_id INT IDENTITY(1,1) PRIMARY KEY,
    answer_text VARCHAR(MAX),
    right_answer BIT,
    question_id INT REFERENCES Programs.Questions(question_id)
);

-- 18-ProgramsCourses
CREATE TABLE Programs.ProgramCourses (
    program_course_id INT IDENTITY(1,1) PRIMARY KEY,
    course_id INT REFERENCES Programs.Courses(course_id),
    program_id INT REFERENCES Institutions.Programs(program_id),
    course_assignment_date DATE,
);

-- 19-CourseSemester
CREATE TABLE Programs.CourseSemester (
    course_id INT REFERENCES Programs.Courses(course_id),
    semester_id INT REFERENCES Institutions.Semesters(semester_id),
    available_switch BIT, 
    PRIMARY KEY (course_id, semester_id)
);

-- C. INSTITUTIONS --
-- 20-ClassSchedule 
CREATE TABLE Institutions.ClassSchedule (
    schedule_id INT IDENTITY(1,1) PRIMARY KEY,
    instructor_assignment_date DATE,
    instructor_id INT REFERENCES Institutions.Instructors(instructor_id),
    program_course_id INT REFERENCES Programs.ProgramCourses(program_course_id),
    classroom_id INT REFERENCES Institutions.ClassRooms(classroom_id),
    time_slot_id INT REFERENCES Institutions.TimeSlots(time_slot_id),
    classroom_max_size INT NOT NULL
);

-- D. STUDENTS --
-- 21-Students
CREATE TABLE Students.Students (
    student_id INT IDENTITY(1,1) PRIMARY KEY,
    student_first_name VARCHAR(50),
    student_last_name VARCHAR(50),
    student_gender VARCHAR(6) CHECK(student_gender IN ('Male', 'Female')),
    student_date_of_birth DATE,
    student_phone VARCHAR(15),
    student_email VARCHAR(100) UNIQUE NOT NULL CHECK(student_email LIKE '%@%.com'),
    student_password VARCHAR(20) NOT NULL,
    student_country VARCHAR(50),
    student_city VARCHAR(50),
    student_address VARCHAR(255),
    student_institution_program_id INT REFERENCES Institutions.InstitutionPrograms(institution_program_id),
    student_year_number INT,
    student_institution_enrollment_date DATE,
    credit_hour_price INT
    
);

--- Phase 7 Data Import
-- 22-StudentEnrollments
CREATE TABLE Students.StudentEnrollments (
    enrollment_datetime DATETIME,
    student_id INT REFERENCES Students.Students(student_id),
    schedule_id INT REFERENCES Institutions.ClassSchedule(schedule_id),
    PRIMARY KEY (student_id, schedule_id)
);
-- 23-AssessmentScores
CREATE TABLE Students.AssessmentScores (
    student_id INT REFERENCES Students.Students(student_id),
    program_course_id INT REFERENCES Programs.ProgramCourses(program_course_id),
    assessment_id INT REFERENCES Programs.Assessments(assessment_id),
    student_score DECIMAL(4,2),
    assessment_total_score INT,
    PRIMARY KEY (student_id, program_course_id, assessment_id)
);

-- 24-CourseResults
CREATE TABLE Students.CourseResults (
    student_id INT REFERENCES Students.Students(student_id),
    program_course_id INT REFERENCES Programs.ProgramCourses(program_course_id),
    student_enrollment_date DATE,
    course_status VARCHAR(10) CHECK(course_status IN ('incomplete', 'pass', 'fail', 'canceled')),
    course_result_percentage DECIMAL CHECK(course_result_percentage BETWEEN 0 AND 100) NULL,
    PRIMARY KEY (student_id, program_course_id, student_enrollment_date)
);

-- 25-ExamSubmissions
CREATE TABLE Students.ExamSubmissions (
    exam_submission_datetime DATETIME,
    student_id INT REFERENCES Students.Students(student_id),
    exam_id INT REFERENCES Programs.Exams(exam_id),
    question_id INT REFERENCES Programs.Questions(question_id),
    answer_id INT REFERENCES Programs.Answers(answer_id),
    PRIMARY KEY (exam_submission_datetime, exam_id, question_id, student_id, answer_id)
);

-- If an error occurs, rollback the transaction
IF @@ERROR <> 0
BEGIN
    PRINT 'An error occurred. Rolling back the transaction.';
    ROLLBACK;
END
ELSE
BEGIN
    -- If everything is successful, commit the transaction
    PRINT 'Transaction successful. Committing changes.';
    COMMIT;
END