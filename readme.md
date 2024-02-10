# Learning Management System (LMS) Documentation

## Introduction
The Learning Management System (LMS) is an essential component for educational institutions to effectively manage their resources, courses, instructors, and students. This documentation outlines the database schema designed to support the functionalities required for an efficient LMS.

## Requirement Analysis Mapping
### Requirement Analysis
The LMS was designed to enable students, instructors, and courses management. The system functionalities are mapped to specific roles within educational institutions.

#### Institution Managers:
- Create and manage institutions, classes, and departments.
- Manage programs, courses, and topics.
- Assign courses to programs and instructors to course classes.

#### Senior Instructors:
- Create programs, courses, and topics.
- Create exams and assessments for each course.
- Define prerequisites and assign semesters to courses.

#### Instructors' Managers:
- Register instructors and assign them to institutions, departments, and supervisors.
- Manage instructor information and credentials.

#### Students Managers:
- Register students and assign them to programs and institutions.
- Manage student enrollment and track enrollment submissions.

#### Instructors:
- View personal information, assigned courses, and students.
- Manage student course assessments, results, and exam submissions.

#### Students:
- View personal information, course assignments, and results.
- View course assessments scores and exam submissions.
- Subscribe to available courses or classes and submit exams.

### Database Mapping
The database schema is organized into three main schemas: Institutions, Programs, and Students, each encapsulating pertinent entities and relationships.

![](4-Report%20Documents/media/StudentMangmentERD2_drawio.png)

- **Institutions Schema:** Manages the infrastructure of educational institutions.
- **Programs Schema:** Focuses on academic programs, courses, assessments, and their interconnections.
- **Students Schema:** Facilitates student enrollment, assessment scores, course results, and exam submissions.

> Note: the notes folder requiem analysis Mapping notebooks has in depth detailed analysis and mapping and the sql script folder CRUD PROCS.sql and tables3.sql has all the DDL for the database and its CRUD procedures for each table.

![](4-Report%20Documents/media/ERD_SSMS.png)

## Mock Data Generation
### Data Generation Strategy
Various data generation tools and techniques were employed to populate the core tables with realistic data compliant with the business logic of the LMS.

- **Data Generation Tools:** Mockaroo, SQL Queries, Cursors, and Python Scripting.
- **Data Generation Process:** Core Table Population and Generating Data Compliant with Business Logic.
> Note the queries and scripts used to generate the data are available in the Notes' folder data generation

## Importing Mock Data
SQL Server Integration Services (SSIS) was used to import the generated data while monitoring it for any discrepancies to the database.

- **Database Reset:** Truncate all data from the database and reset all Surrogate identity keys.
- **Source and Destination Configuration:** Staging CSV files as data sources and the LMS database as the destination.
- **Control Flow Steps:** Data flow steps and management of foreign key constraints.

![](4-Report%20Documents/media/SSIS.png)

## Reporting
Automated reports were generated using database views and dashboards created with Power BI.

- **Database Views:** Three views were created to provide a top view of the learning process.
- **Dashboards:** Student Demographics, Schedule, Student Assessments, and Exams.
![](4-Report%20Documents/media/schedule.png)

> Note the Dashboard views are available in the Notes' folder reporting queries notebook 
## Conclusion
This documentation provides a comprehensive overview of the LMS, including requirement analysis, database mapping, mock data generation, importing mock data, and reporting. By aligning system functionalities with user roles and incorporating dynamic reporting tools, the LMS aims to streamline educational activities and enhance learning outcomes.