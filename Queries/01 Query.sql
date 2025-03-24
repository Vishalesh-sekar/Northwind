/*

Question 1
For their annual review of the company pricing strategy, the Product Team wants to look at the products that are currently being offered
for a specific price range ($20 to $50). In order to help them they asked you to provide them with a list of products with the following information:

1.their name
2.their unit price

Filtered on the following conditions:
1.their unit price is between 20 and 50
2.they are not discontinued

Finally order the results by unit price in a descending order (highest first).
*/


--Solution Query
select 
	ProductName, 
	UnitPrice 
from Products
where UnitPrice between 20 and 50
and discontinued=0
order by UnitPrice desc;

