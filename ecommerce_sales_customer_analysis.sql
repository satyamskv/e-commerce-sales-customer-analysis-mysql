create database ecommerce;
use ecommerce;
show tables from ecommerce;

/* =====================================================================
Initial data cleaning and exploration 
===================================================================== */

desc customers;
alter table customers
rename column ï»¿customer_id to customer_id;

desc orderdetails;
alter table orderdetails
rename column ï»¿order_id to order_id;

desc orders;
alter table orders rename column
ï»¿order_id to order_id;
select * from orders;
alter table orders modify
column order_date date;

desc products;
alter table products
rename column ï»¿product_id to product_id;

select * from customers;
select customer_id, count(*) from customers
group by customer_id having count(*) >1;

select * from orderdetails;

select * from orders;
select order_id, count(*) as total from orders
group by order_id having count(*) > 1;

select * from products;


-- Q01: Describe the four tables and identify their key columns and relationships.
desc customers;
desc orderdetails;
desc orders;
desc products;

-- Q02: Which three locations have the most customers?
select location, count(*) as Total_Customers
from customers group by location order by count(*) desc limit 3;

-- Q03: As per the last query's result, Which of the cities must be focused as a part of marketing strategies?
-- Delhi, Chennai, and Jaipur


-- Q04: How many customers placed 1 order, 2 orders, 3 orders, and so on?
with cta1 as (
select customer_id, count(*) as TotalOrders
from orders group by customer_id
)
select TotalOrders, count(*) as TotalCustomers
from cta1 group by Totalorders order by totalorders asc; 

-- Q05: As per the Engagement Depth Analysis question, What is the trend of the number of customers v/s number of orders?
-- As the number of orders increases, customer count decreases.

-- Q06: As per the Engagement Depth Analysis question, Which customers category does the company experiences the most?
-- Occasional shoppers


-- Q07: Identify products where the average purchase quantity per order is 2 but with a high total revenue, suggesting premium product trends.
select product_id, avg(quantity) as Average_Purchase, sum(quantity * price_per_unit) as Total_Revenue
from orderdetails group by product_id having avg(quantity) = 2 order by avg(quantity), sum(quantity * price_per_unit) desc;

-- Q08: Among products with an average purchase quantity of two, which ones exhibit the highest total revenue?
-- Product 1


-- Q09: How many unique customers purchased from each product category?
select p.category, count(DISTINCT o.customer_id) as unique_customers
from products p join orderdetails od on p.product_id = od.product_id join orders o 
on o.order_id = od.order_id
GROUP BY p.category order by  count(DISTINCT o.customer_id) desc;

-- Q10: As per the last question, Which product category needs more focus as it is in high demand among the customers?
-- Electronics

-- Q11: What is the month-over-month percentage change in sales revenue?
with cta1 as (
    select date_format(order_date, '%Y-%m') as Month,
    sum(total_amount) as totalsales,
    lag(sum(total_amount)) over (order by date_format(order_date, '%Y-%m') ) as previous_month
    from orders GROUP BY date_format(order_date, '%Y-%m')
)
select Month, totalsales,round((totalsales - previous_month) / previous_month * 100, 2) as PercentChange
from cta1;

-- Q12: Which month had the largest month-over-month revenue decline?
-- Feb 2024

-- Q13: As per Sales Trend Analysis question, What could be inferred about the sales trend from March to August?
-- Sales fluctuated with no clear trend


-- Q14: How does average order value change from month to month?
with cta1 as (
    select date_format(order_date, '%Y-%m') as Month, 
    round(avg(total_amount),2) as AvgOrderValue,
    lag(round(avg(total_amount),2)) over (order by date_format(order_date, '%Y-%m')) as previous_month
    from orders GROUP by date_format(order_date, '%Y-%m')
)
select Month, AvgOrderValue, (AvgOrderValue - previous_month) as ChangeInValue
from cta1 order by (AvgOrderValue  - previous_month) desc;

-- Q15: As per last query, Which month has the highest change in the average order value?
-- December

-- Q16: Which five products appear in the greatest number of orders?
select product_id, count(*)  as SalesFrequency 
from orderdetails GROUP BY product_id order by count(*) desc limit 5;

-- Q17: Which product appears in the most orders and may need replenishment attention?
-- Product ID 7

-- Q18: Which products were purchased by fewer than 40% of customers?
select p.product_id as Product_ID,
p.name as Name, count(DISTINCT o.customer_id) as UniqueCustomerCount
from products p left join orderdetails od on p.product_id = od.product_id
left join orders o on od.order_id = o.order_id

group by p.product_id, p.name 
having count(DISTINCT o.customer_id) < (select count(DISTINCT customer_id) * 0.40 from customers);

-- Q19: Why might certain products have purchase rates below 40% of the total customer base?
-- Poor visibility on the platform


-- Q20: What actions could help improve sales of products with low customer reach?
-- Implement targeted marketing compaigns to raise awarness and interest.

-- Q21: How many customers made their first recorded purchase in each month?
with cta1 as (
    select customer_id, min(order_date) as first_order
    from orders GROUP BY customer_id
)
select date_format(first_order, '%Y-%m') as FirstPurchaseMonth,
count(*) as TotalNewCustomers from cta1 GROUp by FirstPurchaseMonth
order by FirstPurchaseMonth;

-- Q22: As per last query, What can be inferred about the growth trend in the customer base from the result table?
-- It is downword trend which implies the marketing campaign are not much effective


-- Q23: Which three months generated the highest sales revenue?
select date_format(order_date, '%Y-%m') as Month,
sum(total_amount) as TotalSales
from orders
GROUP BY date_format(order_date, '%Y-%m')
order by TotalSales desc limit 3;

-- Q24: As per last query, Which months will require major restocking of product and increased staffs?
-- September and December