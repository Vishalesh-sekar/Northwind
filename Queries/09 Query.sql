/*
Question 9
The Sales Team wants to build a list of KPIs to measure employees' performances. 
In order to help them they asked you to provide them a list of employees with:

	1.their full name (first name and last name combined in a single field)
	2.their job title
	3.their total sales amount excluding discount (formatted to have only 2 decimals)
	4.their total number of orders
	5.their total number of entries (each row of an order)
	6.their average amount per entry (formatted to have only 2 decimals)
	7.their average amount per order (formatted to have only 2 decimals)
	8.their total discount amount (formatted to have only 2 decimals)
	9.their total sales amount including discount (formatted to have only 2 decimals)
	10.Their total discount percentage (formatted to have only 2 decimals)
Finally order the results by total sales amount including discount (descending).
*/

--Solution Query
with cte_kpi as (
    select
        e.FirstName + ' ' + e.LastName as employee_full_name,
        e.Title as employee_title,
        round(sum(d.Quantity * d.UnitPrice), 2) as total_sale_amount_excluding_discount,
        count(distinct d.OrderID) as total_number_orders,
        count(d.OrderID) as total_number_entries,
        round(sum(d.Discount * (d.Quantity * d.UnitPrice)), 2) as total_discount_amount,
        round(sum((1 - d.Discount) * (d.Quantity * d.UnitPrice)), 2) as total_sale_amount_including_discount
    from
        Orders as o
    inner join
        Employees as e on o.EmployeeID = e.EmployeeID
    inner join
        [Order Details] as d on d.OrderID = o.OrderID
    inner join
        Products as p on d.ProductID = p.ProductID
    group by
        e.FirstName + ' ' + e.LastName,
        e.Title
)
select
    employee_full_name,
    employee_title,
    total_sale_amount_excluding_discount,
    total_number_orders,
    total_number_entries,
    round(total_sale_amount_excluding_discount * 1.0 / total_number_entries, 2) as average_amount_per_entry,
    round(total_sale_amount_excluding_discount * 1.0 / total_number_orders, 2) as average_amount_per_order,
    total_discount_amount,
    total_sale_amount_including_discount,
    round((total_sale_amount_excluding_discount - total_sale_amount_including_discount) / total_sale_amount_excluding_discount * 100, 2) as total_discount_percentage
from
    cte_kpi
order by
    total_sale_amount_including_discount desc;