CREATE DATABASE IF NOT EXISTS p1_retail_db ;

-- Creating table
CREATE TABLE IF NOT EXISTS retail_sales
			(transactions_id INT PRIMARY KEY,
            sale_date DATE,
            sale_time TIME,
            customer_id INT,
            gender VARCHAR(10),
            age INT,
            category VARCHAR(20),
            quantity INT,
            price_per_unit FLOAT,
            cogs FLOAT,
            total_sale FLOAT
            );


SELECT *
FROM retail_sales;

SELECT COUNT(*)
FROM retail_sales;

SELECT *
FROM retail_sales
WHERE transactions_id IS NULL
	OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL 
    OR total_sale IS NULL

;

-- DATA EXPLORARATION
-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'
;

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing' 
	AND sale_date >= '2022-11-1' AND sale_date < '2022-12-1'
    AND quantity >= 4
;

-- Write a SQL query to calculate the total sales (total_sale) for each category
SELECT category,
		SUM(total_sale) AS t_sales
FROM retail_sales
GROUP BY category
ORDER BY t_sales DESC
;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'Beauty'
;
-- Write a SQL query to find all transactions where the total_sale is greater than 1000

SELECT *
FROM retail_sales
WHERE total_sale > 1000
;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
	category, 
    gender, 
    COUNT(*) AS total_transac
FROM retail_sales
GROUP BY category, 
         gender
ORDER BY total_transac DESC

;


-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT year, month, avg_sale
FROM(
		SELECT
			YEAR(sale_date) AS year,
			MONTH(sale_date) AS month,
			AVG(total_sale) AS avg_sale,
			RANK() OVER(PARTITION BY YEAR(sale_date)ORDER BY AVG(total_sale) DESC) AS rank_
		FROM retail_sales
		GROUP BY year, month
		ORDER BY year, avg_sale DESC) AS t1
        
WHERE rank_ = 1
;

-- Write a SQL query to find the top 5 customers based on the highest total sales

SELECT customer_id,
		SUM(total_sale) AS t_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY t_sale DESC
LIMIT 5
;

-- Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,
	   COUNT(DISTINCT customer_id)
FROM retail_sales
GROUP BY category
;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale 
AS (
SELECT *,
CASE
	WHEN sale_time < '12:00' THEN 'Morning'
    WHEN sale_time BETWEEN '12:00' AND '17:01' THEN 'Aternoon'
    ELSE 'Evening'
END AS shift
FROM retail_sales
)

SELECT shift, 
	   COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift
;























