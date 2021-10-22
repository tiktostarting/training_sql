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

create or replace function singled (tickers_in in stock_mgr.ticker_rc)
    return stocks_nt authid definer
is
    type tickers_aat is table of tickers%ROWTYPE index by pls_integer;
    l_tickers       tickers_aat;

    l_singles       stocks_nt := stocks_nt ();
begin 
    loop 
        fetch tickers_in bulk collect into l_tickers limit 100;
        exit when l_tickers.count = 0;

        for indx in 1 .. l_tickers.count
        loop
            l_singles.extend;
            l_singles (l_singles.last) :=
                stock_ot (l_tickers (indx).ticker,
                    l_tickers (indx).pricedate,
                    l_tickers (indx).price,
                    l_tickers (indx).price * .5);
        end loop;
    end loop;

    return l_singles;
end;
/

create table more_stocks
as 
    select * 
        from table (
            singled (
                cursor (
                    select *
                        from table (doubled (
                            cursor (select * from stocks))))))
/