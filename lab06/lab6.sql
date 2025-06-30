--1
SELECT job_title FROM hr.jobs
WHERE job_id IN (SELECT job_id FROM hr.jobs INTERSECT
                 SELECT job_id FROM hr.job_history);

--2
SELECT department_name FROM hr.departments
WHERE department_id IN (SELECT department_id FROM hr.departments MINUS
                        SELECT department_id FROM hr.job_history);
                        
--3
SELECT first_name, last_name FROM hr.employees
WHERE salary > 12000
UNION
SELECT e.first_name, e.last_name FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Sales';

--4
SELECT * FROM hr.employees e JOIN (
    SELECT employee_id, COUNT(employee_id) AS "ID_Count" FROM (
        SELECT employee_id FROM hr.employees
        WHERE salary > 12000
        UNION ALL
        SELECT e.employee_id FROM hr.employees e
        JOIN hr.departments d ON e.department_id = d.department_id
        WHERE d.department_name = 'Sales')
    GROUP BY employee_id) e1 ON e.employee_id = e1.employee_id
WHERE "ID_Count" = 2;

--5
SELECT e.first_name, e.last_name FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
WHERE d.department_name = 'IT'
MINUS
SELECT e2.first_name, e2.last_name FROM hr.employees e2
WHERE e2.manager_id IN (
    SELECT m.employee_id FROM hr.employees m
    JOIN hr.departments d2 ON m.department_id = d2.department_id
    WHERE d2.department_name = 'IT');
    
--6
SELECT m.first_name || ' ' || m.last_name AS "NAME",
    EXTRACT(YEAR FROM e.hire_date) AS "HIRE_YEAR",
    COUNT(e.employee_id) AS "EMPLOYEE_COUNT"
FROM hr.employees e
JOIN hr.employees m ON e.manager_id = m.employee_id
GROUP BY ROLLUP(m.first_name || ' ' || m.last_name, EXTRACT(YEAR FROM e.hire_date))
ORDER BY "NAME" ASC, "HIRE_YEAR" ASC;

--7
SELECT department_name, job_title, SUM(salary) FROM (
    SELECT d.department_name, j.job_title, e.salary FROM hr.employees e
    JOIN hr.departments d ON e.department_id = d.department_id
    JOIN hr.jobs j ON e.job_id = j.job_id
    GROUP BY d.department_name, j.job_title, e.salary
    HAVING COUNT(e.employee_id) >= 3)
GROUP BY ROLLUP(department_name, job_title)
ORDER BY SUM(salary) DESC;

SELECT d1.department_name, j.job_title, SUM(e1.salary) FROM hr.employees e1
JOIN (SELECT d.department_id, d.department_name FROM hr.departments d
      JOIN hr.employees e ON e.department_id = d.department_id
      GROUP BY d.department_name, d.department_id
      HAVING COUNT(e.employee_id) >= 3) d1 ON d1.department_id = e1.department_id
JOIN hr.jobs j ON j.job_id = e1.job_id
GROUP BY ROLLUP(d1.department_name, j.job_title)
ORDER BY SUM(e1.salary) DESC;

--8
SELECT d.department_name,
    EXTRACT(YEAR FROM e.hire_date) AS "EMPLOYEE_HIRE_YEAR",
    COUNT(e.employee_id)
FROM hr.employees e JOIN hr.departments d ON e.department_id = d.department_id
GROUP BY CUBE(d.department_name, EXTRACT(YEAR FROM e.hire_date))
HAVING COUNT(e.employee_id) >= 3
ORDER BY "EMPLOYEE_HIRE_YEAR" ASC;