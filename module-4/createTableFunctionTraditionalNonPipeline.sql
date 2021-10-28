create or replace function doubled_nopl (rows_in stock_mgr.stocks_rc) 
    return tickers_nt
is
    type stocks_aat is table of stocks%rowtype index by pls_integer;
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
            l_doubled (l_doubled.last) :=
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