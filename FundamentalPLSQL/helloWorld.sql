DECLARE 
	-- variable declaration
	message		varchar2(20) := 'Hello, World!';
BEGIN 
	/*
	 * 
	 * PL/SQL executable statement
	 * 
	 */
	dbms_output.put_line(message);
END;
/