drop type stocks;
/

create table stocks
(
    ticker          varchar (20),
    trade_date      date,
    open_price      number,
    close_price     number
);
/

insert into stocks
    select 'STK' || LEVEL,
        SYSDATE,
        level,
        level + 15
    from dual
    connect by level <= 200000
/
