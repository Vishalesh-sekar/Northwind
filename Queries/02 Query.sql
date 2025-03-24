/*
Question 2
The Logistics Team wants to do a retrospection of their performances for the year 1998, 
in order to identify for which countries they didn’t perform well. They asked you to provide them a list of countries with the following information:

1.their average days between the order date and the shipping date (formatted to have only 2 decimals)

2.their total number of orders (based on the order date) Filtered on the following conditions:

	`the year of order date is 1998

	`their average days between the order date and the shipping date is greater or equal 5 days

	`their total number of orders is greater than 10 orders

3.Finally order the results by country name in an ascending order (lowest first).
*/


-- Solution Query
WITH cte_avg_days AS (
	SELECT
		ShipCountry,
		ROUND(AVG(datediff(DAY, OrderDate, ShippedDate ) * 1.0), 2) AS average_days_between_order_shipping,
		COUNT(*) AS total_number_orders
	FROM Orders
	WHERE YEAR(OrderDate) = 1998
	GROUP BY ShipCountry
)
SELECT * FROM cte_avg_days
WHERE average_days_between_order_shipping >= 5
AND total_number_orders > 10
	ORDER BY ShipCountry;
