DECLARE 
	a NUMBER;
PROCEDURE squareNum(x IN OUT number) IS
BEGIN
	x := x * x;
END;
BEGIN
	a := 23;
	squareNum(a);
	dbms_output.put_line(' Square of ('|| a ||'): ' || a);
END;
/