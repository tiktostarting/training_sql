drop type ticker_ot;
/
drop type tickers_nt;
/

create type ticker_ot authid definer is object
(
    ticker varchar2(20),
    pricedate date,
    pricetype varchar2(1),
    price number
);
/

create or replace type tickers_nt as table of ticker_ot;
/

create or replace package stock_mgr
    authid definer
is
    type stocks_rc is ref cursor return stocks%rowtype;
end stock_mgr;
/
