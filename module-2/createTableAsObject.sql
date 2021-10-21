/*
    because when use 
    create type animals_nt is table of animals%rowtype especially
    %rowtype feature isn't available in PL/SQL
    is illegal, i cant build type of animals_nt from field of animal
    so i create an object.
*/

create type animal_ot is object
(
    name varchar2 (10),
    species varchar2 (20),
    date_of_birth date
);
/

create type animals_nt is table of animal_ot;
/

create or replace function animal_family(dad_in in animal_ot, mom_in in animal_ot)
    return animals_nt
    authid definer
is
    l_family    animals_nt := animals_nt(dad_in, mom_in);
begin
    for indx in 1 ..
        case mom_in.species
            when 'RABBIT' then 12
            when 'DOG' then 4
            when 'KANGAROO' then 1
        end
    loop
        l_family.extend;
        l_family(l_family.last) :=
            animal_ot ('BABY' || indx,
                mom_in.species,
                ADD_MONTHS(SYSDATE, -1 * dbms_random.value(1, 6)));
    end loop;

    return l_family;
end;
/

select name, species, date_of_birth
    from table (
        animal_family (animal_ot('Happy', 'RABBIT', SYSDATE - 500),
        animal_ot('Hippy', 'RABBIT', SYSDATE - 300)))
/

insert into animals
select name, species, date_of_birth
    from table (
        animal_family (animal_ot('Happy', 'RABBIT', SYSDATE - 500),
        animal_ot('Hippy', 'RABBIT', SYSDATE - 300)))
/

select * from animals;
/

insert into animals
select name, species, date_of_birth
    from table (
        animal_family (animal_ot('Bob', 'KANGAROO', SYSDATE - 500),
            animal_ot('Sally', 'KANGAROO', SYSDATE -300)))
/

select * from animals where species = 'KANGAROO';
/

delete from animals;
/
