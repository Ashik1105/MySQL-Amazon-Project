create database amazon;

use amazon;

select * from amazon_da01;

select count(*) from amazon_da01;

--- Filtering (By_Text) ---
select * from amazon_da01
where category ="Electronics|HomeTheater,TV&Video|Accessories|Cables|HDMICables";


--- Filtering (By_Numbers) ---
select * from amazon_da01
where discounted_price < 200;

select * from amazon_da01
where discounted_price > 200;

--- Filtering using_Multiple conditons(AND_OR) ---
select * from amazon_da01
where category = "Computers&Accessories|Accessories&Peripherals|Cables&Accessories|Cables|USBCables"
and rating > 4.0;

--- Filtering (By_Partial Matches) ---
select * from amazon_da01
where product_name like "%Cable%";

--- Sorting (by_a Single_Column) ---
select * from amazon_da01
order by rating desc;

--- Sorting (by_Price) ---
select * from amazon_da01
order by discounted_price asc;

select * from amazon_da01
order by discounted_price desc;

--- grouping_Count_the_number_of_products_per_Category ---
select category, count(*) as total_products 
from amazon_da01
group by category;

--- Find_the_Average_price_and_rating per Category ---
select category,
round(avg(discounted_price), 2) as average_price,
round(avg(rating), 1) as average_rating
from amazon_da01
group by category;

--- Filter_grouped_results (Using_HAVING) ---
select category,
round(avg(rating), 1) as average_rating
from amazon_da01
group by category
having avg(rating) > 4.2;

--- Group_and_sort_together ---
select category, sum(rating_count) as total_reviews
from amazon_da01
group by category
order by total_reviews desc;

--- Aggregation_COUNT()_Count_Rows ---
select count(*) as total_products
from amazon_da01;

--- Number_of_products_that_have_a_discount ---
select count(discounted_price) as discounted_items 
from amazon_da01
where discounted_price < actual_price;

--- Aggregation_AVG()_Find_the_Average ---
select 
round(avg(discounted_price), 2) as average_market_price,
round(avg(rating), 1) as average_customer_rating
from amazon_da01;

--- Aggregation_SUM()_Total_Additions ---
select sum(rating_count) as total_reviews_received
from amazon_da01;

--- Aggregation_MIN()_and_MAX()_Find_Extremes ---
select
min(discounted_price) as lowest_price,
max(discounted_price) as highest_price,
max(rating) as best_rating
from amazon_da01;

--- Putting_it_all_together ---
select category,
count(*) as total_items,
min(discounted_price) as cheapest_price,
max(discounted_price) as priciest_price,
round(avg(discounted_price), 2) as average_price,
sum(rating_count) as total_reviews
from amazon_da01
group by category
order by total_items desc;

--- Subqueries ---
--- Subquery_in_a_WHERE_Clause (Filtering_Against_Calculations) ---
select product_name, rating
from amazon_da01
where rating > (
select avg(rating)
from amazon_da01
);

--- Subquery_in_a_SELECT_Column (Comparing_individual_rows_to_a_total) ---
select  product_name, discounted_price,
(select max(discounted_price) from amazon_da01) as maximum_market_price,
((select max(discounted_price) from amazon_da01) - discounted_price) as price_difference
from amazon_da01;

--- Subquery_in_a_FROM_Clause (Quering_a_Summarized_table) ---
select category, average_price
from (
select category, round(avg(discounted_price), 2) as average_price
from amazon_da01
group by category
) as category_summaries
where average_price > 500.00;

--- Writing_SQL_queries_for_business_questions ---
--- Revenue_and_Pricing_Optimization ---
select product_name,
category,
actual_price,
discounted_price,
(actual_price - discounted_price) as raw_discount_value,
round(((actual_price - discounted_price) / actual_price) * 100, 2) as discount_percentage,
rating_count as total_reviews
from amazon_da01
where actual_price > 0
order by discount_percentage desc;

--- Category_Performance_Analysis ---
select category,
count(*) as total_products_listed,
sum(rating_count) as total_reviews_received,
round(avg(rating), 2) as average_customer_rating
from amazon_da01
group by category
having total_products_listed > 1
order by average_customer_rating desc;

--- Inventory_Quality_Control (Idendifying_Problem_Products) ---
select ï»¿product_id,
product_name,
rating,
rating_count
from amazon_da01
where rating < 3.8
and rating_count > 100
order by rating asc;

--- Customer_Engagement_and_Behavior ---
select user_name,
count(*) as total_reviews_written,
round(avg(rating), 1) as average_rating_given
from amazon_da01
where user_name is not null
group by user_name
order by total_reviews_written desc
limit 10;


select * from amazonshort;

select count(*) from amazonshort;

--- JOINS ---
--- INNER_JOIN ---
SELECT a.product_name, s.serial_no
FROM amazon_da01 a
INNER JOIN amazonshort s 
  ON a.product_name = s.product_name;
  
--- LEFT_JOIN ---
SELECT a.category, s.serial_no
FROM amazon_da01 a
LEFT JOIN amazonshort s 
  ON a.product_name = s.product_name;
  
--- RIGHT_JOIN ---
SELECT a.category, s.serial_no
FROM amazon_da01 a
RIGHT JOIN amazonshort s 
  ON a.product_name = s.product_name;
  
--- CROSS_JOIN ---
SELECT a.category, s.product_name
FROM amazon_da01 a
CROSS JOIN amazonshort s;
