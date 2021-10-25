create or replace function doubled_pl (rows_in stock_mgr.stocks_rc)
    return tickers_nt
    pipelined
    authid definer
is
    type stocks_aat is table of stocks%rowtype index by pls_integer;
    l_stocks    stocks_aat;
begin
    loop
        fetch rows_in bulk collect into l_stocks limit 100;
        exit when l_stocks.count = 0;

        for l_row in 1 .. l_stocks.count
        loop
            pipe row (ticker_ot(l_stocks (l_row).ticker,
                l_stocks (l_row).trade_date,
                '0',
                l_stocks (l_row).open_price));

            pipe row (ticker_ot(l_stocks (l_row).ticker,
                l_stocks (l_row).trade_date,
                'C',
                l_stocks (l_row).close_price));
        end loop;
    end loop;

    close rows_in;

    return;
end;
/