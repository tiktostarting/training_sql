create or replace package utils
is 
    procedure initialize (context_in in varchar2);

    procedure show_results (message_in in varchar2 := null);
end;
/

create or replace package body utils
is
    last_timing integer := NULL;
    last_pga integer := NULL;
    
    function pga_consumed
        return number
    as
        l_pga number;
    begin
        select st.value
        into l_pga
        from v$mystat st, v$statname sn
        where st.statistic# = sn.statistic# and sn.name = 'session pga memory';

        return l_pga;
    end;

    procedure initialize (context_in in varchar2)
    is
    begin
        delete from tickers;
        commit;
        dbms_output.put_line(context_in);
        last_timing := dbms_utility.get_time;
        last_pga := pga_consumed;
    end;

    procedure show_results (message_in in varchar2 := null)
    is
        l_count integer;
    begin
        select count (*) into l_count from tickers;

        dbms_output.put_line ('Ticker row count: ' || l_count);

        dbms_output.put_line(
            '"' || message_in || '" completed in: ' ||
            to_char (dbms_utility.get_time - last_timing)||' pga at: '||
            to_char (pga_consumed() - last_pga));
    end;
end;
/

begin
    utils.initialize('Pipelined');
    
    insert into tickers
        select *
            from table (doubled_pl (cursor (select * from stocks)))
        where rownum < 10;
        
    utils.show_results ('First 9 rows');
    
    utils.initialize ('Not Pipelined');
    
    insert into tickers
        select *
            from table (double_nopl (cursor (select * from stocks)))
        where rownum < 10;
        
    utils.show_results ('First 9 rows');
end;
/
