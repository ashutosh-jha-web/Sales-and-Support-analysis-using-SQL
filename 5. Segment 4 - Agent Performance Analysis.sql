-- Q1: Company wants to provide a performance bonus to their best agents based on the maximum order amount. Find the top 5 agents eligible for it.
	SELECT a.AGENT_NAME, MAX(o.ORD_AMOUNT) AS max_order_amount
	FROM agents a
	INNER JOIN orders o ON a.AGENT_CODE = o.AGENT_CODE
	GROUP BY a.AGENT_NAME
	ORDER BY max_order_amount DESC
	LIMIT 5;
    
    select * from orders;


-- Q2: The company wants to analyse the performance of agents based on the number of orders they have handled. Write a SQL to rank agents based
-- 	   on the total number of orders they have possessed. Display agent_name,total_orders, and their respective ranking.
	SELECT a.AGENT_NAME, COUNT(o.ORD_NUM) AS total_orders,
       RANK() OVER (ORDER BY COUNT(o.ORD_NUM) DESC) AS agent_rank
	FROM agents a
	LEFT JOIN orders o ON a.AGENT_CODE = o.AGENT_CODE
	GROUP BY a.AGENT_NAME;

-- Q3: Company wants to change the commission for the agents,basis advance payment the collected. Write a sql query which create a new column
-- 	   updated_commision on the bases below rules.
-- * if the average advance amount collected is less than 750, there is no change is commission
-- * if the average advance amount collected is between 750 and 1000(inclusive), the new commission will be 1.5 times the old commission.
-- * if the average advance amount collected is more than 1000, the new commission will be 2 times the old commission.

		ALTER TABLE agents
		ADD COLUMN updated_commission DECIMAL(10, 2) DEFAULT 0;

		SET SQL_SAFE_UPDATES = 0;

		UPDATE agents AS a
		SET updated_commission = 
			CASE
				WHEN (
					SELECT AVG(advance_amount)
					FROM orders AS o
					WHERE o.agent_code = a.agent_code
				) < 750 THEN commission
				WHEN (
					SELECT AVG(advance_amount)
					FROM orders AS o
					WHERE o.agent_code = a.agent_code
				) BETWEEN 750 AND 1000 THEN commission * 1.5
				ELSE commission * 2
			END;

select * from agents;




