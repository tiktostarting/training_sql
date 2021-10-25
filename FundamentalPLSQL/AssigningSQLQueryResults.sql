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

DECLARE 
	c_id	customers.id%TYPE	:= 1;
	c_name	customers.name%TYPE;
	c_addr	customers.address%TYPE;
	c_sal	customers.salary%TYPE;
BEGIN
	SELECT name, address,salary INTO c_name, c_addr, c_sal
	FROM customers
	WHERE id = c_id;
	dbms_output.put_line
	('customer' ||c_name || ' from ' || c_addr || ' earns ' || c_sal);
END;
/