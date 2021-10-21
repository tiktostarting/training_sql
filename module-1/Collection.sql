CREATE OR REPLACE TYPE list_of_names_t IS TABLE OF VARCHAR2(100);
/

set SERVEROUTPUT on;
DECLARE
    happyFamily     list_of_names_t := list_of_names_t();
    children        list_of_names_t := list_of_names_t();
    grandChildren   list_of_names_t := list_of_names_t();
    parents         list_of_names_t := list_of_names_t();
BEGIN
    happyFamily.EXTEND(7);
    happyFamily(1) := 'Veva';
    happyFamily(2) := 'Chris';
    happyFamily(3) := 'Lauren';
    happyFamily(4) := 'Loey';
    happyFamily(5) := 'Juna';
    happyFamily(6) := 'Eli';
    happyFamily(7) := 'Steven';
    
    children.EXTEND;
    children(children.LAST) := 'Chris';
    children.EXTEND;
    children(children.last) := 'Eli';
    children.EXTEND;
    children(children.last) := 'Lauren';
    
    grandChildren.EXTEND;
    grandChildren(grandChildren.last) := 'Loey';
    grandChildren.EXTEND;
    grandChildren(grandChildren.last) := 'Juna';
    
    parents := (happyFamily Multiset except children) multiset except grandChildren;
    
    DBMS_OUTPUT.put_line('Grandparents');
    
    for l_row in 1.. parents.count
    loop
        dbms_output.put_line(parents(l_row));
    end loop;
    
    happyFamily.delete;
    DBMS_OUTPUT.put_line ('Size of happy family: ' || happyFamily.COUNT);
    DBMS_OUTPUT.put_line('Exit');
end;
/

