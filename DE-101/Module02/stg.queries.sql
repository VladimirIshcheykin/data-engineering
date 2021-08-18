--Построить Сводную таблицу

select o.*, CASE WHEN r.returned is null then'No' else 'Yes' end as returned, p.person 
from stg.orders o
left join (select distinct order_id, returned from stg."returns") r on r.order_id = o.order_id 
left join stg.people p on p.region = o.region 
order by o.row_id asc;


--Total Sales
--Total Profit
--Profit Ratio
--Avg. Discount

select sum(o.sales) sum_sales, sum(o.profit) sum_profit, sum(o.profit)/sum(o.sales)*100 profit_ratio, avg(o.discount) avg_discount
from stg.orders o;


--Profit per Order

select o.order_id, sum(o.profit) sum_profit
from stg.orders o
group by o.order_id 
order by sum_profit desc;


--Sales per Customer

select o.customer_id, o.customer_name , sum(o.sales) sum_sales
from stg.orders o
group by o.customer_id, o.customer_name 
order by sum_sales desc;


--Monthly Sales by Segment

select o.segment, EXTRACT(month from o.order_date) od_month, extract(year from o.order_date) od_year, sum(o.sales) sum_sales
from stg.orders o
group by o.segment, od_month, od_year 
order by od_year, od_month, o.segment;


--Monthly Sales by Product Category

select o.category, EXTRACT(month from o.order_date) od_month, extract(year from o.order_date) od_year, sum(o.sales) sum_sales
from stg.orders o
group by o.category, od_month, od_year 
order by od_year, od_month, o.category;


--Sales by Product Category

select o.category, o.subcategory, sum(o.sales) sum_sales
from stg.orders o
group by o.category, o.subcategory
order by o.category, o.subcategory;


--Sales and Profit by Customer

select o.customer_id, o.customer_name, sum(o.sales) sum_sales, sum(o.profit) sum_profit
from stg.orders o
group by o.customer_id, o.customer_name 
order by sum_sales desc;


--Customer Ranking

select o.customer_id, o.customer_name, o.sum_sales, row_number() over (order by o.sum_sales desc) as rank
from 
(
select o.customer_id, o.customer_name, sum(o.sales) sum_sales
from stg.orders o
group by o.customer_id, o.customer_name
) o
order by rank asc;


--Sales per region

select o.region, sum(o.sales) sum_sales
from stg.orders o
group by o.region 
order by sum_sales desc;

