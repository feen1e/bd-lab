--1
SELECT e.first_name, e.last_name, e.salary
FROM hr.employees e
WHERE e.salary > 2 * (SELECT AVG(salary) FROM hr.employees);

--2
SELECT e.first_name, e.last_name, e.salary
FROM hr.employees e
WHERE e.salary > 2 * (SELECT AVG(e1.salary)
    FROM hr.employees e1
    INNER JOIN hr.departments d ON e.department_id = e1.department_id
    WHERE e1.department_id = d.department_id
    GROUP BY d.department_name);
    
--3
SELECT e.first_name, e.last_name, h.end_date - h.start_date AS "DAYS", d.department_name, j.job_title
FROM hr.employees e
INNER JOIN hr.job_history h ON e.employee_id = h.employee_id
INNER JOIN hr.departments d ON h.department_id = d.department_id
INNER JOIN hr.jobs j ON j.job_id = h.job_id
ORDER BY e.last_name;

--4
SELECT e.first_name, e.last_name, d.department_name, e.salary
FROM hr.employees e
INNER JOIN hr.departments d ON e.department_id = d.department_id
WHERE e.department_id IN (SELECT e1.department_id
    FROM hr.employees e1
    GROUP BY e1.department_id
    HAVING COUNT(e1.employee_id) <10)
ORDER BY e.salary ASC;

--5
SELECT *
FROM hr.employees e
WHERE e.first_name IN (SELECT e1.first_name
    FROM hr.employees e1
    INNER JOIN hr.departments d ON e1.department_id = d.department_id
    INNER JOIN hr.locations l ON d.location_id = l.location_id
    WHERE l.city = 'Seattle')
ORDER BY e.first_name;

--6
SELECT d.department_name AS "DEPARTMENT NAME", COUNT(e.employee_id) AS "DEPARTMENT EMPLOYEE COUNT" , m.first_name || ' ' || m.last_name AS "MANAGER NAME",
    (SELECT COUNT(*)
    FROM hr.employees e1
    WHERE e1.manager_id = d.manager_id) AS "MANAGER EMPLOYEE COUNT"
FROM hr.departments d
INNER JOIN hr.employees e ON d.department_id = e.department_id
INNER JOIN hr.employees m ON d.manager_id = m.employee_id
GROUP BY d.department_name, m.first_name || ' ' || m.last_name, d.manager_id
ORDER BY d.department_name ASC;