--preventing overflow integer

set serveroutput on;

declare 
    p1  pls_integer := 2147483648;
    p2  integer := 1;
    n   number;
begin
    n := p1 + p2;
    dbms_output.put_line('Percobaan overflow int: ' || n);
end;
/

