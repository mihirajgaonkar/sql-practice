Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
 

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output: 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: 
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.

my solution:
-- Write your PostgreSQL query statement below
with temp as (
    select customer_id, count(distinct product_key) as cnt
    from Customer
    where product_key in (select * from Product)
    group by customer_id
    having count(distinct product_key) = (select count(*) from Product)
)

select customer_id from temp 


fastest solution:
with joined_tbl as (
    select c.customer_id, p.product_key
    from customer c
    left join product p on c.product_key = p.product_key
),

sum_tbl as (
    select customer_id, count(distinct product_key) as num_products
    from joined_tbl
    group by customer_id
)

select customer_id
from sum_tbl
where num_products = (select count(distinct product_key) from product)

