create or replace type strings_t is table of varchar2 (100);
/

create or replace function random_strings (count_in in integer)
    return strings_t
    authid definer
is
    l_strings   strings_t := strings_t();
begin
    l_strings.extend (count_in);

    for indx in 1 .. count_in
    loop
        l_strings(indx) := dbms_random.string('u', 10);
    end loop;

    return l_strings;
end;
/

select column_value my_string from table(random_strings(5))
/