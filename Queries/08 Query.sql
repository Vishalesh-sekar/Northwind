/*
Question 8

The Pricing Team wants to know for each currently offered product how their unit price compares against their categories average and median unit price. 
In order to help them they asked you to provide them a list of products with:

	1.their category name
	2.their product name
	3.their unit price
	4.their category average unit price (formatted to have only 2 decimals)
	5.their category median unit price (formatted to have only 2 decimals)
	6.their position against the category average unit price as:
		“Below Average”
		“Equal Average”
		“Over Average”
	7.their position against the category median unit price as:
		“Below Median”
		“Equal Median”
		“Over Median”
Filtered on the following conditions:
	They are not discontinued
Finally order the results by category name then product name (both ascending).
*/

--Solution Query
with cte_price as (
    select
        c.CategoryName,
        p.ProductName,
        p.UnitPrice,
        round(avg(d.UnitPrice), 2) as average_unit_price,
		(
			select
                round(avg(1.0 * UnitPrice), 2)
            from( select UnitPrice, row_number() over (order by UnitPrice) as row_num, count(*) over () as total_rows
				from [Order Details] where ProductID = ProductID ) as subquery
            where
                row_num in (floor((total_rows + 1) / 2.0), floor((total_rows + 2) / 2.0))
        ) as median_unit_price from Categories as c
    inner join
        Products as p on c.CategoryID = p.CategoryID
    inner join
        [Order Details] as d on p.ProductID = d.ProductID
    where
        p.discontinued = 0
    group by
        c.CategoryName,
        p.ProductName,
        p.UnitPrice
)
select
    CategoryName,
    ProductName,
    UnitPrice,
    average_unit_price,
    median_unit_price,
    case
        when UnitPrice > average_unit_price then 'Over Average'
        when UnitPrice = average_unit_price then 'Equal Average'
        when UnitPrice < average_unit_price then 'Below Average'
    end AS average_unit_price_position,
    case
        when UnitPrice > median_unit_price then 'Over Average'
        when UnitPrice = median_unit_price then 'Equal Average'
        when UnitPrice < median_unit_price then 'Below Average'
    end as median_unit_price_position
from
    cte_price
order by
    CategoryName,
    ProductName;