DECLARE
-- initializing variable in pl/sql
	a	integer	:=	10;
	b	integer	:=	20;
-- variable declaration
	c	integer;
	f	REAL;
BEGIN
	c := a + b;
	dbms_output.put_line('Value of c: ' || c);
	f := 70.0 / 3.0;
	dbms_output.put_line('Value of f: ' || f);
END;
/
