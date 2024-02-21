# Learning Management System (LMS)

## Introduction
A Learning Management System (LMS) is an essential component for educational institutions to effectively manage their resources, courses, instructors, and students. This documentation outlines a database schema designed to support the functionalities required for an efficient LMS.

This documentation outlines the functionalities and architecture of an operational database devised to efficiently manage course enrollments and results within educational institutions. The database draws inspiration from my university's learning management system, where staff could create semester schedules, students self-enroll in courses, and instructors input final course scores.

#### Objectives:
- **Enhanced Visibility:** The database seeks to improve Visibility by providing a comprehensive overview while allowing its users to drill down to the most atomic details of data.
- **Detailed Course Results:** It aims to offer in-depth course result details, moving beyond just displaying final scores to encompassing a broader spectrum of student performance metrics.
- **Automation Integration:** By automating various processes, particularly exams and assessments, the database aims to streamline operations and enhance overall efficiency.
- **Analytics:** provide all the data required to further build analytical solutions that would provide decision makers the necessary tools to improve the learning experience.

### Functionalities Mapping

1. **Institution Management:**
   - Addition of institutions like Alexandria University and MIT to facilitate management across multiple institutions simultaneously.

2. **Classroom and Department Assignment:**
   - Assignment of classrooms (lecture halls, labs) to institutions.
   - Assignment of departments (e.g., Mechanical Engineering, Nuclear Physics) to institutions.

3. **Teacher Management:**
   - Hiring of teachers within institutions and assignment to specific departments.

4. **Program Administration:**
   - Assignment of programs (e.g., Mechanical Engineering, Computer Science) to one or more institutions.
   - Each program can be associated with specific courses.

5. **Course Management:**
   - Assignment of courses to programs.
   - Each course contains topics, exams, and their respective questions and answers.

6. **Semester Management:**
   - Assignment of available semesters (e.g., Fall, Spring, Summer) to each course, with some courses available in multiple semesters.

7. **Schedule Creation:**
   - Creation of schedules by assigning classrooms, time slots, programs, courses, and teachers.
   - Definition of start and end times for lectures or labs in schedule tables.

8. **Student Enrollment:**
   - Students can enroll in institutions such as Alexandria University or MIT.
   - Enrollment in classes is subject to availability, absence of time conflicts, fulfillment of prerequisites, and availability of seats.

9. **Examination System:**
   - Instantaneous grading and review of multiple-choice exams.
   - Detailed feedback provided to students highlighting areas of weakness and referencing relevant study materials for improvement.

### Roles Mapping

1. **Institution Managers:**
    - Create and manage institutions, classes, and departments.
    - Manage programs, courses, and topics.
    - Assign courses to programs and instructors to course classes.

2. **Senior Instructors:**
    - Create programs, courses, and topics.
    - Create exams and assessments for each course.
    - Define prerequisites and assign semesters to courses.

3. **Instructors' Managers:**
    - Register instructors and assign them to institutions, departments, and supervisors.
    - Manage instructor information and credentials.

4. **Students Managers:**
    - Register students and assign them to programs and institutions.
    - Manage student enrollment and track enrollment submissions.

5. **Instructors:**
    - View personal information, assigned courses, and students.
    - Manage student course assessments, results, and exam submissions.

6. **Students:**
    - View personal information, course assignments, and results.
    - View course assessments scores and exam submissions.
    - Subscribe to available courses or classes and submit exams.

### Database Mapping
![Fig 1: Database Architecture ERD Using Drawio](4-Report%20Documents/media/StudentMangmentERD2_drawio.png)

- **Institutions Schema:** Manages the infrastructure, instructors, schedule of educational institutions.
- **Programs Schema:** Focuses on academic programs, courses, assessments, and their interconnections.
- **Students Schema:** Facilitates student enrollment, assessment scores, course results, and exam submissions.

> Note: the notes folder requirement analysis Mapping notebooks has in depth detailed analysis and mapping and the sql script folder `CRUD-PROCS.sql` and tables3.sql has all the DDL for the database and its Create, Read, Update, Delete procedures for each table.

![Fig 2: Database ERD Using SSMS](4-Report%20Documents/media/ERD_SSMS.png)

## Mock Data Generation
### Data Generation Strategy
Various data generation tools and techniques were employed to populate the core tables with realistic data compliant with the operational logic of the LMS.

The data used in the Learning Management Database was generated using Mock data from various sources for tables like students, instructors, and courses the data was generated using the online dictionary too `Mockaroo`, while other data was generated using patterns using `SQL scripts` to join the mock tables with some patterns, for example, the topics table is generated by adding patterns like chapters 1 to 4 for every course. More complex data was generated using `SQL cursors` and `Python scripts`.

## Importing Mock Data
SQL Server Integration Services (SSIS) was used to import the generated data while monitoring it for any discrepancies to the database.

- **Database Reset:** Truncate all data from the database and reset all Surrogate identity keys.
- **Source and Destination Configuration:** Staging CSV files as data sources and the LMS database as the destination.
- **Control Flow Steps:** Data flow steps and management of foreign key constraints.

![Fig 3: Simulated Migration from cleaned CSV files to the database Using SSIS](4-Report%20Documents/media/SSIS.png)

## Reporting
Automated reports were generated using database views and dashboards created with Power BI.

- **Database Views:** Three views were created to provide a top view of the learning process.
- **Dashboards:** Student Demographics, Schedule, Student Assessments, and Exams.

### Dashboards
![Fig 4: schedule dashboard of all classes scheduled with a count down to the nearest class, highlighting the status of each student whether he/she is free or in a class. data is displayed for an administrator role](4-Report%20Documents/media/schedule.png)
![Fig 5: Assessments' dashboard showing students' coursework of the embedded systems track and computer science program from an administrator's role point of view](4-Report%20Documents/media/Assessments.png)
![Fig 6: exam submissions dashboard showing all 120 students enrolled in the computer science program for an admin role](4-Report%20Documents/media/exams.png)
![Fig 7: Programs' Students' Demographics dashboards showing the number of first-year students enrolled in Alexandria University mechanical engineering program by course from an administrator role point of view](4-Report%20Documents/media/demographics.png)

> Note the Dashboard views are available in the Notes' folder reporting queries notebook

## Future Improvements
- **Designing a Data Warehouse:** This improvement would enable comprehensive historical analysis of programs, courses, student performance, and instructor effectiveness.
- **Migrating to a Cloud Platform:** Moving the database and warehouse to a cloud platform offers better availability, scalability, and easier maintenance.
- **Generalizing the Application for Any Learning Institution or Platform:**  Making the application adaptable for any learning institution or platform would increase its market potential and utility. Additionally the vast amount of data available may provide key insights to improve the way we educate future generations.
- **Migrating to a Distributed No-SQL Database:** Transitioning to a distributed NoSQL database could better handle big data scenarios, providing scalability and flexibility.

## Conclusion
This documentation provides a comprehensive overview of an operational database for a Learning Management System (LMS), including its requirement analysis (functionalities), database mapping, mock data generation, mock data migration, and finally operational and analytics reporting. By aligning system functionalities with user roles and incorporating dynamic reporting tools, the LMS streamlines educational activities and enhance learning outcomes.