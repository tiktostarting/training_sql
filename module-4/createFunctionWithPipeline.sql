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
        exit 