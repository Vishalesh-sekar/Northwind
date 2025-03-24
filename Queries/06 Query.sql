/*
The Pricing Team wants to know how each category performs according to their price range. 
In order to help them they asked you to provide them a list of categories with:

	1.their category name
	2.their price range as:
		1.Below $20
		2.$20 - $50
		3.Over $50
	3.their total amount (formatted to be integer)
	4.their number of orders

Finally order the results by category name then price range (both ascending order).
*/

--Solution Query
select
    c.CategoryName,
    case
        when p.UnitPrice < 20 then '1. Below $20'
        when p.UnitPrice >= 20 and p.UnitPrice <= 50 then '2. $20 - $50'
        when p.UnitPrice > 50 then '3. Over $50'
    end as priceRange,
    round(sum(d.UnitPrice * d.Quantity),0) as total_amount,
    count(distinct d.OrderID) as total_number_orders
from
    Categories as c
inner join
    Products as p on c.CategoryID = p.CategoryID
inner join
    [Order Details] as d on d.ProductID = p.ProductID
group by
    c.CategoryName,
    case
        when p.UnitPrice < 20 then '1. Below $20'
        when p.UnitPrice >= 20 and p.UnitPrice <= 50 then '2. $20 - $50'
        when p.UnitPrice > 50 then '3. Over $50'
    end
order by
    c.CategoryName,
    priceRange;