USE LMS;
GO

------------------------------------------------------
---- 1- Institutions.Institutions CRUD procedures ----
------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetInstitutions
AS
BEGIN
    SELECT *
    FROM [Institutions].[Institutions]
END;
GO


CREATE OR ALTER PROCEDURE sp_InsertInstitution
    @institution_name VARCHAR(50),
    @institution_address VARCHAR(255),
    @institution_city VARCHAR(50),
    @institution_country VARCHAR(50)
AS
BEGIN
    INSERT INTO Institutions.Institutions (
        institution_name, institution_address, institution_city, institution_country
    )
    VALUES (
        @institution_name, @institution_address, @institution_city, @institution_country
    );
END;
GO


CREATE OR ALTER PROCEDURE sp_UpdateInstitution
    @institution_id INT,
    @institution_name VARCHAR(50) = NULL,
    @institution_address VARCHAR(255) = NULL,
    @institution_city VARCHAR(50) = NULL,
    @institution_country VARCHAR(50) = NULL
AS
BEGIN
    UPDATE Institutions.Institutions
    SET
        institution_name = ISNULL(@institution_name,institution_name),
        institution_address =  ISNULL(@institution_address,institution_address),
        institution_city =  ISNULL(@institution_city,institution_city),
        institution_country =  ISNULL(@institution_country,institution_country)
    WHERE
        institution_id = @institution_id;
END;
GO

CREATE OR ALTER PROCEDURE sp_DeleteInstitution
    @institution_id INT
AS
BEGIN
    DELETE FROM Institutions.Institutions
    WHERE
        institution_id = @institution_id;
END;
GO


---------------------------------------------------
---- 2- Institutions.Semesters CRUD procedures ----
----------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetSemesters
AS
BEGIN
    SELECT *
    FROM [Institutions].[Semesters]
END;
GO


CREATE OR ALTER PROCEDURE sp_InsertSemester
    @semester_name VARCHAR(50)
AS
BEGIN
    INSERT INTO Institutions.Semesters (semester_name)
    VALUES (@semester_name);
END;
GO

CREATE OR ALTER PROCEDURE sp_UpdateSemester
    @semester_id INT,
    @semester_name VARCHAR(50) = NULL
AS
BEGIN
    UPDATE Institutions.Semesters
    SET
        semester_name = ISNULL(@semester_name, semester_name)
    WHERE
        semester_id = @semester_id;
END;
GO


CREATE OR ALTER PROCEDURE sp_DeleteSemester
    @semester_id INT
AS
BEGIN
    DELETE FROM Institutions.Semesters
    WHERE
        semester_id = @semester_id;
END;
GO


---------------------------------------------------
---- 3- Institutions.TimeSlots CRUD procedures ----
---------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetTimeSlots
AS
BEGIN
    SELECT *
    FROM [Institutions].[TimeSlots]
END;
GO

CREATE OR ALTER PROCEDURE sp_InsertTimeSlot
    @time_slot_start_time TIME,
    @time_slot_end_time TIME,
    @day_of_week VARCHAR(9)
AS
BEGIN
    INSERT INTO Institutions.TimeSlots (time_slot_start_time, time_slot_end_time, day_of_week)
    VALUES (@time_slot_start_time, @time_slot_end_time, @day_of_week);
END;
GO

CREATE OR ALTER PROCEDURE sp_UpdateTimeSlot
    @time_slot_id INT,
    @time_slot_start_time TIME = NULL,
    @time_slot_end_time TIME = NULL,
    @day_of_week VARCHAR(9) = NULL
AS
BEGIN
    UPDATE Institutions.TimeSlots
    SET
        time_slot_start_time = ISNULL(@time_slot_start_time, time_slot_start_time),
        time_slot_end_time = ISNULL(@time_slot_end_time, time_slot_end_time),
        day_of_week = ISNULL(@day_of_week, day_of_week)
    WHERE
        time_slot_id = @time_slot_id;
END;
GO


CREATE OR ALTER PROCEDURE sp_DeleteTimeSlot
    @time_slot_id INT
AS
BEGIN
    DELETE FROM Institutions.TimeSlots
    WHERE
        time_slot_id = @time_slot_id;
END;
GO

--------------------------------------------------
---- 4- Institutions.Programs CRUD procedures ----
--------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetPrograms
AS
BEGIN
    SELECT *
    FROM [Institutions].[Programs]
END;
GO


CREATE OR ALTER PROCEDURE sp_InsertProgram
    @program_name VARCHAR(50),
    @program_creation_date DATE
AS
BEGIN
    INSERT INTO Institutions.Programs (program_name, program_creation_date)
    VALUES (@program_name, @program_creation_date);
END;
GO

CREATE OR ALTER PROCEDURE sp_UpdateProgram
    @program_id INT,
    @program_name VARCHAR(50) = NULL,
    @program_creation_date DATE = NULL
AS
BEGIN
    UPDATE Institutions.Programs
    SET
        program_name = ISNULL(@program_name, program_name),
        program_creation_date = ISNULL(@program_creation_date, program_creation_date)
    WHERE
        program_id = @program_id;
END;
GO

CREATE OR ALTER PROCEDURE sp_DeleteProgram
    @program_id INT
AS
BEGIN
    DELETE FROM Institutions.Programs
    WHERE
        program_id = @program_id;
END;
GO

-----------------------------------------------------
---- 5- Institutions.Departments CRUD procedures ----
-----------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetDepartments
AS
BEGIN
    SELECT *
    FROM [Institutions].[Departments]
END;
GO

CREATE OR ALTER PROCEDURE sp_InsertDepartment
    @department_name VARCHAR(50)
AS
BEGIN
    INSERT INTO Institutions.Departments (department_name)
    VALUES (@department_name);
END;
GO

CREATE OR ALTER PROCEDURE sp_UpdateDepartment
    @department_id INT,
    @department_name VARCHAR(50) = NULL
AS
BEGIN
    UPDATE Institutions.Departments
    SET
        department_name = ISNULL(@department_name, department_name)
    WHERE
        department_id = @department_id;
END;
GO

CREATE OR ALTER PROCEDURE sp_DeleteDepartment
    @department_id INT
AS
BEGIN
    DELETE FROM Institutions.Departments
    WHERE
        department_id = @department_id;
END;
GO

-----------------------------------------------------
---- 6- Institutions.Instructors CRUD procedures ----
-----------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetInstructors
AS
BEGIN
    SELECT *
    FROM [Institutions].[Instructors]
END;
GO


CREATE OR ALTER PROCEDURE sp_InsertInstructor
    @instructor_first_name VARCHAR(50),
    @instructor_last_name VARCHAR(50),
    @instructor_gender VARCHAR(7),
    @instructor_date_of_birth DATE,
    @instructor_hire_date DATE,
    @instructor_salary INT,
    @instructor_phone VARCHAR(15),
    @instructor_address VARCHAR(255),
    @instructor_city VARCHAR(50),
    @instructor_country VARCHAR(50),
    @instructor_email VARCHAR(100),
    @instructor_password VARCHAR(20),
    @instructor_supervisor INT,
    @instructor_institution_department_id INT
AS
BEGIN
    INSERT INTO Institutions.Instructors (
        instructor_first_name, instructor_last_name, instructor_gender,
        instructor_date_of_birth, instructor_hire_date, instructor_salary,
        instructor_phone, instructor_address, instructor_city, instructor_country,
        instructor_email, instructor_password, instructor_supervisor,
        instructor_institution_department_id
    )
    VALUES (
        @instructor_first_name, @instructor_last_name, @instructor_gender,
        @instructor_date_of_birth, @instructor_hire_date, @instructor_salary,
        @instructor_phone, @instructor_address, @instructor_city, @instructor_country,
        @instructor_email, @instructor_password, @instructor_supervisor,
        @instructor_institution_department_id
    );
END;
GO

CREATE OR ALTER PROCEDURE sp_UpdateInstructor
    @instructor_id INT,
    @instructor_first_name VARCHAR(50) = NULL,
    @instructor_last_name VARCHAR(50) = NULL,
    @instructor_gender VARCHAR(7) = NULL,
    @instructor_date_of_birth DATE = NULL,
    @instructor_hire_date DATE = NULL,
    @instructor_salary INT = NULL,
    @instructor_phone VARCHAR(15) = NULL,
    @instructor_address VARCHAR(255) = NULL,
    @instructor_city VARCHAR(50) = NULL,
    @instructor_country VARCHAR(50) = NULL,
    @instructor_email VARCHAR(100) = NULL,
    @instructor_password VARCHAR(20) = NULL,
    @instructor_supervisor INT = NULL,
    @instructor_institution_department_id INT = NULL
AS
BEGIN
    UPDATE Institutions.Instructors
    SET
        instructor_first_name = ISNULL(@instructor_first_name, instructor_first_name),
        instructor_last_name = ISNULL(@instructor_last_name, instructor_last_name),
        instructor_gender = ISNULL(@instructor_gender, instructor_gender),
        instructor_date_of_birth = ISNULL(@instructor_date_of_birth, instructor_date_of_birth),
        instructor_hire_date = ISNULL(@instructor_hire_date, instructor_hire_date),
        instructor_salary = ISNULL(@instructor_salary, instructor_salary),
        instructor_phone = ISNULL(@instructor_phone, instructor_phone),
        instructor_address = ISNULL(@instructor_address, instructor_address),
        instructor_city = ISNULL(@instructor_city, instructor_city),
        instructor_country = ISNULL(@instructor_country, instructor_country),
        instructor_email = ISNULL(@instructor_email, instructor_email),
        instructor_password = ISNULL(@instructor_password, instructor_password),
        instructor_supervisor = ISNULL(@instructor_supervisor, instructor_supervisor),
        instructor_institution_department_id = ISNULL(@instructor_institution_department_id, instructor_institution_department_id)
    WHERE
        instructor_id = @instructor_id;
END;
GO

CREATE OR ALTER PROCEDURE sp_DeleteInstructor
    @instructor_id INT
AS
BEGIN
    DELETE FROM Institutions.Instructors
    WHERE
        instructor_id = @instructor_id;
END;
GO

----------------------------------------------------
---- 7- Institutions.ClassRooms CRUD procedures ----
----------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetClassRooms
AS
BEGIN
    SELECT *
    FROM [Institutions].[ClassRooms]
END;
GO


CREATE OR ALTER PROCEDURE sp_InsertClassRoom
    @classroom_name VARCHAR(50),
    @institution_id INT
AS
BEGIN
    INSERT INTO Institutions.ClassRooms (classroom_name, institution_id)
    VALUES (@classroom_name, @institution_id);
END;
GO


CREATE OR ALTER PROCEDURE sp_UpdateClassRoom
    @classroom_id INT,
    @classroom_name VARCHAR(50),
    @institution_id INT
AS
BEGIN
    UPDATE Institutions.ClassRooms
    SET
        classroom_name = @classroom_name
    WHERE
        classroom_id = @classroom_id
		AND institution_id= @institution_id;
END;
GO


CREATE OR ALTER PROCEDURE sp_DeleteClassRoom
    @classroom_id INT,
	@institution_id INT
AS
BEGIN
    DELETE FROM Institutions.ClassRooms
    WHERE
        classroom_id = @classroom_id
	AND institution_id= @institution_id;
END;
GO


-------------------------------------------------------------
---- 8- Institutions.InstitutionPrograms CRUD procedures ----
-------------------------------------------------------------
CREATE OR ALTER PROCEDURE sp_GetInstitutionPrograms
AS
BEGIN
    SELECT *
    FROM Institutions.InstitutionPrograms;
END;
GO


CREATE OR ALTER PROCEDURE sp_InsertInstitutionProgram
    @institution_id INT,
    @program_id INT,
    @program_manager_id INT,
    @program_assignment_date DATE
AS
BEGIN
    INSERT INTO Institutions.InstitutionPrograms (institution_id, program_id, program_manager_id, program_assignment_date)
    VALUES (@institution_id, @program_id, @program_manager_id, @program_assignment_date);
END;
GO


CREATE OR ALTER PROCEDURE sp_UpdateInstitutionProgram
    @institution_program_id INT,
    @institution_id INT,
    @program_id INT,
    @program_manager_id INT,
    @program_assignment_date DATE
AS
BEGIN
    UPDATE Institutions.InstitutionPrograms
    SET
        institution_id = @institution_id,
        program_id = @program_id,
        program_manager_id = @program_manager_id,
        program_assignment_date = @program_assignment_date
    WHERE
        institution_program_id = @institution_program_id;
END;
GO


CREATE OR ALTER PROCEDURE sp_DeleteInstitutionProgram
    @institution_program_id INT
AS
BEGIN
    DELETE FROM Institutions.InstitutionPrograms
    WHERE
        institution_program_id = @institution_program_id;
END;
GO

----------------------------------------------------------------
---- 9- Institutions.InstitutionDepartments CRUD procedures ----
----------------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetInstitutionDepartments
AS
BEGIN
    SELECT *
    FROM Institutions.InstitutionDepartments;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertInstitutionDepartment
    @institution_id INT,
    @department_id INT,
    @department_open_date DATE,
    @department_manager_id INT,
    @department_manager_assignment_date DATE
AS
BEGIN
    INSERT INTO Institutions.InstitutionDepartments (institution_id, department_id, department_open_date, department_manager_id, department_manager_assignment_date)
    VALUES (@institution_id, @department_id, @department_open_date, @department_manager_id, @department_manager_assignment_date);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateInstitutionDepartment
    @institution_department_id INT,
    @institution_id INT,
    @department_id INT,
    @department_open_date DATE,
    @department_manager_id INT,
    @department_manager_assignment_date DATE
AS
BEGIN
    UPDATE Institutions.InstitutionDepartments
    SET
        institution_id = @institution_id,
        department_id = @department_id,
        department_open_date = @department_open_date,
        department_manager_id = @department_manager_id,
        department_manager_assignment_date = @department_manager_assignment_date
    WHERE
        institution_department_id = @institution_department_id;
END;
GO


-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteInstitutionDepartment
    @institution_department_id INT
AS
BEGIN
    DELETE FROM Institutions.InstitutionDepartments
    WHERE
        institution_department_id = @institution_department_id;
END;
GO


-----------------------------------------------------------
---- 11- Programs.Courses CRUD procedures ----
-----------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetCourses
AS
BEGIN
    SELECT *
    FROM Programs.Courses;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertCourse
    @course_name VARCHAR(50),
    @course_creation_date DATE
AS
BEGIN
    INSERT INTO Programs.Courses (course_name, course_creation_date)
    VALUES (@course_name, @course_creation_date);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateCourse
    @course_id INT,
    @course_name VARCHAR(50),
    @course_creation_date DATE
AS
BEGIN
    UPDATE Programs.Courses
    SET
        course_name = @course_name,
        course_creation_date = @course_creation_date
    WHERE
        course_id = @course_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteCourse
    @course_id INT
AS
BEGIN
    DELETE FROM Programs.Courses
    WHERE
        course_id = @course_id;
END;
GO

-----------------------------------------------------------
---- 12- Programs.Assessments CRUD procedures ----
-----------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetAssessments
AS
BEGIN
    SELECT *
    FROM Programs.Assessments;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertAssessment
    @assessment_name VARCHAR(50)
AS
BEGIN
    INSERT INTO Programs.Assessments (assessment_name)
    VALUES (@assessment_name);
END;
GO


-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateAssessment
    @assessment_id INT,
    @assessment_name VARCHAR(50)
AS
BEGIN
    UPDATE Programs.Assessments
    SET
        assessment_name = @assessment_name
    WHERE
        assessment_id = @assessment_id;
END;
GO


-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteAssessment
    @assessment_id INT
AS
BEGIN
    DELETE FROM Programs.Assessments
    WHERE
        assessment_id = @assessment_id;
END;
GO



----------------------------------------------------------
---- 13- Programs.CoursePrerequisites CRUD procedures ----
----------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetCoursePrerequisites
AS
BEGIN
    SELECT *
    FROM Programs.CoursePrerequisites;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertCoursePrerequisite
    @course_id INT,
    @prerequisite_id INT
AS
BEGIN
    INSERT INTO Programs.CoursePrerequisites (course_id, prerequisite_id)
    VALUES (@course_id, @prerequisite_id);
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteCoursePrerequisite
    @course_id INT,
    @prerequisite_id INT
AS
BEGIN
    DELETE FROM Programs.CoursePrerequisites
    WHERE
        course_id = @course_id
        AND prerequisite_id = @prerequisite_id;
END;
GO

---------------------------------------------
---- 14- Programs.Topics CRUD procedures ----
---------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetTopics
AS
BEGIN
    SELECT *
    FROM Programs.Topics;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertTopic
    @topic_name VARCHAR(50),
    @topic_creation_date DATE,
    @course_id INT
AS
BEGIN
    INSERT INTO Programs.Topics (topic_name, topic_creation_date, course_id)
    VALUES (@topic_name, @topic_creation_date, @course_id);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateTopic
    @topic_id INT,
    @topic_name VARCHAR(50),
    @topic_creation_date DATE,
    @course_id INT
AS
BEGIN
    UPDATE Programs.Topics
    SET
        topic_name = @topic_name,
        topic_creation_date = @topic_creation_date,
        course_id = @course_id
    WHERE
        topic_id = @topic_id;
END;
GO


-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteTopic
    @topic_id INT
AS
BEGIN
    DELETE FROM Programs.Topics
    WHERE
        topic_id = @topic_id;
END;
GO


--------------------------------------------
---- 15- Programs.Exams CRUD procedures ----
--------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetExams
AS
BEGIN
    SELECT *
    FROM Programs.Exams;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertExam
    @exam_name VARCHAR(50),
    @exam_creation_date DATE,
    @course_id INT
AS
BEGIN
    INSERT INTO Programs.Exams (exam_name, exam_creation_date, course_id)
    VALUES (@exam_name, @exam_creation_date, @course_id);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateExam
    @exam_id INT,
    @exam_name VARCHAR(50),
    @exam_creation_date DATE,
    @course_id INT
AS
BEGIN
    UPDATE Programs.Exams
    SET
        exam_name = @exam_name,
        exam_creation_date = @exam_creation_date,
        course_id = @course_id
    WHERE
        exam_id = @exam_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteExam
    @exam_id INT
AS
BEGIN
    DELETE FROM Programs.Exams
    WHERE
        exam_id = @exam_id;
END;
GO

-----------------------------------------------------------
---- 16- Programs.Questions CRUD procedures ----
-----------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetQuestions
AS
BEGIN
    SELECT *
    FROM Programs.Questions;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertQuestion
    @question_text TEXT,
    @exam_id INT,
    @topic_id INT
AS
BEGIN
    INSERT INTO Programs.Questions (question_text, exam_id, topic_id)
    VALUES (@question_text, @exam_id, @topic_id);
END;
GO


-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateQuestion
    @question_id INT,
    @question_text TEXT,
    @exam_id INT,
    @topic_id INT
AS
BEGIN
    UPDATE Programs.Questions
    SET
        question_text = @question_text,
        exam_id = @exam_id,
        topic_id = @topic_id
    WHERE
        question_id = @question_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteQuestion
    @question_id INT
AS
BEGIN
    DELETE FROM Programs.Questions
    WHERE
        question_id = @question_id;
END;
GO


-------------------------------------------------------
---- 17- Programs.Answers CRUD procedures ----
-------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetAnswers
AS
BEGIN
    SELECT *
    FROM Programs.Answers;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertAnswer
    @answer_text TEXT,
    @right_answer BIT,
    @question_id INT
AS
BEGIN
    INSERT INTO Programs.Answers (answer_text, right_answer, question_id)
    VALUES (@answer_text, @right_answer, @question_id);
END;
GO


-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateAnswer
    @answer_id INT,
    @answer_text TEXT,
    @right_answer BIT,
    @question_id INT
AS
BEGIN
    UPDATE Programs.Answers
    SET
        answer_text = @answer_text,
        right_answer = @right_answer,
        question_id = @question_id
    WHERE
        answer_id = @answer_id;
END;
GO


-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteAnswer
    @answer_id INT
AS
BEGIN
    DELETE FROM Programs.Answers
    WHERE
        answer_id = @answer_id;
END;
GO


---------------------------------------------------------------
---- 18- Programs.ProgramCourses CRUD procedures ----
---------------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetProgramCourses
AS
BEGIN
    SELECT *
    FROM Programs.ProgramCourses;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertProgramCourse
    @program_course_id INT,
    @course_id INT,
    @program_id INT,
    @course_assignment_date DATE
AS
BEGIN
    INSERT INTO Programs.ProgramCourses (course_id, program_id, course_assignment_date)
    VALUES (@course_id, @program_id, @course_assignment_date);
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteProgramCourse
    @program_course_id INT,
    @course_id INT,
    @program_id INT,
    @course_assignment_date DATE
AS
BEGIN
    DELETE FROM Programs.ProgramCourses
    WHERE
        program_course_id = @program_course_id;
END;
GO

----------------------------------------------------------------
---- 19- Programs.CourseSemester CRUD procedures ----
----------------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetCourseSemesters
AS
BEGIN
    SELECT *
    FROM Programs.CourseSemester;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertCourseSemester
    @course_id INT,
    @semester_id INT,
    @available_switch BIT
AS
BEGIN
    INSERT INTO Programs.CourseSemester (course_id, semester_id, available_switch)
    VALUES (@course_id, @semester_id, @available_switch);
END;
GO


-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateCourseSemester
    @course_id INT,
    @semester_id INT,
    @available_switch BIT
AS
BEGIN
    UPDATE Programs.CourseSemester
    SET
        available_switch = @available_switch
    WHERE
        course_id = @course_id
        AND semester_id = @semester_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteCourseSemester
    @course_id INT,
    @semester_id INT
AS
BEGIN
    DELETE FROM Programs.CourseSemester
    WHERE
        course_id = @course_id
        AND semester_id = @semester_id;
END;
GO

----------------------------------------------------------------
---- 20- Institutions.ClassSchedule CRUD procedures ----
----------------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetClassSchedule
AS
BEGIN
    SELECT *
    FROM Institutions.ClassSchedule;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertClassSchedule
    @instructor_assignment_date DATE,
    @instructor_id INT,
    @program_course_id INT,
    @classroom_id INT,
    @time_slot_id INT,
    @classroom_max_size INT
AS
BEGIN
    INSERT INTO Institutions.ClassSchedule (instructor_assignment_date, instructor_id, program_course_id, classroom_id, time_slot_id, classroom_max_size)
    VALUES (@instructor_assignment_date, @instructor_id, @program_course_id, @classroom_id, @time_slot_id, @classroom_max_size);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateClassSchedule
    @schedule_id INT,
    @instructor_assignment_date DATE,
    @instructor_id INT,
    @program_course_id INT,
    @classroom_id INT,
    @time_slot_id INT,
    @classroom_max_size INT
AS
BEGIN
    UPDATE Institutions.ClassSchedule
    SET
        instructor_assignment_date = @instructor_assignment_date,
        instructor_id = @instructor_id,
        @program_course_id = @program_course_id,
        classroom_id = @classroom_id,
        time_slot_id = @time_slot_id,
        classroom_max_size = @classroom_max_size
    WHERE
        schedule_id = @schedule_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteClassSchedule
    @schedule_id INT
AS
BEGIN
    DELETE FROM Institutions.ClassSchedule
    WHERE
        schedule_id = @schedule_id;
END;
GO

----------------------------------------------------------------
---- 21- Students.Students CRUD procedures ----
----------------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetStudents
AS
BEGIN
    SELECT *
    FROM Students.Students;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertStudent
    @student_first_name VARCHAR(50),
    @student_last_name VARCHAR(50),
    @student_gender VARCHAR(6),
    @student_date_of_birth DATE,
    @student_phone VARCHAR(15),
    @student_email VARCHAR(100),
    @student_password VARCHAR(20),
    @student_country VARCHAR(50),
    @student_city VARCHAR(50),
    @student_address VARCHAR(255),
    @student_institution_program_id INT,
    @student_year_number INT,
    @student_institution_enrollment_date DATE
AS
BEGIN
    INSERT INTO Students.Students (student_first_name, student_last_name, student_gender, student_date_of_birth, student_phone, student_email, student_password, student_country, student_city, student_address, student_institution_program_id, student_year_number, student_institution_enrollment_date )
    VALUES (@student_first_name, @student_last_name, @student_gender, @student_date_of_birth, @student_phone, @student_email, @student_password, @student_country, @student_city, @student_address, @student_institution_program_id, @student_year_number, @student_institution_enrollment_date);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateStudent
    @student_id INT,
    @student_first_name VARCHAR(50),
    @student_last_name VARCHAR(50),
    @student_gender VARCHAR(6),
    @student_date_of_birth DATE,
    @student_phone VARCHAR(15),
    @student_email VARCHAR(100),
    @student_password VARCHAR(20),
    @student_country VARCHAR(50),
    @student_city VARCHAR(50),
    @student_address VARCHAR(255),
    @student_institution_program_id INT,
    @student_year_number INT,
    @student_institution_enrollment_date DATE
    
AS
BEGIN
    UPDATE Students.Students
    SET
        student_first_name = @student_first_name,
        student_last_name = @student_last_name,
        student_gender = @student_gender,
        student_date_of_birth = @student_date_of_birth,
        student_phone = @student_phone,
        student_email = @student_email,
        student_password = @student_password,
        student_country = @student_country,
        student_city = @student_city,
        student_address = @student_address,
        student_institution_program_id = @student_institution_program_id,
        student_year_number=@student_year_number,
        student_institution_enrollment_date = @student_institution_enrollment_date
        
    WHERE
        student_id = @student_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteStudent
    @student_id INT
AS
BEGIN
    DELETE FROM Students.Students
    WHERE
        student_id = @student_id;
END;
GO

-------------------------------------------------------------------
---- 22- Students.StudentEnrollments CRUD procedures ----
-------------------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetStudentEnrollments
AS
BEGIN
    SELECT *
    FROM Students.StudentEnrollments;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertStudentEnrollment
    @enrollment_datetime DATETIME,
    @student_id INT,
    @schedule_id INT
AS
BEGIN
    INSERT INTO Students.StudentEnrollments (enrollment_datetime, student_id, schedule_id)
    VALUES (@enrollment_datetime, @student_id, @schedule_id);
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteStudentEnrollment
    @student_id INT,
    @schedule_id INT
AS
BEGIN
    DELETE FROM Students.StudentEnrollments
    WHERE
        student_id = @student_id
        AND schedule_id = @schedule_id;
END;
GO

-----------------------------------------------------------------------
---- 23- Students.AssessmentScores CRUD procedures ----
-----------------------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetAssessmentScores
AS
BEGIN
    SELECT *
    FROM Students.AssessmentScores;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertAssessmentScore
    @student_id INT,
    @program_course_id INT,
    @assessment_id INT,
    @student_score DECIMAL,
    @assessment_total_score INT
AS
BEGIN
    INSERT INTO Students.AssessmentScores (student_id, program_course_id, assessment_id, student_score, assessment_total_score)
    VALUES (@student_id, @program_course_id, @assessment_id, @student_score, @assessment_total_score);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateAssessmentScore
    @student_id INT,
    @program_course_id INT,
    @assessment_id INT,
    @student_score DECIMAL,
    @assessment_total_score INT
AS
BEGIN
    UPDATE Students.AssessmentScores
    SET
        student_score = @student_score,
        assessment_total_score = @assessment_total_score
    WHERE
        student_id = @student_id
        AND program_course_id = @program_course_id
        AND assessment_id = @assessment_id;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteAssessmentScore
    @student_id INT,
    @program_course_id INT,
    @assessment_id INT
AS
BEGIN
    DELETE FROM Students.AssessmentScores
    WHERE
        student_id = @student_id
        AND program_course_id = @program_course_id
        AND assessment_id = @assessment_id;
END;
GO

-------------------------------------------------------------------
---- 24- Students.CourseResults CRUD procedures ----
-------------------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetCourseResults
AS
BEGIN
    SELECT *
    FROM Students.CourseResults;
END;
GO

-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertCourseResult
    @student_id INT,
    @program_course_id INT,
    @student_enrollment_date DATE,
    @course_status VARCHAR(10),
    @course_result_percentage DECIMAL
AS
BEGIN
    INSERT INTO Students.CourseResults (student_id, program_course_id, student_enrollment_date, course_status, course_result_percentage)
    VALUES (@student_id, @program_course_id, @student_enrollment_date, @course_status, @course_result_percentage);
END;
GO

-- UPDATE
CREATE OR ALTER PROCEDURE sp_UpdateCourseResult
    @student_id INT,
    @program_course_id INT,
    @student_enrollment_date DATE,
    @course_status VARCHAR(10),
    @course_result_percentage DECIMAL
AS
BEGIN
    UPDATE Students.CourseResults
    SET
        course_status = @course_status,
        course_result_percentage = @course_result_percentage
    WHERE
        student_id = @student_id
        AND program_course_id = @program_course_id
        AND student_enrollment_date = @student_enrollment_date;
END;
GO

-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteCourseResult
    @student_id INT,
    @program_course_id INT,
    @student_enrollment_date DATE
AS
BEGIN
    DELETE FROM Students.CourseResults
    WHERE
        student_id = @student_id
        AND program_course_id = @program_course_id
        AND student_enrollment_date = @student_enrollment_date;
END;
GO

-------------------------------------------------------------------------
---- 25- Students.ExamSubmissions CRUD procedures ----
-------------------------------------------------------------------------

-- CREATE
CREATE OR ALTER PROCEDURE sp_GetExamSubmissions
AS
BEGIN
    SELECT *
    FROM Students.ExamSubmissions;
END;
GO


-- INSERT
CREATE OR ALTER PROCEDURE sp_InsertExamSubmission
    @exam_submission_datetime DATETIME,
    @student_id INT,
    @exam_id INT,
    @question_id INT,
    @answer_id INT
AS
BEGIN
    INSERT INTO Students.ExamSubmissions (exam_submission_datetime, student_id, exam_id, question_id, answer_id)
    VALUES (@exam_submission_datetime, @student_id, @exam_id, @question_id, @answer_id);
END;
GO


-- DELETE
CREATE OR ALTER PROCEDURE sp_DeleteExamSubmission
    @exam_submission_datetime DATETIME,
    @student_id INT,
    @exam_id INT,
    @question_id INT,
    @answer_id INT
AS
BEGIN
    DELETE FROM Students.ExamSubmissions
    WHERE
        exam_submission_datetime = @exam_submission_datetime
        AND student_id = @student_id
        AND exam_id = @exam_id
        AND question_id = @question_id
        AND answer_id = @answer_id;
END;
GO
