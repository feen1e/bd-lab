--1
SELECT current_date FROM DUAL;

--2
CREATE SEQUENCE ORDERED_NUMBERS START WITH 0 INCREMENT BY 1 MINVALUE 0 MAXVALUE 15 CYCLE NOCACHE;

SELECT ORDERED_NUMBERS.nextval FROM DUAL;

--3
CREATE SEQUENCE DESCENDING_NUMBERS START WITH 1000 INCREMENT BY -10 MINVALUE 100 MAXVALUE 1000 NOCYCLE CACHE 100;

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES (DESCENDING_NUMBERS.nextval, 'Adrian', 'Zandberg', 'AZAND', current_date, 'IT_PROG');
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES (descending_numbers.nextval, 'Joanna', 'Senyszyn', 'JSEN', current_date, 'AC_ACCOUNT');
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES (descending_numbers.nextval, 'Rafal', 'Trzaskowski', 'RTRZAS', current_date, 'AD_ASST');

SELECT * FROM employees
WHERE employee_id > 300;

--4
ALTER SEQUENCE DESCENDING_NUMBERS INCREMENT BY -11;

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES (descending_numbers.nextval, 'Magdalena', 'Biejat', 'MBIEJ', current_date, 'SH_CLERK');

SELECT * FROM employees WHERE employee_id > 300;

DELETE FROM employees WHERE employee_id > 300;

--5
CREATE INDEX EMPLOYEE_INDEX
ON employees (first_name, last_name, hire_date);

EXPLAIN PLAN FOR
SELECT first_name, last_name, hire_date FROM employees;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

DROP INDEX EMPLOYEE_INDEX;
DROP SEQUENCE ORDERED_NUMBERS;
DROP SEQUENCE DESCENDING_NUMBERS;

--Dodatkowe
CREATE INDEX EMPLOYEE_INDEX
ON employees (first_name, last_name, hire_date);

EXPLAIN PLAN FOR
SELECT first_name
FROM EMPLOYEES
WHERE ROWNUM = 1 AND hire_date < current_date AND (first_name LIKE 'A%' OR last_name LIKE 'B%');

declare
    t1 timestamp;
    t2 timestamp;
    n varchar2(30);
begin
    t1 := systimestamp;
    FOR i IN 1 .. 50000
        LOOP
            SELECT first_name into n
            FROM EMPLOYEES
            WHERE ROWNUM = 1 AND hire_date < current_date AND (first_name LIKE 'A%' OR last_name LIKE 'B%');
        END LOOP;
    t2 := systimestamp;
    dbms_output.put_line('Start: '||t1);
    dbms_output.put_line('End: '||t2);
    dbms_output.put_line('Elapsed Seconds: '||TO_CHAR(t2-t1, 'SSSS.FF'));
end;