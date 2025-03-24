/*
Question 5

The Pricing Team wants to know which products had an unit price increase and the percentage increase was not between 20% and 30%. 
In order to help them they asked you to provide them a list of products with:
	1. their product name
	2. their current unit price (formatted to have only 2 decimals)
	3. their previous unit price (formatted to have only 2 decimals)
	4. their percentage increase as:
			(New Number - Original Number) ÷ Original Number × 100 (with the result formatted to an integer, e.g 50 for 50%)

Filtered on the following conditions:
	1. their percentage increase is not between 20% and 30%
	2. their total number of orders is greater than 10 orders
	3. Finally order the results by percentage increase (ascending order).
*/

--Solution Query
with cte_price as (
    select
        d.ProductID,
        p.ProductName,
        round(lead(d.UnitPrice) over (partition by p.productName order by o.orderDate), 2) as currentPrice,
        round(lag(d.UnitPrice) over (partition by p.productName order by o.orderDate), 2) as previousUnitPrice
    from
        Products as p
    inner join
        [Order Details] as d on p.ProductID = d.ProductID
    inner join
        Orders as o on d.OrderID = o.OrderID
)
select
    c.ProductName,
    c.currentPrice,
    c.previousUnitPrice,
    round(100.0 * (c.currentPrice - c.previousUnitPrice) / c.previousUnitPrice, 0) as percentage_increase
from
    cte_price as c
inner join
    [Order Details] as d on c.productID = d.ProductID
where
    c.currentPrice <> c.previousUnitPrice
group by
    c.ProductName,
    c.currentPrice,
    c.previousUnitPrice
having
    count(distinct d.OrderID) > 10
    and round(100.0 * (c.currentPrice - c.previousUnitPrice) / c.previousUnitPrice, 0) not between 20 and 30;