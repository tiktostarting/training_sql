select count(*) from tickers
/

insert into tickers 
    select * 
        from table (doubled_pl (cursor (select * from stocks)))
/

select * from tickers 
/