/*
Question 10

The Sales Team wants to build another list of KPIs to measure employees' performances across each category. In order to help them they asked you to provide them a list of categories and employees with:

	1.their categories name
	2.their full name (first name and last name combined in a 3. single field)
	3.their total sales amount including discount (formatted to have only 2 decimals)
	4.their percentage of total sales amount against the total sales amount across all employees (formatted to have only 2 decimals)
	5.their percentage of total sales amount against the total sales amount for each employees (formatted to have only 2 decimals)
Finally order the results by category name (ascending) then total sales amount (descending).
*/

--Solution Query
with cte_kpi as (
    select
        c.CategoryName,
        e.FirstName + ' ' + e.LastName as employee_full_name,
        round(sum(d.Quantity * d.UnitPrice), 2) as total_sale_amount_including_discount
    from
        Employees as e
    inner join
        Orders as o on e.EmployeeID = o.EmployeeID
    inner join
        [Order Details] as d on o.OrderID = d.OrderID
    inner join
        Products as p on d.ProductID = p.ProductID
    inner join
        Categories as c on c.CategoryID = p.CategoryID
	group by
        c.CategoryName,
        e.FirstName + ' ' + e.LastName
)
select
    CategoryName,
    employee_full_name,
    total_sale_amount_including_discount,
    round(
        sum(total_sale_amount_including_discount) * 100.0 /
        sum(sum(total_sale_amount_including_discount)) over (partition by employee_full_name),
        2
    ) AS percentage_of_employee_sales,
    round(
        sum(total_sale_amount_including_discount) * 100.0 /
        sum(sum(total_sale_amount_including_discount)) over (partition by CategoryName),
        2
    ) as percentage_of_category_sales
from
    cte_kpi
group by
    CategoryName,
    employee_full_name,
    total_sale_amount_including_discount
order by
    CategoryName,
    total_sale_amount_including_discount desc;