set serveroutput on;
/

CREATE TABLE customers(
	id		int NOT NULL,
	name	varchar(20) NOT NULL,
	age		int NOT NULL,
	address	char(25),
	salary	decimal(18, 2),
	PRIMARY KEY (id)
);
/

INSERT INTO customers (id, name, age, address, salary)
VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 );
/

INSERT ALL 
	INTO customers (id, name, age, address, salary) VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 ) 
	INTO customers (id, name, age, address, salary) VALUES (3, 'kaushik', 23, 'Kota', 2000.00 )
	INTO customers (id, name, age, address, salary) VALUES (4, 'Chaitali', 25, 'Mumbai', 6500.00 )
	INTO customers (id, name, age, address, salary) VALUES (5, 'Hardik', 27, 'Bhopal', 8500.00 )
	INTO customers (id, name, age, address, salary) VALUES (6, 'Komal', 22, 'MP', 4500.00 )
SELECT * FROM dual;
/

declare
    c_id    customers.id%type := 8;
    c_name  customerS.Name%type;
    c_addr  customers.address%type;
begin
    select name, address into c_name, c_addr
    from customers
    where id = c_id;
    dbms_output.put_line('Name: '|| c_name);
    dbms_output.put_line('Address: '|| c_addr);

exception
    when no_data_found then
        dbms_output.put_line('No such customer!');
    when others then
        dbms_output.put_line('Error!');
end;
/

declare
    c_id            customers.id%type := &cc_id;
    c_name          customerS.name%type;
    c_addr          customers.address%type;
    -- user defined exception
    ex_invalid_id   exception;

begin
    if c_id <= 0 then
        raise ex_invalid_id;
    else
        select name, address into c_name, c_addr
        from customers
        where id = c_id;
        dbms_output.put_line ('Name: '|| c_name);
        dbms_output.put_line ('address:'|| c_addr);
    end if;

exception
    when ex_invalid_id then
        dbms_output.put_line('ID must greater than zero!');
    when no_data_found then
        dbms_output.put_line('No such customer!');
    when others then
        dbms_output.put_line('Error!');
end;
/