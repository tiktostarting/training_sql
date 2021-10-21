create table employees (
    empno       number,
    name        varchar2(50) not null,
    constraint pk_employees primary key(empno)
);

insert all 
    into employees (empno, name) values(2, 'Omar')
    into employees (empno, name) values(3, 'Donald')
    into employees (empno, name) values(4, 'Nandha')
    into employees (empno, name) values(5, 'Mika')
    into employees (empno, name) values(6, 'Jordi')
    into employees (empno, name) values(7, 'Imran')
    into employees (empno, name) values(8, 'Joe')
    into employees (empno, name) values(9, 'Hadid')
    into employees (empno, name) values(10, 'Bashir')
    into employees (empno, name) values(11, 'Eli')
    select * from dual;
/


create or REPLACE TYPE strings_t is table of varchar2(100);
/

create or REPLACE function random_strings (count_in in integer)
    return strings_t
    authid definer
is
    l_strings strings_t := strings_t ();
BEGIN
    l_strings.extend (count_in);

    for indx in 1 .. count_in
    LOOP
        l_strings (indx) := DBMS_RANDOM.string('u', 10);
    END LOOP;

    return l_strings;
END;
/

declare 
    l_strings strings_t := random_strings(5);
BEGIN
    for indx in 1 .. l_strings.count
    loop
        DBMS_OUTPUT.put_line (l_strings(indx));
    end loop;
end;
/

/*
    start here
*/

select COLUMN_VALUE my_string from table (random_strings(5))
/

select 'Random = ' || COLUMN_VALUE my_string from table (random_strings(5))
/

select e.name
    from table(random_strings(3)) rs, employees e
    where length (e.name) <= length(COLUMN_VALUE)
/

select e.name
    from employees e
    where rownum < 4
    union all
    select rs.COLUMN_VALUE
    from table(random_strings(3)) rs
/

begin 
    for rec in (select COLUMN_VALUE my_string from table(random_strings(5)))
    loop
        DBMS_OUTPUT.put_line(rec.my_string);
    end loop;
end;
/
