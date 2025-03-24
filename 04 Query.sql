/*
Question 4

The Logistics Team wants to do a retrospection of their global performances over 1997-1998, 
in order to identify for which month they perform well. They asked you to provide them a list with:

	1. their year/month as single field in a date format (e.g. “1996-01-01” January 1996)
	2. their total number of orders
	3. their total freight (formatted to have no decimals)
	4. Filtered on the following conditions:

the order date is between 1997 and 1998
their total number of orders is greater than 35 orders

Finally order the results by total freight (descending order).
*/

--Solution Query

with cte_freight as (
	select
		CAST(year(OrderDate) as varchar) + '-' +
		CAST(month(OrderDate) as varchar) + '-01' as year_month,
		COUNT(*) as total_number_orders,
		ROUND(sum(Freight),0) as total_frieght
	from Orders
	where OrderDate >= '1997-01-01' and OrderDate < '1998-01-31'
	group by
		CAST(year(OrderDate) as varchar) + '-' +
		CAST(month(OrderDate) as varchar) + '-01'
)
select *
from cte_freight
where total_number_orders>35
order by total_frieght desc;
