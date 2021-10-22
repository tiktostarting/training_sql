create or replace type strings_t is table of varchar2(100);
/

create or replace function strings
    return strings_t pipelined
    authid definer
is
begin 
    pipe row ('abc');
    return;
end;
/

select column_value my_string from table (strings());
/

-- for 12.2 and higher, no need for for TABLE

select column_value my_string from strings();
/

