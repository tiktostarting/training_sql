create or replace type animal_ot is object
(
    name varchar2(10),
    species varchar2(20),
    date_of_birth date
);
/

create or replace type animals_nt is varray(25) of animal_ot;
/

insert into animals
select name, species, date_of_birth
    from table (
        animal_family(animal_ot('Hubbert', 'RABBIT', SYSDATE - 500),
            animal_ot('Hanna', 'RABBIT', SYSDATE - 300)))
/

select * from animals;
/