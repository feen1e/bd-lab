--1
CREATE VIEW JOB_HISTORY_DETAILS_VIEW AS
SELECT jh.*, e.first_name, e.last_name, j.job_title, d.department_name
FROM hr.job_history jh
JOIN hr.employees e ON jh.employee_id = e.employee_id
JOIN hr.jobs j ON jh.job_id = j.job_id
JOIN hr.departments d ON jh.department_id = d.department_id;

SELECT * FROM JOB_HISTORY_DETAILS_VIEW;

--2
INSERT INTO hr.job_history
VALUES (104, TO_DATE('24-03-2004', 'DD-MM-YYYY'), TO_DATE('24-03-2005', 'DD-MM-YYYY'), 'IT_PROG', 60);

SELECT * FROM JOB_HISTORY_DETAILS_VIEW;
-- pojawil sie

--3
UPDATE job_history_details_view
SET job_title = 'Accountant'
WHERE employee_id = 102;

SELECT table_name, column_name, updatable FROM USER_UPDATABLE_COLUMNS
WHERE table_name = 'JOB_HISTORY_DETAILS_VIEW';

--4
CREATE VIEW IT_EMPLOYEES_VIEW AS
SELECT e.employee_id, e.first_name, e.last_name, e.hire_date , e.email, e.job_id, j.job_title, d.department_name
FROM hr.employees e
JOIN hr.jobs j ON e.job_id = j.job_id
JOIN hr.departments d ON e.department_id = d.department_id
WHERE d.department_name = 'IT';

SELECT * FROM it_employees_view;

INSERT INTO it_employees_view
VALUES (207, 'DOminik', 'Kaczmarek', CURRENT_DATE, 'DKACZMAREK', 'IT_PROG', 'Programmer', 'IT');

--5
UPDATE IT_EMPLOYEES_VIEW
SET last_name = (SELECT last_name FROM hr.employees WHERE employee_id = (SELECT manager_id FROM hr.departments WHERE department_name = 'IT'));

SELECT * FROM it_employees_view;
SELECT e.*, d.department_name FROM hr.employees e JOIN hr.departments d ON e.department_id = d.department_id WHERE department_name = 'IT';

--6
DROP VIEW JOB_HISTORY_DETAILS_VIEW;
DROP VIEW IT_EMPLOYEES_VIEW;