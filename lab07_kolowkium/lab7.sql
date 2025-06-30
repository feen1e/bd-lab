--Grupa a

--1
SELECT e.first_name, e.last_name, e.hire_date, e.salary
FROM hr.employees e
WHERE EXTRACT(YEAR FROM e.hire_date) > 2008 AND e.salary > 7000
ORDER BY e.salary ASC;
--0 wyników, poniewaz po 2008 roku nie zatrudniono nikogo
--SELECT hire_date FROM hr.employees ORDER BY hire_date DESC;

--2
SELECT e.first_name, e.last_name, e.hire_date
FROM hr.employees e
JOIN (SELECT m1.hire_date, d1.department_id FROM hr.employees m1
    JOIN hr.departments d1 ON m1.department_id = d1.department_id
    WHERE m1.employee_id = d1.manager_id) d ON d.department_id = e.department_id
WHERE e.hire_date < d.hire_date;

--3
SELECT COUNT(*) FROM hr.employees e
JOIN (SELECT AVG(e1.salary) AS "AVG", e1.department_id
    FROM hr.employees e1
    GROUP BY e1.department_id) s ON e.department_id = s.department_id
WHERE e.salary > "AVG";

--4
SELECT d1.department_name, "AVG_SALARY"
FROM (SELECT e.department_id, AVG(e.salary) AS "AVG_SALARY"
    FROM hr.employees e
    GROUP BY e.department_id
    HAVING COUNT(e.employee_id) BETWEEN 3 AND 6) d
JOIN hr.departments d1 ON d.department_id = d1.department_id;

--5
SELECT d.department_name, AVG(e.salary)
FROM (SELECT * FROM hr.employees e1
    WHERE EXTRACT(MONTH FROM e1.hire_date) = 1) e
JOIN hr.departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

--6
SELECT e.first_name, e.last_name, j.job_title, e.salary
FROM hr.employees e JOIN hr.jobs j ON e.job_id = j.job_id
JOIN (SELECT AVG(e1.salary) AS "AVG", e1.job_id
    FROM hr.employees e1
    GROUP BY e1.job_id) d ON e.job_id = d.job_id
WHERE "AVG" > 12000;