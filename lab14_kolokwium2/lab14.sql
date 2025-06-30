-- Kolokwium 2 [d]

--1
CREATE TABLE INSPECTIONS (
    inspection_id NUMBER NOT NULL,
    job_id VARCHAR2(10),
    inspection_date DATE NOT NULL,
    description VARCHAR2(200),
    outcome VARCHAR2(10) NOT NULL,
    penalty NUMBER(7,2),
    CONSTRAINT PK_Inspections PRIMARY KEY (inspection_id),
    CONSTRAINT FK_InspectionsJobID FOREIGN KEY (job_id) REFERENCES hr.jobs(job_id)
);

DESCRIBE inspections;

INSERT INTO inspections
VALUES (10, 'AD_VP', current_date, 'inspection 1', 'Negative', 1999.99);

SELECT * FROM inspections;

DELETE FROM inspections WHERE inspection_id = 10;

--2
ALTER TABLE inspections
    ADD CONSTRAINT CHK_Outcome CHECK (outcome = 'Positive' OR outcome = 'Negative');
    
INSERT INTO inspections
VALUES (10, 'AD_VP', current_date, 'inspection 1', 'neutral', 1999.99);
-- check dziala

--3
CREATE SEQUENCE SEQ_InspectionID
    START WITH 100
    INCREMENT BY 10;

INSERT INTO inspections (inspection_id, job_id, inspection_date, description, outcome)
SELECT SEQ_INSPECTIONID.nextval, j.job_id, TO_DATE('01-06-2025', 'DD-MM-YYYY'), 'Kontrola stanowiska pracy ' || j.job_title, 'Positive' FROM jobs j;

SELECT * FROM inspections;

--4
CREATE VIEW LOW_INCOME_VIEW AS
SELECT e.* FROM employees e JOIN jobs j ON e.job_id = j.job_id
WHERE e.salary = j.min_salary;

SELECT * FROM low_income_view;

--5
CREATE TRIGGER LIV_RaiseSalary
INSTEAD OF DELETE ON low_income_view
FOR EACH ROW
BEGIN
    UPDATE low_income_view
    SET salary = salary * 0.1 + salary
    WHERE employee_id = :OLD.employee_id;
END;

DELETE FROM low_income_view WHERE first_name = 'Randall' AND last_name = 'Perkins';
SELECT first_name, last_name, salary FROM employees WHERE first_name = 'Randall' AND last_name = 'Perkins';
-- wyplata podniesiona do 2750
SELECT * FROM low_income_view;

--6
DECLARE
    empID number;
    depID number;
    depName varchar2(30);
    managerID number;
BEGIN
    empID := &empID;
    SELECT department_id INTO depID FROM employees WHERE employee_id = empID;
    SELECT department_name INTO depName FROM departments WHERE department_id = depID;
    SELECT manager_id INTO managerID FROM departments WHERE department_id = depID;
    dbms_output.put_line('Pracownik dzialu ' || depName);
    
    IF empID = managerID THEN
        dbms_output.put_line('Ten pracownik jest managerem tego dzialu.');
    ELSE
        dbms_output.put_line('Ten pracownik nie jest managerem tego dzialu.');
    END IF;
END;

--SELECT department_name, manager_id FROM departments;