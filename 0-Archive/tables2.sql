--drop database lms;
--create database LMS;

USE LMS;
GO

CREATE SCHEMA Institutions;
GO
CREATE SCHEMA Programs;
GO
CREATE SCHEMA Instructors;
GO
CREATE SCHEMA Students;
GO

-- Begin the transaction
BEGIN TRANSACTION;

-- TESTING CREATE QUERY

-- I Core Tables

-- A. Institutions
-- 1-institutions
CREATE TABLE Institutions.Institutions (
    institution_id INT IDENTITY(1,1) PRIMARY KEY,
    institution_name VARCHAR(50),
    institution_address VARCHAR(255),
    institution_city VARCHAR(50),
    institution_country VARCHAR(50)
);

-- 2-classrooms
CREATE TABLE Institutions.ClassRooms (
    classroom_id INT IDENTITY(1,1) PRIMARY KEY,
    classroom_name VARCHAR(50) NULL,
    institution_id INT REFERENCES Institutions.Institutions(institution_id)
);

-- 3-semesters
CREATE TABLE Institutions.Semesters (
    semester_id INT IDENTITY(1,1) PRIMARY KEY,
    semester_name VARCHAR(50)
);

-- 4-departments
-- Instructors and Departments
CREATE TABLE Institutions.Departments (
    department_id INT IDENTITY(1,1) PRIMARY KEY,
    department_name VARCHAR(50)
);

-- 5-timeslots
CREATE TABLE Institutions.TimeSlots (
    time_slot_id INT IDENTITY(1,1) PRIMARY KEY,
    time_slot_start_time TIME,
    time_slot_end_time TIME,
    day_of_week VARCHAR(9)
);

-- 6-programs 
CREATE TABLE Institutions.Programs (
    program_id INT IDENTITY(1,1) PRIMARY KEY,
    program_name VARCHAR(50),
    program_creation_date DATE
);

-- B. Programs

-- 7-courses
CREATE TABLE Programs.Courses (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    course_name VARCHAR(50),
    course_creation_date DATE
);

-- 8-assessments
CREATE TABLE Programs.Assessments (
    assessment_id INT IDENTITY(1,1) PRIMARY KEY,
    assessment_name VARCHAR(50)
);

-- 9-topics
CREATE TABLE Programs.Topics (
    topic_id INT IDENTITY(1,1) PRIMARY KEY,
    topic_name VARCHAR(50),
    topic_creation_date DATE,
    course_id INT REFERENCES Programs.Courses(course_id)
);

-- 10-exams
CREATE TABLE Programs.Exams (
    exam_id INT IDENTITY(1,1) PRIMARY KEY,
    exam_name VARCHAR(50),
    exam_creation_date DATE,
    course_id INT REFERENCES Programs.Courses(course_id)
);

-- 11-questions
CREATE TABLE Programs.Questions (
    question_id INT IDENTITY(1,1) PRIMARY KEY,
    question_text TEXT,
    exam_id INT REFERENCES Programs.Exams(exam_id),
    topic_id INT REFERENCES Programs.Topics(topic_id)
);

-- 12-answers
CREATE TABLE Programs.Answers (
    answer_id INT IDENTITY(1,1) PRIMARY KEY,
    answer_text TEXT,
    right_answer BIT,
    question_id INT REFERENCES Programs.Questions(question_id)
);

-- C. Instructors
-- 13-instructors
CREATE TABLE Instructors.Instructors (
    instructor_id INT IDENTITY(1,1) PRIMARY KEY,
    instructor_first_name VARCHAR(50),
    instructor_last_name VARCHAR(50),
    instructor_gender VARCHAR(7) CHECK(instructor_gender IN ('Male', 'Female')),
    instructor_date_of_birth DATE,
    instructor_hire_date DATE,
    instructor_phone VARCHAR(15),
    instructor_address VARCHAR(255),
    instructor_city VARCHAR(50),
    instructor_country VARCHAR(50),
    instructor_email VARCHAR(100) UNIQUE NOT NULL CHECK(instructor_email LIKE '%@%.com'),
    instructor_password VARCHAR(20) NOT NULL,
    instructor_supervisor INT REFERENCES Instructors.Instructors(instructor_id),
    instructor_institution_id INT,
    instructor_department_id INT,
);

-- 14- InstitutionsPrograms
CREATE TABLE Institutions.InstitutionPrograms (
    institution_id INT REFERENCES Institutions.Institutions(institution_id),
    program_id INT REFERENCES Institutions.Programs(program_id),
    program_manager_id INT REFERENCES Instructors.Instructors(instructor_id) NULL,
    program_assignment_date DATE,
    PRIMARY KEY (institution_id, program_id)
);

-- 15-InstitutionsDepartments
CREATE TABLE Institutions.InstitutionDepartments (
    institution_id INT REFERENCES Institutions.Institutions(institution_id),
    department_id INT REFERENCES Institutions.Departments(department_id),
    department_open_date DATE,
    department_manager_id INT REFERENCES Instructors.Instructors(instructor_id),
    department_manager_assignment_date DATE,
    PRIMARY KEY (institution_id, department_id)
);
ALTER TABLE Instructors.Instructors
ADD CONSTRAINT fk_institution_department
FOREIGN KEY(instructor_institution_id, instructor_department_id)
REFERENCES Institutions.InstitutionDepartments(institution_id, department_id)


-- B. Programs
-- 16-ProgramsCourses
CREATE TABLE Programs.ProgramCourses (
    course_id INT REFERENCES Programs.Courses(course_id),
    program_id INT REFERENCES Institutions.Programs(program_id),
    course_assignment_date DATE,
    PRIMARY KEY (course_assignment_date, course_id, program_id)
);

-- 17-CoursePrerequisites
CREATE TABLE Programs.CoursePrerequisites (
    course_id INT REFERENCES Programs.Courses(course_id),
    prerequisite_id INT REFERENCES Programs.Courses(course_id),
    PRIMARY KEY (course_id, prerequisite_id)
);

-- 18-CoursesSemester
CREATE TABLE Programs.CourseSemester (
    course_id INT REFERENCES Programs.Courses(course_id),
    semester_id INT REFERENCES Institutions.Semesters(semester_id),
    available_switch BIT, 
    PRIMARY KEY (course_id, semester_id)
);

-- C. Instructors
-- 19-ClassSchedule 
CREATE TABLE Instructors.ClassSchedule (
    schedule_id INT IDENTITY(1,1) PRIMARY KEY,
    instructor_assignment_date DATE,
    instructor_id INT REFERENCES Instructors.Instructors(instructor_id),
    course_id INT REFERENCES Programs.Courses(course_id),
    class_id INT REFERENCES Institutions.ClassRooms(classroom_id),
    time_slot_id INT REFERENCES Institutions.TimeSlots(time_slot_id),
    class_max_size INT NOT NULL
);

-- D. Students
-- 20-Students
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
    student_program_id INT,
	student_institution_id INT, 
    student_institution_enrollment_date DATE
);

ALTER TABLE Students.Students
ADD CONSTRAINT fk_students_institution_program
FOREIGN KEY(student_institution_id, student_program_id) REFERENCES Institutions.InstitutionPrograms(institution_id, program_id);

-- 21-StudentEnrollments
CREATE TABLE Students.StudentEnrollments (
    enrollment_datetime DATETIME,
    student_id INT REFERENCES Students.Students(student_id),
    schedule_id INT REFERENCES Instructors.ClassSchedule(schedule_id),
    PRIMARY KEY (student_id, schedule_id)
);
-- 22-AssessmentScores
CREATE TABLE Students.AssessmentScores (
    student_id INT REFERENCES Students.Students(student_id),
    course_id INT REFERENCES Programs.Courses(course_id),
    assessment_id INT REFERENCES Programs.Assessments(assessment_id),
    student_score DECIMAL,
    assessment_total_score INT,
    PRIMARY KEY (student_id, course_id, assessment_id)
);

-- 23-CourseResults
CREATE TABLE Students.CourseResults (
    student_id INT REFERENCES Students.Students(student_id),
    course_id INT REFERENCES Programs.Courses(course_id),
    student_enrollment_date DATE,
    course_status VARCHAR(7) CHECK(course_status IN ('incomplete', 'pass', 'fail', 'canceled')),
    course_result_percentage DECIMAL CHECK(course_result_percentage BETWEEN 0 AND 100) NULL,
    PRIMARY KEY (student_id, course_id, student_enrollment_date)
);

-- 24-ExamSubmissions
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