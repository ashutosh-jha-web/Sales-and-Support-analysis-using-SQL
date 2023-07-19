-- Q1: Add a new column named avg_rcv_amt in the table customers which contains the average receive amount for every country. 
--     Display all columns from the customer table along with the avg_rcv_amt column in the last.
	   ALTER TABLE customer
		ADD COLUMN avg_rcv_amt DECIMAL(12, 2);
		SET SQL_SAFE_UPDATES = 0;
		UPDATE customer AS c
		JOIN (
			SELECT CUST_COUNTRY, AVG(RECEIVE_AMT) AS avg_receive_amt
			FROM customer
			GROUP BY CUST_COUNTRY
		) AS subquery ON c.CUST_COUNTRY = subquery.CUST_COUNTRY
		SET c.avg_rcv_amt = subquery.avg_receive_amt;

        
        SELECT * FROM customer; 
        
        

-- Q2: Write a sql query to create and call a UDF named avg_amt to return the average 
-- outstanding amount of the customers which are managed by a given agent. 
-- Also, call the UDF with the with agent name 'Mukesh'.

SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
CREATE FUNCTION avg_amount(agent_name VARCHAR(40))
RETURNS INT
BEGIN
declare output INT;
SELECT round(AVG(outstanding_amt),0) into output
FROM customer c
join agents a on c.agent_code=a.agent_code
where a.agent_name='Mukesh';
return output;
END //
DELIMITER ;

drop function if exists avg_amount;

select * from agents; 
select * from customer;
SELECT avg_amount('Mukesh') AS average_outstanding_amount;


-- Q3: Write a sql query to create and call a subroutine called cust_detail to return all the details of the customer which are having
-- 	   the given grade. Also, call the subroutine with grade 2.
		DELIMITER //

		CREATE PROCEDURE cust_detail(IN p_grade DECIMAL(10, 0))
		BEGIN
			SELECT *
			FROM customer
			WHERE GRADE = p_grade;
		END //

		DELIMITER ;
		-- Calling the subroutine with grade 2
		CALL cust_detail(2);


-- Q4: Write a stored procedure sp_name which will return the concatenated ord_num (comma separated) of the customer with 
--     input customer code using cursor. Also, write the procedure call query with cust_code 'C00015'.

		DELIMITER //

		CREATE PROCEDURE s_name(IN p_cust_code VARCHAR(10))
		BEGIN
			DECLARE ord_num_list VARCHAR(1000);
			DECLARE done INT DEFAULT 0;
			DECLARE v_ord_num VARCHAR(10);
			
			-- Declare the cursor for fetching ord_num based on customer code
			DECLARE cur CURSOR FOR
				SELECT ord_num
				FROM orders
				WHERE cust_code = p_cust_code;
				
			-- Declare 'NOT FOUND' handler to exit the loop
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
			
			-- Initialize the ord_num_list
			SET ord_num_list = '';
			
			-- Open the cursor
			OPEN cur;
			
			-- Loop through the cursor and concatenate ord_num values
			read_loop: LOOP
				FETCH cur INTO v_ord_num;
				
				IF done THEN
					LEAVE read_loop;
				END IF;
				
				-- Concatenate ord_num with comma separator
				SET ord_num_list = CONCAT_WS(',', ord_num_list, v_ord_num);
			END LOOP;
			
			-- Close the cursor
			CLOSE cur;
			
			-- Return the concatenated ord_num list
			SELECT ord_num_list AS concatenated_ord_num;
		END //

		DELIMITER ;


		-- Calling the stored procedure with cust_code 'C00015'
		CALL s_name('C00015'); 

