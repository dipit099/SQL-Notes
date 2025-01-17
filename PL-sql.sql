--PLSQL 

/*
1. USE SEMICOLON
2. MUST BE NON-ZERO VARIABLE , ELSE ERROR
*/
--FIRST EI DECLARE KORTE HOY VARIABLE
DECLARE
	x NUMBER;
	y NUMBER;	
BEGIN
	x:=1;
	y:=2;
	DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
	DBMS_OUTPUT.PUT_LINE(x+y);
END;


--WHAT IF NOT CONST VARIABLE?
DECLARE
	c NUMBER; --STORE ONLY ONE VALUE RETURNED
BEGIN
	SELECT COUNT(*) INTO c FROM EMPLOYEES;
	DBMS_OUTPUT.PUT_LINE(c);
END;


--IF/ELSE
DECLARE
	x NUMBER;
	y NUMBER;	
BEGIN
	x:=1;
	y:=2;
	IF x>y THEN
			DBMS_OUTPUT.PUT_LINE('X IS GREATER');
	ELSE
		DBMS_OUTPUT.PUT_LINE('X IS NOT GREATER');
	END IF;
END;


-- SWITCH CASE
DECLARE
	x NUMBER;
BEGIN
	X:=1;	
	CASE X
	WHEN 1 THEN
		DBMS_OUTPUT.PUT_LINE('111111111');
	ELSE
		DBMS_OUTPUT.PUT_LINE('OTHER');		
	END CASE;
END;




--LOOP 
-- PL/SQL block
DECLARE
    counter NUMBER := 1; -- Initialize counter variable
BEGIN
    -- Start of loop
    LOOP
        DBMS_OUTPUT.PUT_LINE('Counter: ' || counter);  
					
        counter := counter + 1;      
        EXIT WHEN counter > 10;
    END LOOP; -- End of loop
END;


-- PL/SQL block
DECLARE
    multiplier NUMBER;
    multiplicand NUMBER;
BEGIN
    -- Outer loop for the multiplier
    FOR multiplier IN 1..4 LOOP
        FOR multiplicand IN 1..3 LOOP           
            DBMS_OUTPUT.PUT_LINE(multiplier || ' -- ' || multiplicand);
        END LOOP; -- End of inner loop
				DBMS_OUTPUT.PUT('COMING TO OUTER  ');
    END LOOP; -- End of outer loop
END;





DECLARE
	JDATE DATE;  
	
BEGIN
	FOR R IN  ( SELECT * FROM EMPLOYEES)
	LOOP
	
	JDATE:= R.HIRE_DATE;
	IF(TO_CHAR(JDATE,'DD-MM') = TO_CHAR( TO_DATE(SYSDATE), 'DD-MM')) THEN
			DBMS_OUTPUT.PUT_LINE('HAPPY ' || R.FIRST_NAME || ' '||JDATE); 
	END IF;
	END LOOP;
	
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('SAD '); 
END;





DECLARE
	RET NUMBER;
	CC NUMBER;
	DEPTID VARCHAR2(100);
	TEMPSAL VARCHAR2(100);
	
	FUNCTION TOP_PAID(EID IN VARCHAR2, N IN NUMBER)
	RETURN VARCHAR2 IS
	
		BEGIN
		SELECT DEPARTMENT_ID INTO DEPTID 
		FROM EMPLOYEES
		WHERE EID = EMPLOYEE_ID;
		
		SELECT SALARY INTO TEMPSAL
		FROM EMPLOYEES
		WHERE EID = EMPLOYEE_ID;
		
		SELECT COUNT(*) INTO CC
		FROM EMPLOYEES 
		WHERE DEPARTMENT_ID=DEPTID AND SALARY>TEMPSAL;
		
		IF(CC > N) THEN
		RET:=0;
		ELSE RET:=1;
		
		END IF;
		

		RETURN RET;
-- 		
		END;

BEGIN
DBMS_OUTPUT.PUT_LINE(TOP_PAID(151,13));

END;


































