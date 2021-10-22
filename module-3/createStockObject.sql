create or replace type stock_ot authid definer is object
(
    ticker varchar2 (20),
    trade_date date,
    open_price number,
    close_price number
)
/

create or replace type stocks_nt as table of stock_ot;
/