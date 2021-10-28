select count(*) from tickers;
/

insert into tickers 
    select * 
        from table (doubled_pl (cursor (select * from stocks)));
/

insert into tickers
    select *
        from table (doubled_nopl (cursor (select * from stocks)));
/

delete from tickers;
/

select * from tickers;
/