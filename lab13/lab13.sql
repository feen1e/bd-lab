--1
BEGIN
    dbms_output.put_line('Hello World!');
END;

--2
DECLARE
    minsal number; maxsal number; avgsal integer;
BEGIN
    SELECT max(salary) INTO maxsal FROM hr.employees;
    SELECT min(salary) INTO minsal FROM hr.employees;
    avgsal := (maxsal + minsal) / 2;
    dbms_output.put_line('Maksymalna wyplata to ' || maxsal);
    dbms_output.put_line('Minimalna wyplata to ' || minsal);
    dbms_output.put_line('Ich średnia arytmetyczna to ' || avgsal);
END;

--3
DECLARE
    minsal number; maxsal number; harsal integer;
    FUNCTION sredniaHarmoniczna(lb1 IN number, lb2 IN number)
    RETURN integer
    IS
        res integer;
    BEGIN
        res := 2 / ((1 / lb1) + (1 / lb2));
        RETURN res;
    END;
BEGIN
    SELECT max(salary) INTO maxsal FROM hr.employees;
    SELECT min(salary) INTO minsal FROM hr.employees;
    harsal := sredniaHarmoniczna(minsal, maxsal);
    dbms_output.put_line('Maksymalna wyplata to ' || maxsal);
    dbms_output.put_line('Minimalna wyplata to ' || minsal);
    dbms_output.put_line('Ich średnia harmoniczna to ' || harsal);
END;

--4
DECLARE
    minsal number; maxsal number; harsal integer;
    depID number; depName varchar2(30);
    FUNCTION sredniaHarmoniczna(lb1 IN number, lb2 IN number)
    RETURN integer
    IS
        res integer;
    BEGIN
        res := 2 / ((1 / lb1) + (1 / lb2));
        RETURN res;
    END;
BEGIN
    depID := &depID;
    SELECT max(salary) INTO maxsal FROM hr.employees WHERE department_id = depID;
    SELECT min(salary) INTO minsal FROM hr.employees WHERE department_id = depID;
    harsal := sredniaHarmoniczna(minsal, maxsal);
    SELECT department_name INTO depName FROM hr.departments WHERE department_id = depID;
    dbms_output.put_line('Wybrany dzial to ' || depName);
    dbms_output.put_line('Maksymalna wyplata to ' || maxsal);
    dbms_output.put_line('Minimalna wyplata to ' || minsal);
    dbms_output.put_line('Ich średnia harmoniczna to ' || harsal);
END;

--5
DECLARE
    minsal number; maxsal number; harsal integer;
    depID number; depName varchar2(30);
    FUNCTION sredniaHarmoniczna(lb1 IN number, lb2 IN number)
    RETURN integer
    IS
        res integer;
    BEGIN
        res := 2 / ((1 / lb1) + (1 / lb2));
        RETURN res;
    END;
BEGIN
    depID := &depID;
    SELECT max(salary) INTO maxsal FROM hr.employees WHERE department_id = depID;
    SELECT min(salary) INTO minsal FROM hr.employees WHERE department_id = depID;
    harsal := sredniaHarmoniczna(minsal, maxsal);
    SELECT department_name INTO depName FROM hr.departments WHERE department_id = depID;
    dbms_output.put_line('Wybrany dzial to ' || depName);
    dbms_output.put_line('Maksymalna wyplata to ' || maxsal);
    dbms_output.put_line('Minimalna wyplata to ' || minsal);
    dbms_output.put_line('Ich średnia harmoniczna to ' || harsal);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Dzial o ID ' || depID || ' nie istnieje.');
END;

--6
--SELECT department_id FROM hr.departments WHERE department_name = 'Shipping';

DECLARE
    depID number;
    c_fname varchar2(20); c_lname varchar2(25); c_email varchar2(25); c_phone varchar2(20);
    CURSOR c_employees IS
        SELECT first_name, last_name, email, phone_number FROM hr.employees WHERE department_id = depID;
BEGIN
    depID := &depID;
    OPEN c_employees;
    LOOP
        FETCH c_employees INTO c_fname, c_lname, c_email, c_phone;
        EXIT WHEN c_employees%notfound;
        dbms_output.put_line(c_fname || ' ' || c_lname || ', ' || c_email || ', ' || c_phone);
    END LOOP;
    CLOSE c_employees;
END;