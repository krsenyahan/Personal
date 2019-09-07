if OBJECT_ID('tempdb..#KS_fctsale_explore') is not null
drop table #KS_fctsale_explore

select top 10 *
into #KS_fctsale_explore
from deardb.dear.fct_sale

select * from #KS_fctsale_explore

--Findings:
-- Table of Origin: 
--      1) deardb.dear.hub_sale_list (SaleList_ID or Customer_ID + OrderNumber)
--              Filter applied: exlcuded records without InvoiceDate
--              Observations: SaleList_ID may not be always the same between that 
--                            deardb.dear.hub_sale_list and deardb.dear.fct_sale that is why
--							  it is better to use Customer_ID + OrderNumber combination

--HBR: Saleslist_ID for deardb.dear.fct_sale and deardb.dear.hub_sale_list are the same
--Findings: No. There are Salelist_ID in dear.fct_sale that is not similar to dear.hub_sale_list
--          That is why, Customer_ID+OrderNumber may be the best way to tie the two tables perfectly
select top 10 a.*, b.SaleList_ID
from #KS_fctsale_explore			a
left join deardb.dear.hub_sale_list b on     a.Customer_ID = b.Customer_ID       
                                         and a.OrderNumber = b.OrderNumber
order by a.SaleList_ID

--HBR: The count of records of deardb.dear.fct_sale is the same deardb.dear.hub_sale_list after excluding InvoiceDates that are NULL
--Findings: No. dear.fct_sale is bigger in size than dear.hub_sale_list
--			This is surprising because I thought dear.fct_sale originates from deardb.dear.hub_sale_list
select count(*)						--31752
from deardb.dear.hub_sale_list
where InvoiceDate is not NULL

select count(*)						--47527
from deardb.dear.fct_sale

select top 10 *
from deardb.dear.fct_sale
where SaleList_ID = 2

select top 10 *
from deardb.dear.hub_sale_list
where InvoiceNumber = 'INV-21949'


select top 10 *
from deardb.dear.hub_sale_invoice
where InvoiceNumber = 'INV-21949'
