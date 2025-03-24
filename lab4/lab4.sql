--1
SELECT COUNT(d.department_id) AS "Działy bez przypisanego managera"
FROM hr.departments d
WHERE d.manager_id IS NULL;

--2
SELECT FLOOR(MONTHS_BETWEEN(MAX(e.hire_date), MIN(e.hire_date)) / 12) AS "Liczba pełnych lat"
FROM hr.employees e;

--3
SELECT d.department_name
FROM hr.departments d
LEFT JOIN hr.employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.department_id) = 0;

--4
SELECT d.department_name, ROUND(AVG(e.salary), 0) AS "Average Salary"
FROM hr.departments d
INNER JOIN hr.employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY "Average Salary" DESC;

--5
SELECT c.country_name, COUNT(e.employee_id) AS "Liczba pracowników"
FROM hr.countries c
LEFT JOIN hr.locations l ON c.country_id = l.country_id
LEFT JOIN hr.departments d ON d.location_id = l.location_id
LEFT JOIN hr.employees e ON e.department_id = d.department_id
GROUP BY c.country_name
ORDER BY "Liczba pracowników" DESC, c.country_name ASC;

--6
SELECT d.department_name, SUM(e.salary) AS "Suma zarobków"
FROM hr.departments d
LEFT JOIN hr.employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING SUM(e.salary) > 15000 AND SUM(e.salary) <= 40000
ORDER BY "Suma zarobków" ASC;

--7
SELECT d.department_name, SUM(e.salary) AS "Suma zarobków"
FROM hr.departments d
LEFT JOIN hr.employees e ON d.department_id = e.department_id
WHERE EXTRACT(MONTH FROM e.hire_date) = 6
GROUP BY d.department_name
HAVING SUM(e.salary) > 15000 AND SUM(e.salary) <= 40000
ORDER BY "Suma zarobków" ASC;