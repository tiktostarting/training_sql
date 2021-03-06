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

create type ticker_ot authid definer is object
(
    ticker      varchar2(20),
    pricedate   date,
    pricetype   varchar2(1),
    price       number
);
/

create type tickers_nt as table of ticker_ot;
/

create or replace package stock_mgr
    authid definer
is 
    type stocks_rc is ref cursor return stocks%ROWTYPE;

    type ticker_rc is ref cursor return tickers%ROWTYPE;
end stock_mgr;
/

create or replace function doubled (rows_in stock_mgr.stocks_rc)
    return tickers_nt authid definer 
is 
    type stocks_aat is table of stocks%ROWTYPE index by pls_integer;
    l_stocks    stocks_aat;

    l_doubled   tickers_nt := tickers_nt ();
begin
    loop
        fetch rows_in bulk collect into l_stocks limit 100;
        exit when l_stocks.count = 0;

        for l_row in 1 .. l_stocks.count
        loop
            l_doubled.extend;
            l_doubled (l_doubled.last) :=
                ticker_ot (l_stocks (l_row).ticker,
                    l_stocks (l_row).trade_date,
                    '0',
                    l_stocks (l_row).open_price);

            l_doubled.extend;
            l_doubled (l.doubled.last) :=
                ticker_ot (l_stocks (l_row).ticker,
                    l_stocks (l_row).trade_date,
                    'C',
                    l_stocks (l_row).close_price);
        end loop;
    end loop;
    close rows_in;
    return l_doubled;
end;
/

insert into tickers 
    select * 
        from table (doubled (cursor (select * from stocks)))
/

select count (*) from tickers
/

select *
    from tickers
        fetch first 10 rows only
/