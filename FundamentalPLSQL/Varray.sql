set serveroutput on;

declare 
	type namesarray is array(5) of varchar2(10);
	type grades is varray(5) of integer;
	names namesarray;
	marks grades;
	total integer;
	
BEGIN
	names := namesarray('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz');
	marks := grades(98, 97, 78, 87, 92);
	total := names.count;
	dbms_output.put_line('Total '|| total || ' Students');
	for i in 1 .. total LOOP
		dbms_output.put_line('Student: ' || names(i) || ' Marks: ' || marks(i));
	end loop;
end;
/