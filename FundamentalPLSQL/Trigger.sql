select * from customers;
/

create or replace trigger display_salary_changes
before delete or insert or update on customers
for each row
when (new.id > 0)
declare
    sal_diff number;
begin
    sal_diff := :new.salary - :old.salary;
    dbms_output.put_line('Old salary: ' || :old.salary);
    dbms_output.put_line('New salary: ' || :new.salary);
    dbms_output.put_line('Salary difference: ' || sal_diff);
end;
/

insert into customers (id, name, age, address, salary)
values (7, 'kritti', 22, 'HP', 7500.00);
/

update customers
set salary = salary + 500
where id = 2;
/

accept lastname char format 'A20' prompt 'enter employee lastname: '
set serveroutput on;

begin
    dbms_output.put_line('&lastname');
end;
/