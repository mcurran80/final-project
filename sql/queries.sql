INSERT INTO "registration" ("student_id", "course_id")
VALUES ("8675309", "52");

DELETE FROM "registration"
WHERE "student_id" = '8675309';

UPDATE "courses"
SET "name" = 'Print Journalism'
WHERE "id" = '92';



-- Outputs the current class schedule for the student ID number in the WHERE clause
SELECT
    "courses"."id" AS "Course ID Number",
    "departments"."code" AS "Department",
    "courses"."number" AS "Number",
    "courses"."name" AS "Name",
    "times"."time" AS "Schedule",
    "instructors"."last_name" AS "Instructor"
FROM "registration"
JOIN "courses"
    ON "registration"."course_id" = "courses"."id"
JOIN "departments"
    ON "courses"."department" = "departments"."id"
JOIN "times"
    ON "courses"."time" = "times"."id"
JOIN "instructors"
    ON "courses"."instructor" = "instructors"."id"
WHERE "student_id" = 843;

-- Outputs the roster of students registered for a course ID number in the WHERE clause
SELECT
    "students"."id" AS "Student ID",
    "students"."first_name" AS "First Name",
    "students"."last_name" AS "Last Name",
    "students"."email_address" AS "Email Address"
FROM "students"
JOIN "registration"
    ON "students"."id" = "registration"."student_id"
WHERE "course_id" = 34
ORDER BY "students"."last_name" ASC, "students"."first_name" ASC, "students"."id" DESC;

-- Outputs the Max Enrollment and Current Enrollment for a course ID number in the WHERE clause
SELECT
    "courses"."id" AS "Course ID Number",
    "departments"."code" AS "Department",
    "courses"."number" AS "Number",
    "courses"."name" AS "Course Name",
    "courses"."max_enrollment" AS "Max Enrollment",
    (SELECT COUNT(*) FROM "registration"
    WHERE "registration"."course_id" = 83) AS "Current Enrollment"
FROM "courses"
JOIN "departments"
    ON "courses"."department" = "departments"."id"
WHERE "courses"."id" = 83;

-- Inserts a student's enrollment in a course into the registration table
INSERT INTO "registration" ("student_id", "course_id")
VALUES (8888, 8888);

-- Changes a current course registration to dropped
UPDATE "registration"
SET "registration_state" = "Dropped"
WHERE "student_id" = 15 AND "course_id" = 155 AND "registration_state" = "Registered";

-- Outputs list of courses along with their max enrollment and current enrollment numbers
SELECT
    "courses"."id" AS "Course ID Number",
    "departments"."code" AS "Department",
    "courses"."number" AS "Number",
    "courses"."name" AS "Name",
    "times"."time" AS "Schedule",
    "courses"."max_enrollment" AS "Max Enrollment",
    (SELECT COUNT(*) FROM "registration"
    WHERE "registration"."course_id" = "courses"."id") AS "Current Enrollment",
    "instructors"."last_name" AS "Instructor"
FROM "courses"
JOIN "departments"
    ON "courses"."department" = "departments"."id"
JOIN "times"
    ON "courses"."time" = "times"."id"
JOIN "instructors"
    ON "courses"."instructor" = "instructors"."id";

-- Enrolls a student in the university
INSERT INTO "students" ("first_name", "last_name", "email_address")
    VALUES ("Melissa", "Curran", "melissacurran530@gmail.com");