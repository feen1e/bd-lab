--1
SELECT * FROM ALL_TRIGGERS
WHERE table_name = 'EMPLOYEES';

-- Wykorzystywalismy update_job_history

--2
CREATE TRIGGER raise_manager_salary
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    UPDATE employees
    SET salary = salary + 0.01 * salary
    WHERE employee_id = (SELECT manager_id FROM departments WHERE department_id = :new.department_id);
END;

SELECT employee_id, salary, department_id FROM employees WHERE employee_id = (SELECT manager_id FROM departments WHERE department_name = 'IT');

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (300, 'Dominik', 'Kaczmarek', 'DKACZM', current_date, 'IT_PROG', 60);

DELETE FROM employees
WHERE employee_id = 300;

--3
SELECT first_name, last_name, email FROM employees
WHERE first_name = 'James' OR email LIKE '%.DE';

UPDATE departments
SET location_id = 2700
WHERE department_name = 'Accounting';

UPDATE departments
SET location_id = 2500
WHERE department_name = 'Shipping';

CREATE TRIGGER change_department_location
AFTER UPDATE ON departments
FOR EACH ROW
BEGIN
    IF :new.location_id = 2700 THEN
        UPDATE employees e
        SET e.email = CONCAT(e.email, '.DE')
        WHERE e.department_id = :new.department_id;
    END IF;
    IF :new.location_id IN (2400, 2500, 2600) THEN
        UPDATE employees
        SET last_name = 'Bond'
        WHERE first_name = 'James';
    END IF;
END;

--4
CREATE VIEW it_employees_view AS
SELECT * FROM employees
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'IT');

CREATE TRIGGER change_to_accounting
INSTEAD OF DELETE ON it_employees_view
FOR EACH ROW
BEGIN
    UPDATE it_employees_view
    SET department_id = (SELECT department_id FROM departments WHERE department_name = 'Accounting')
    WHERE :old.employee_id = employee_id;
END;

--Na tabelach nie mozna tworzyc triggerow INSTEAD OF

SELECT * FROM it_employees_view;

DELETE FROM it_employees_view
WHERE employee_id < 105;

SELECT e.*, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.employee_id BETWEEN 103 AND 104;

DROP TRIGGER raise_manager_salary;
DROP TRIGGER change_department_location;
DROP TRIGGER change_to_accounting;
DROP VIEW it_employees_view;