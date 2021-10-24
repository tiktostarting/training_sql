DECLARE 
	a NUMBER;
	b NUMBER;
	c NUMBER;
PROCEDURE findMin(x IN NUMBER, y IN NUMBER, z OUT NUMBER) IS
BEGIN
	IF x < y THEN
		z := x;
	ELSE
		z := y;
	END IF;
END;
BEGIN
	a := 23;
	b := 45;
	findMin(a, b, c);
	dbms_output.put_line(' Minimum of ('|| a ||', ' || b || ') : ' || c);
END;
/