-- Q1: Calculate the total number of customers.
	SELECT COUNT(*) AS total_customers
	FROM customer;
    
-- Q2: Identify the top-spending customers based on their total order value.
    SELECT customer.CUST_NAME AS CUSTOMER,SUM(ORD_AMOUNT + ADVANCE_AMOUNT) AS TOTAL_ORDER_VALUE FROM customer
 JOIN orders
 ON orders.CUST_CODE = customer.CUST_CODE
 GROUP BY CUSTOMER
 ORDER BY TOTAL_ORDER_VALUE DESC
 LIMIT 1;
 
-- Q3: Analyse customer retention by calculating the percentage of repeat customers. 
	SELECT COUNT(*) AS repeat_customers,
       (COUNT(*) / (SELECT COUNT(*) FROM customer)) * 100 AS repeat_customer_percentage
	FROM (
		SELECT CUST_CODE
		FROM orders
		GROUP BY CUST_CODE
		HAVING COUNT(*) > 1
	) AS repeat_customers;
    
    select * from customer;
    
-- Q4: Find the name of the customer who has the maximum outstanding amount from every country.
	SELECT c.CUST_COUNTRY, c.CUST_NAME, MAX(c.OUTSTANDING_AMT) AS max_outstanding_amount
	FROM customer c
	GROUP BY c.CUST_COUNTRY,c.CUST_NAME
    ORDER BY AMOUNT DESC;
    
-- Q5: Write a SQL query to calculate the percentage of customers in each grade category (1 to 5).
	SELECT GRADE,
	ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM customer), 2) AS percentage
	FROM customer
	GROUP BY grade
	ORDER BY grade;



