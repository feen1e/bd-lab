--1
CREATE TABLE students (
    index_number number(6) PRIMARY KEY,
    first_name varchar2(16) NOT NULL,
    last_name varchar2(32) NOT NULL,
    birth_date date,
    semester_number number(2) CHECK (semester_number BETWEEN 1 AND 10),
    average_grade number(2,1) CHECK (average_grade BETWEEN 2.0 AND 5.5)
);

DESCRIBE students;

--2
CREATE TABLE fields (
    field_id char(3) PRIMARY KEY,
    field_name varchar2(32) NOT NULL,
    faculty_name varchar2(50) NOT NULL,
    field_type char(1) NOT NULL CHECK (field_type = 'S' OR field_type = 'N')
);

DESCRIBE fields;

--3
INSERT INTO students
VALUES (281007, 'Dominik', 'Kaczmarek', TO_DATE('24-09-2004', 'DD-MM-YYYY'), 4, 4.5);

INSERT INTO fields
VALUES ('ITE', 'Informatyka techniczna', 'Informatyki i telekomunikacji', 'S');

UPDATE students
SET semester_number = 15;
-- CHECK dziala

UPDATE students
SET average_grade = 6;
-- CHECK dziala

UPDATE fields
SET field_type = 'A';
-- CHECK dziala

SELECT * FROM students;
SELECT * FROM fields;

--4
ALTER TABLE students
MODIFY semester_number DEFAULT 1;

ALTER TABLE fields
MODIFY field_type DEFAULT 'S';

INSERT INTO students (index_number, first_name, last_name, birth_date, average_grade)
VALUES (281008, 'Hania', 'Melnik', TO_DATE('08-12-2004', 'DD-MM-YYYY'), 4.6);

INSERT INTO fields (field_id, field_name, faculty_name)
VALUES ('IST', 'Informatyka stosowana', 'Informatyki i telekomunikacji');

SELECT * FROM students;
SELECT * FROM fields;

--5
ALTER TABLE students
ADD field_id char(3);

ALTER TABLE students
ADD CONSTRAINT fk_field_id FOREIGN KEY (field_id) REFERENCES fields(field_id);

UPDATE students
SET field_id = 'ITE'
WHERE index_number = '281007';

UPDATE students
SET field_id = 'IST'
WHERE index_number = '281008';

UPDATE students
SET field_id = 'ITC'
WHERE index_number = '281007';
-- nie mozna zmienic id na takie ktore nie wystepuje w fields

SELECT * FROM students;

--6
ALTER TABLE fields
DROP COLUMN faculty_name;

SELECT * FROM fields;

--7
DROP TABLE students;
DROP TABLE fields;
