-- Create a table to store the table of departments
CREATE TABLE "departments" (
    "id"
        INTEGER
        NOT NULL
        UNIQUE,
    "code"
        TEXT
        NOT NULL
        UNIQUE
        CHECK(LENGTH("code") = 3),
    "name"
        TEXT
        NOT NULL
        UNIQUE,
    PRIMARY KEY("id")
);

-- Imports the contents of departments.csv into the "departments" table.
.import --csv departments.csv "departments"

------------------------------------------------------------------------------------------

-- Create a table to store the table of possible course times
-- CHANGE 11:30 PM TO 11:30 AM --
CREATE TABLE "times" (
    "id"
        INTEGER
        NOT NULL
        UNIQUE,
    "time"
        TEXT
        NOT NULL,
    PRIMARY KEY("id")
);

-- Imports the contents of times.csv into the "times" table.
.import --csv times.csv "times"

------------------------------------------------------------------------------------------

-- Create a table to store the table of instructors
-- ADD A FIELD FOR DEPARTMENT AS WELL
CREATE TABLE "instructors" (
    "id"
        INTEGER
        NOT NULL
        UNIQUE,
    "first_name"
        TEXT,
    "last_name"
        TEXT,
    "email"
        TEXT,
    "department_id"
        INTEGER,
    FOREIGN KEY ("department_id")
        REFERENCES "departments"("id"),
    PRIMARY KEY("id")
);

-- Imports the contents of instructors.csv into the "instructors" table.
.import --csv instructors.csv "instructors"

------------------------------------------------------------------------------------------

-- Create a table to store the table of courses
CREATE TABLE "courses" (
    "id"
        INTEGER
        NOT NULL
        UNIQUE,
    "department"
        INTEGER
        NOT NULL,
    "number"
        INTEGER
        NOT NULL,
    "name"
        TEXT
        NOT NULL,
    "time"
        INTEGER,
    "max_enrollment"
        INTEGER,
    "instructor"
        INTEGER,
    FOREIGN KEY ("department")
        REFERENCES "departments"("id"),
    FOREIGN KEY ("time")
        REFERENCES "times"("id"),
    FOREIGN KEY ("instructor")
        REFERENCES "instructors"("id"),
    PRIMARY KEY("id")
);

-- Imports the contents of courses.csv into the "courses" table.
.import --csv courses.csv "courses"

------------------------------------------------------------------------------------------

-- Create a table to store the table of students
CREATE TABLE "students" (
    "id"
        INTEGER
        NOT NULL
        UNIQUE,
    "first_name"
        TEXT
        NOT NULL,
    "last_name"
        TEXT
        NOT NULL,
    "email_address"
        TEXT
        NOT NULL,
    PRIMARY KEY("id")
);

-- Imports the contents of students.csv into the "students" table.
.import --csv students.csv "students"

------------------------------------------------------------------------------------------

-- Create a table to store all the student course registration records
CREATE TABLE "registration" (
    "id"
        INTEGER
        NOT NULL
        UNIQUE,
    "student_id"
        INTEGER
        NOT NULL,
    "course_id"
        INTEGER
        NOT NULL,
    "date_time"
        NUMERIC
        NOT NULL
        DEFAULT CURRENT_TIMESTAMP,
    "registration_state"
        INTEGER
        NOT NULL
        CHECK("registration_state" IN ("Registered", "Dropped"))
        DEFAULT "Registered",
    PRIMARY KEY("id")
);

-- Note: I used "Registered" and "Dropped" so I could easily print out those results, if needed,
-- on the website. Alternatively, I could store the "registration_state" as 1 and 0,
-- thus reducing the storage space needed for this table.

-- Populate an initial set of registrations (1000 students X 4 courses per student)
.import --csv 1000_student_assignments.csv "registration"

-- Update the date_time field for the 4000 rows of data imported above with the current time stamp
UPDATE "registration"
SET "date_time" = CURRENT_TIMESTAMP
WHERE "registration"."id" <= 4000;

------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------

-- Create a view that merges all course-related data into one table
CREATE VIEW "single_table_view" AS
SELECT
    "courses"."id" AS "Course ID Number",
    "departments"."code" AS "Department",
    "courses"."number" AS "Number",
    "courses"."name" AS "Name",
    "times"."time" AS "Schedule",
    "courses"."max_enrollment" AS "Max Enrollment",
    "instructors"."last_name" AS "Instructor"
FROM "courses"
JOIN "departments"
    ON "courses"."department" = "departments"."id"
JOIN "times"
    ON "courses"."time" = "times"."id"
JOIN "instructors"
    ON "courses"."instructor" = "instructors"."id";

------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------

--
