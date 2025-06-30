-- 1
INSERT INTO hr.departments
VALUES (280, 'Interns',
    (SELECT employee_id FROM employees
    ORDER BY hire_date DESC
    FETCH FIRST 1 ROWS ONLY),
    (SELECT location_id FROM locations
    WHERE city='Tokyo'));
    
SELECT * FROM hr.departments d JOIN hr.locations l ON d.location_id = l.location_id WHERE department_id = 280;

--2
INSERT INTO hr.employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (207, 'Jan', 'Kowalski', 'JKOW', TO_DATE('27-04-2024', 'DD-MM-YYYY'), 'IT_PROG', 60);
INSERT INTO hr.employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (208, 'Adam', 'Nowak', 'ADNOW', TO_DATE('27-04-2024', 'DD-MM-YYYY'), 'IT_PROG', 60);
INSERT INTO hr.employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (209, 'Anna', 'Nowak', 'ANNOW', TO_DATE('27-04-2024', 'DD-MM-YYYY'), 'IT_PROG', 60);
INSERT INTO hr.employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (210, 'Daniel', 'Kowalski', 'DKOW', TO_DATE('27-04-2024', 'DD-MM-YYYY'), 'IT_PROG', 60);
INSERT INTO hr.employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (211, 'Magdalena', 'Guss', 'MGUSS', TO_DATE('27-04-2024', 'DD-MM-YYYY'), 'IT_PROG', 60);

SELECT * FROM hr.employees e JOIN hr.departments d ON e.department_id = d.department_id WHERE employee_id >= 207;

--3
UPDATE hr.employees
SET department_id = 280
WHERE employee_id >= 207;

SELECT * FROM hr.employees e JOIN hr.departments d ON e.department_id = d.department_id WHERE employee_id >= 207;

--4
DELETE FROM hr.job_history
WHERE employee_id >= 207;

DELETE FROM hr.employees
WHERE employee_id >= 207;

SELECT COUNT(*) FROM hr.employees;

--5
SELECT employee_id, first_name, last_name, salary FROM hr.employees
WHERE salary < (SELECT AVG(e.salary)FROM hr.employees e);

UPDATE hr.employees
SET salary = salary + 0.1 * salary
WHERE salary < (SELECT AVG(e.salary)FROM hr.employees e);

SELECT employee_id, first_name, last_name, salary FROM hr.employees
WHERE salary < (SELECT AVG(e.salary)FROM hr.employees e);

SELECT AVG(salary) FROM hr.employees;

--6
INSERT INTO hr.job_history
SELECT employee_id, hire_date, CURRENT_DATE, job_id, department_id FROM hr.employees
WHERE employee_id NOT IN (SELECT employee_id FROM job_history);

SELECT * FROM job_history;
SELECT COUNT(*) FROM job_history;

--7
UPDATE hr.employees
SET manager_id = NULL
WHERE manager_id IN
    (SELECT employee_id FROM hr.employees
    WHERE commission_pct > 0.3);
    
UPDATE hr.departments
SET manager_id = NULL
WHERE manager_id IN
    (SELECT employee_id FROM hr.employees
    WHERE commission_pct > 0.3);
    
DELETE FROM hr.job_history
WHERE employee_id IN (SELECT employee_id FROM hr.employees
    WHERE commission_pct > 0.3);
    
DELETE FROM hr.employees
WHERE employee_id IN (SELECT employee_id FROM hr.employees
    WHERE commission_pct > 0.3);
    
SELECT COUNT(*) FROM hr.employees;