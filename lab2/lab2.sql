--1
SELECT DISTINCT job_id FROM employees
ORDER BY job_id ASC;

--2
SELECT job_id, job_title, max_salary FROM jobs
WHERE max_salary < 10000
ORDER BY max_salary DESC;

--3
SELECT first_name, last_name, email, hire_date FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = '2004';

--4
SELECT first_name, last_name, email, hire_date FROM employees
WHERE hire_date > TO_DATE('13.01.2008', 'DD.MM.YYYY');

--5
SELECT first_name, last_name, job_id, salary FROM employees
WHERE salary BETWEEN 9000 AND 10000;

--6.1
SELECT first_name, last_name FROM employees
WHERE SUBSTR(last_name, 1, 1) = 'K' AND SUBSTR(last_name, -1, 1)!= 'g';

--6.2
SELECT first_name, last_name FROM employees
WHERE REGEXP_LIKE(last_name, '^K.*[^g]$');