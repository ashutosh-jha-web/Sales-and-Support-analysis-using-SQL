-- Q1: Write SQL queries to retrieve the total number of orders,total revenue, and average order value
	   SELECT COUNT(ORD_NUM) AS TOTAL_NUMBER_OF_ORDERS,
		SUM(ORD_AMOUNT + ADVANCE_AMOUNT) AS TOTAL_REVENUE,
		AVG(ORD_AMOUNT + ADVANCE_AMOUNT) AS AVERAGE_ORDER_VALUE 
		FROM orders;

		
-- Q2: The operations team needs to track the agent who has handled the maximum number of high-grade customers. Write a SQL query 
    -- to find the agent_name who has the highest count of customers with a grade of 5. Display the agent_name and the count of high_grade customers.
       SELECT a.AGENT_NAME, COUNT(*) AS high_grade_customers_count 
	   FROM agents a
	   INNER JOIN customer c ON a.AGENT_CODE = c.AGENT_CODE -- joining agent and customer table using inner join on agent_code
	   WHERE c.GRADE = 5 -- condition where grade is 5
	   GROUP BY a.AGENT_NAME
	   ORDER BY high_grade_customers_count DESC
	   LIMIT 1;
       

-- Q3: The company wants to identify the most active customer cities in terms of the total order amount. Write a SQL query to find the top 3 customer cities with the highest
	-- total order amount. Include cust_city and total_order_amount in the output. 
	   SELECT c.CUST_CITY, SUM(o.ORD_AMOUNT) AS total_order_amount
	   FROM customer c
	   INNER JOIN orders o ON c.CUST_CODE = o.CUST_CODE
	   GROUP BY c.CUST_CITY
	   ORDER BY total_order_amount DESC
	   LIMIT 3;
       
       


