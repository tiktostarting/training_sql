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