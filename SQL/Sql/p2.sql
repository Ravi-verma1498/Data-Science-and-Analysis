use PIZZA_Data;
select * from pizza_sales;
select sum(total_price)/count(distinct order_id) as "Avg order value"from pizza_sales


select sum(quantity)as 'Pizza sold' from pizza_sales 
select sum(quantity)/count(distinct order_id) as 'Avg pizzas sold per order'from pizza_sales;


--- daily trends of order ---
select Datename(Dw,order_date) as order_day, count(distinct order_id)
as total_orders from pizza_sales group by Datename(Dw,order_date)



--- order per month -----
select datename(month,order_date)  as "Month_name"
,count(distinct order_id) as "Total_orders" from pizza_sales
group by datename(month, order_date) order by Total_orders desc


--- percentage of sale by pizza catogories--
select pizza_category ,sum(total_price) as "Total revenue",sum(total_price)*100/(select sum(total_price)from pizza_sales) 
 as " PCT of sale by pizza_category " from pizza_sales group by pizza_category 

 select pizza_size ,sum(total_price) as "Total revenue",sum(total_price)*100/(select sum(total_price)from pizza_sales) 
 as " PCT of sale by pizza_size " from pizza_sales group by pizza_size
 
 

 ---- total pizza sold by category ----
 select pizza_category ,sum(quantity) as "Total pizza sold",sum(total_price)*100/(select sum(total_price)from pizza_sales) 
 as " PCT of sale by pizza_category " from pizza_sales group by pizza_category 

 
 ---- top 5 best sellers by revenue .total quantity and total orders---
 select TOP 5 pizza_name,sum(total_price) as "Total_revenue" from pizza_sales
 group by pizza_name order by Total_revenue Desc 


 select TOP 5 pizza_name,sum(quantity) as "Total_quantity" from pizza_sales
 group by pizza_name order by Total_quantity Desc

