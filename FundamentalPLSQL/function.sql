declare
    num number;
    factorial number;

function fact(x number)
    return number
    is
        f number;
    begin
        if x = 0 then
            f := 1;
        else
            f := 1;
        end if;
        return f;
    end;

begin 
    num := 999;
    factorial := fact(num);
    dbms_output.put_line(' factorial ' || num || ' is ' || factorial);
end;
/

