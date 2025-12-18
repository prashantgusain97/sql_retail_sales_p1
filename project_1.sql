----create table 

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);


select * from retail_sales;

select count(*) from retail_sales;

select * from retail_sales
where sale_date is null;


select * from retail_sales
where 
    transactions_id is null
	or
    sale_date is null
	or
    sale_time is null
	or
    customer_id is null
	or
    gender is null
	or 
    age is null
	or
    category is null
	or
    quantity is null
	or
    price_per_unit is null
	or
    cogs is null
	or
    total_sale is null;


delete from retail_sales
where 
    transactions_id is null
	or
    sale_date is null
	or
    sale_time is null
	or
    customer_id is null
	or
    gender is null
	or 
    age is null
	or
    category is null
	or
    quantity is null
	or
    price_per_unit is null
	or
    cogs is null
	or
    total_sale is null;



Q1--Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select * from retail_sales
where sale_date = '2022-11-05';

Q2--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select * from retail_sales
where 
     category = 'Clothing'
     and 
	 quantity >= 4
     and
	 to_char(sale_date,'YYYY-MM') = '2022-11';

Q3--Write a SQL query to calculate the total sales (total_sale) for each category.:

select distinct category, sum(total_sale) as sum_total_sales
from retail_sales
group by distinct category;


Q4--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select avg(age) as avg_age
from retail_sales
where category = 'Beauty';


Q5--Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select * from retail_sales
where total_sale > 1000;

Q6--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

SELECT category, gender, count(transactions_id) as total_transaction  
FROM retail_sales
GROUP BY category,gender
ORDER BY category;    
    

Q7--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select year, month, avg_sales from
(
	select
	      extract(year from sale_date) as YEAR,
		  extract(month from sale_date) as MONTH,
	      avg(total_sale) as avg_sales,
		  rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
	from retail_sales
	group by year, month
) as t1
where rank = 1;


-----order by year, avg_sales desc;

Q8--**Write a SQL query to find the top 5 customers based on the highest total sales **:

select customer_id, sum(total_sale)
from retail_sales
group by customer_id 
order by sum(total_sale) desc
limit 5;


Q9--Write a SQL query to find the number of unique customers who purchased items from each category.:

select category, count(distinct customer_id)
from retail_sales
group by category;

Q10--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with hourly_sale 
as
(
select *, 
		case
		when extract (hour from sale_time) < 12 then 'Morning'
		when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
		end as shift_timing
from retail_sales
) 
select shift_timing, count(transactions_id) as total_orders
from hourly_sale
group by shift_timing
order by shift_timing;








