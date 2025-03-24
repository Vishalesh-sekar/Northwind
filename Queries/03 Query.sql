/*
Question 3

The HR Team wants to know for each employee what was their age on the date they joined the company and who they currently report to. 
Provide them with a list of every employees with the following information:

	1. their full name (first name and last name combined in a single field)
	2. their job title
	3. their age at the time they were hired
	4. their manager full name (first name and last name combined in a single field)
	5. their manager job title
Finally order the results by employee age and employee full name in an ascending order (lowest first).
*/

--Solution Query
select 
	e.FirstName+''+e.LastName as employee_full_name,
	e.Title as employee_title,
	DATEDIFF(year, e.BirthDate, e.HireDate) as employee_age,
	m.FirstName+''+m.LastName as manager_full_name,
	m.Title as manager_title
from Employees as e
inner join Employees as m 
on m.EmployeeID = e.ReportsTo
order by employee_age, employee_full_name;
