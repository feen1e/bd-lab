--1 
SELECT e.first_name, e.last_name, j.job_title
FROM hr.employees e INNER JOIN hr.jobs j
ON e.job_id = j.job_id
ORDER BY e.last_name ASC;

--2
SELECT e.first_name, e.last_name, j.job_title
FROM hr.employees e INNER JOIN hr.jobs j
ON e.job_id = j.job_id
WHERE e.salary = j.min_salary;

--3 
SELECT e.first_name, e.last_name
FROM hr.employees e
INNER JOIN hr.departments d ON e.department_id = d.department_id
INNER JOIN hr.locations l ON d.location_id = l.location_id
INNER JOIN hr.countries c ON l.country_id = c.country_id
INNER JOIN hr.regions r ON c.region_id = r.region_id
WHERE r.region_name = 'Europe';

--4
SELECT d.department_name
FROM hr.departments d
LEFT JOIN hr.employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) = 0;

--4 alternatywnie
SELECT d.department_name
FROM hr.departments d
LEFT JOIN hr.employees e ON d.department_id = e.department_id
WHERE e.department_id IS NULL;

--5 
SELECT e.first_name || ' ' || e.last_name AS Pracownik, m.first_name || ' ' || m.last_name AS Przełożony
FROM hr.employees e, hr.employees m
WHERE e.manager_id = m.employee_id
ORDER BY e.last_name ASC;

--6 
SELECT e.first_name, e.last_name
FROM hr.employees e
FULL OUTER JOIN hr.job_history h ON e.department_id = h.department_id
WHERE e.department_id IS NOT NULL AND h.department_id IS NULL
ORDER BY e.last_name ASC;