/*
Question 7

The Logistics Team wants to know what is the current state of our regional suppliers' stocks for each category of product. 
In order to help them they asked you to provide them a list of categories with:
	1.their supplier region” as:
		“America”
		“Europe”
		“Asia-Pacific”
	2.their category name
	3.their total units in stock
	4.their total units on order
	5.their total reorder level
Finally order the results by supplier region then category name then price range (each in ascending order).
*/

--Solution Query
select
    c.CategoryName,
    case
        when s.country IN ('Australia', 'Singapore', 'Japan') then 'Asia-Pacific'
        when s.country IN ('US', 'Brazil', 'Canada') then 'America'
        else 'Europe'
    end as supplier_region,
    p.UnitsInStock,
    p.UnitsOnOrder,
    p.ReorderLevel
from
    Suppliers as s
inner join
    Products as p on s.SupplierID = p.SupplierID
inner join
    Categories as c on p.CategoryID = c.CategoryID
where
    s.region is not null
order by
    supplier_region,
    c.CategoryName,
    p.UnitPrice;