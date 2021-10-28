declare 
    p   varchar2(30);
    n   pls_integer := 37;
begin
    for j in 2 .. round(sqrt(n))
        loop
            if n mod j = 0 then
                p := ' is not a prime number';
                goto print_now;
            end if;
        end loop;
    p := ' is a prime number';

    <<print_now>>
    dbms_output.put_line(to_char(n) || p);
end;
/