
	
	SELECT C.COUNTRY_ID,COUNT(DISTINCT D.DEPARTMENT_ID)
	FROM DEPARTMENTS D JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID 
	JOIN COUNTRIES C ON L.COUNTRY_ID =C.COUNTRY_ID
	GROUP BY C.COUNTRY_ID
	
	
	SELECT E1.LAST_NAME, ( SELECT COUNT(*) FROM EMPLOYEES E2 WHERE E2.HIRE_DATE< E1.HIRE_DATE)
	FROM EMPLOYEES E1;
	
	SELECT E1.LAST_NAME
	FROM EMPLOYEES E1 
	WHERE 3<=	(
	SELECT COUNT(*)
	FROM EMPLOYEES E2 WHERE E2.SALARY < E1.SALARY );
	
	
	SELECT E1.LAST_NAME, (SELECT COUNT(DISTINCT E2.SALARY) FROM EMPLOYEES E2 WHERE E2.SALARY>E1.SALARY) +1 AS RANK
	FROM EMPLOYEES E1 	
	ORDER BY RANK


	SELECT E1.LAST_NAME 	
	FROM EMPLOYEES E1 	
	WHERE ( (SELECT COUNT(DISTINCT E2.SALARY) FROM EMPLOYEES E2 WHERE E2.SALARY>E1.SALARY) +1 )<=3








SELECT E1.LAST_NAME, E1.SALARY
FROM EMPLOYEES E1 
WHERE E1.SALARY > ANY ( SELECT E2.SALARY FROM EMPLOYEES E2
												WHERE (SELECT DEPARTMENT_NAME FROM DEPARTMENTS WHERE DEPARTMENT_ID= E2.		 
												DEPARTMENT_ID) =  'Sales' )





SELECT EMPLOYEES.FIRST_NAME
FROM EMPLOYEES









CREATE TABLE TT1 (
	NAME VARCHAR2(100) ,	
	SALARY NUMBER,
	CONSTRAINT CC1 PRIMARY KEY(NAME)
	)
	
	
	CREATE TABLE TT2 (	
	EMPLOYEE_ID VARCHAR2(100)	,
	SALARY NUMBER,
	CONSTRAINT CC2 PRIMARY KEY(EMPLOYEE_ID)
	)
	
		CREATE TABLE TEMP (    
    ID VARCHAR2(1000),
		TITLE VARCHAR2(1000),    
    CONSTRAINT FK_TITLE FOREIGN KEY (TITLE) REFERENCES TT1(NAME),
    CONSTRAINT FK_ID1 FOREIGN KEY (ID) REFERENCES TT2(EMPLOYEE_ID) ON DELETE SET NULL ,
		CONSTRAINT FK_ID2 FOREIGN KEY (ID) REFERENCES TT2(EMPLOYEE_ID) ON UPDATE CASCADE,

		CONSTRAINT CC6 PRIMARY KEY(ID)
);

DROP TABLE TEMP
	

	
CREATE TABLE TT (
	NAME VARCHAR2(100) ,	
	SALARY NUMBER  CHECK( TT.SALARY NOT IN ( SELECT SALARY FROM TT) ),
	CONSTRAINT CC1 PRIMARY KEY(NAME)
	
	)
	
	
	
	DROP TABLE TT

INSERT INTO TT VALUES( '1','A',100);

CREATE TABLE TEMP (
    ID VARCHAR2(100),
    TITLE VARCHAR2(100),
    CONSTRAINT CC6 PRIMARY KEY(ID),
    CONSTRAINT FK_TITLE FOREIGN KEY (TITLE) REFERENCES TT(NAME),
    CONSTRAINT FK_ID FOREIGN KEY (ID) REFERENCES TT(EMPLOYEE_ID)
);




















CREATE TABLE TT AS
	SELECT *
	FROM EMPLOYEES
	
	DROP TABLE TT
	
	
	
	
	
	
UPDATE TT 
SET SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES E1 WHERE E1.DEPARTMENT_ID = TT.DEPARTMENT_ID);




DELETE FROM LOCATIONS
WHERE LOCATION_ID IN (
	SELECT LOCATION_ID FROM LOCATIONS
	MINUS
	SELECT LOCATION_ID FROM DEPARTMENTS )




UPDATE TT 
SET COMMISSION_PCT =  COMMISSION_PCT*( SELECT COUNT(*) FROM EMPLOYEES WHERE MANAGER_ID =  TT.EMPLOYEE_ID )
WHERE COMMISSION_PCT IS NOT NULL AND ( SELECT COUNT(*) FROM EMPLOYEES WHERE MANAGER_ID =  TT.EMPLOYEE_ID ) <> 0



UPDATE TT 
SET COMMISSION_PCT = COMMISSION_PCT * (
    SELECT COUNT(*) 
    FROM EMPLOYEES 
    WHERE MANAGER_ID = TT.EMPLOYEE_ID
)
WHERE EXISTS (
    SELECT 1 
    FROM EMPLOYEES 
    WHERE MANAGER_ID = TT.EMPLOYEE_ID
);

ALTER TABLE TT MODIFY COMMISSION_PCT FLOAT;



UPDATE TT 
SET HIRE_DATE = TRUNC(HIRE_DATE, 'YEAR')
WHERE TO_CHAR(HIRE_DATE, 'YYYY') >=2000










SELECT DEPARTMENT_ID, (SELECT DEPARTMENT_NAME FROM DEPARTMENTS WHERE DEPARTMENT_ID = E1.DEPARTMENT_ID) 
FROM EMPLOYEES E1
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > ALL ( 
		SELECT MIN(SALARY)
			FROM EMPLOYEES E2
				WHERE E2.DEPARTMENT_ID<>E1.DEPARTMENT_ID
				GROUP BY DEPARTMENT_ID
				)







SELECT *
FROM EMPLOYEES E1,  ( SELECT DEPARTMENT_ID, MIN(SALARY), MAX(SALARY)
			FROM EMPLOYEES
			GROUP BY DEPARTMENT_ID
) E2
WHERE E1.DEPARTMENT_ID =  E2.DEPARTMENT_ID






SELECT DEPARTMENT_ID
FROM EMPLOYEES





SELECT E1.LAST_NAME, COUNT(*) AS "TOTAL MANAGED EMPLOYEES"
FROM EMPLOYEES E1 JOIN  E2
ON E1.EMPLOYEE_ID= E2.MANAGER_ID
GROUP BY E1.EMPLOYEE_ID, E1.LAST_NAME
ORDER BY "TOTAL MANAGED EMPLOYEES" ASC;






SELECT DEPARTMENT_ID, JOB_ID, MIN(HIRE_DATE) AS "FIRST HIRING DATE",
MAX(HIRE_DATE) AS "LAST HIRING DATE", AVG(SALARY)
FROM EMPLOYEES E1 
WHERE DEPARTMENT_ID IS NOT NULL AND JOB_ID IS NOT NULL
GROUP BY DEPARTMENT_ID , JOB_ID
HAVING AVG(SALARY) > 3000








CREATE TABLE TEMP( 
	
		ID NUMBER,
		TITLE VARCHAR2(1000),
		SALARY NUMBER CHECK( 		
			1 =( SELECT COUNT(*)
					FROM TEMP T2 
					WHERE T2.SALARY= TEMP.SALARY
						)					
		 ),
		CONSTRAINT IDPK PRIMARY KEY(ID)

)



INSERT INTO TEMP VALUES(1,'AS',77);

INSERT INTO TEMP VALUES(2,'AS',-77);

INSERT INTO TEMP VALUES(3,'AS',77);


DROP TABLE TEMP ;





ALTER TABLE TT DROP COLUMN MANAGER_ID





CREATE TABLE TEMP( 
    ID NUMBER,
    TITLE VARCHAR2(1000),
    SALARY NUMBER,
    CONSTRAINT IDPK PRIMARY KEY(ID),
    CONSTRAINT UNIQUE_SALARY UNIQUE(SALARY)
);




UPDATE TT
SET COMMISSION_PCT =  (
 CASE 
	WHEN COMMISSION_PCT IS NOT NULL THEN 5
	ELSE 0	
END
)


INSERT INTO TEMP (EMPLOYEE_ID) 
SELECT (EMPLOYEE_ID*100)
FROM EMPLOYEES





CREATE TABLE TEMP AS
SELECT EMPLOYEE_ID
FROM EMPLOYEES


SELECT *
FROM ( SELECT *	FROM EMPLOYEES	WHERE EMPLOYEE_ID BETWEEN 200 and 202 ) A
JOIN ( SELECT * FROM DEPARTMENTS WHERE DEPARTMENT_ID IN (10,12)  )  B
ON A.DEPARTMENT_ID  =  B.DEPARTMENT_ID
 













