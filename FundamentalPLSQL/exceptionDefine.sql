declare 
    sample_exception exception;

procedure nested_block
    is
    begin
        dbms_output.put_line('Inside nested block');
        dbms_output.put_line('raising sample_exception from nested block');
        raise sample_exception;
        exception
        when sample_exception then
            dbms_output.put_line('exception capture in nested block. raising to main block');
        raise;
    end;

begin
    dbms_output.put_line('Inside main block');
    dbms_output.put_line('Calling nested block');
    nested_block;
    exception
    when sample_exception then 
        dbms_output.put_line('Exception caputerd in main block');
end;
/
