
use PIZZA_Data;
select * from pizza_sales;

select datename(month,order_date)  as "Month_name"
,count(distinct order_id) as "total orders" from
group by datename(month, order_date)