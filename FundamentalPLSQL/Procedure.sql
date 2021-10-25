CREATE OR REPLACE PROCEDURE greeting
AS 
BEGIN 
	dbms_output.put_line('Hello World!');
END;
/

BEGIN
	greeting;
END;
/