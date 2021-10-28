set serveroutput on;

declare
    starting_time   timestamp with time zone;
    ending_time     timestamp with time zone;
    
begin
    select systimestamp into starting_time from dual;
    
    for item in (
        select distinct(sqrt(id)) col_alias
        from customers
        order by col_alias
    )
    loop 
        dbms_output.put_line('Square root of cust. ID = ' || item.col_alias);
    end loop;
    
    select systimestamp into ending_time from dual;
    
    dbms_output.put_line('Time = '|| to_char(ending_time - starting_time));
    
    select systimestamp into starting_time from dual;
    
    for item in (
        select sqrt(id) col_alias
        from (select distinct id from customers)
        order by col_alias
    )
    
    loop
        if item.col_alias is not null then 
            dbms_output.put_line('Square root of cust.id' || item.col_alias);
        end if;
    end loop;
    
    select systimestamp into ending_time from dual;
    
    dbms_output.put_line('Time = ' || to_char(ending_time - starting_time));
end;
/