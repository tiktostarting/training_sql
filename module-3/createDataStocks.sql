create table stocks
(
    ticker          varchar2(20),
    trade_date      date,
    open_price      number,
    close_price     number
)
/

begin
    for indx in 1 .. 1000
    loop
        --might as well be optimistic!
        insert into stocks
            values ('STK' || indx,
                    SYSDATE,
                    indx,
                    indx + 15);
    end loop;
    commit;
end;
/
