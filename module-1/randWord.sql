create or REPLACE package tf
    authid definer
is 
    function random_strings (count_in in integer)
        return strings_t;

    function just_number
        return number;
end;
/

create or replace package body tf
is
    function random_strings (count_in in integer)
        return strings_t
    is
        l_strings strings_t := strings_t();
    BEGIN
        l_strings.extend(count_in);

        for indx in 1 .. count_in
        loop
            l_strings (indx) := DBMS_RANDOM.string('u', 10);
        end loop;

        return l_strings;
    end;

    function just_number
        return number
    is
    BEGIN
        return 1;
    end;
end;
/

create or replace type string_t is table of varchar2(100);
/

create or replace function random_strings(count_in in integer)
    return strings_t
    authid definer
is
    l_strings strings_t := strings_t();
BEGIN
    l_strings.extend(count_in);

    for indx in 1 .. count_in
    loop
        l_strings(indx) := DBMS_RANDOM.string('u', 10);
    end loop;

    return l_strings;
end;
/    

select tf.just_number from dual
/

select COLUMN_VALUE my_string from table (tf.random_strings(5))
/