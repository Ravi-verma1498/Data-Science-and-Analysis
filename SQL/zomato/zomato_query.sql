use zomato ;

select*from restaurants;  

alter table orders modify column date date;

select name from users  where user_id not in (select user_id from orders);

select f_id , avg(price) ,max(price),count(r_id) ,min(price) from menu group by f_id ; 
select f_name from food where f_id in (select f_id from menu group by f_id) ;


select f_name ,avg(price)as 'AVG PRICE' ,count( r_id), count(f.f_id) from menu as m join food as f on m.f_id = f.f_id group by f_name  ; 

select*from menu join food on menu.f_id = food.f_id ;



# 2. Q )select  which restarount has highest order in june 
select *,monthname(date) from orders; 
select *,monthname(date) as "month"from orders where monthname(date) like 'June';
select r_id ,count(r_id) as "june order count" from orders where monthname(date) like 'June' group by r_id order by count(r_id) desc;

# to get restauarnt name we have to join restaurant and orders
select  r_name,orders.r_id ,count(orders.r_id) as "june order count" from 
orders join restaurants on orders.r_id = restaurants.r_id
where monthname(date) like 'June' group by orders.r_id order by count(orders.r_id) desc;

# 3.Q)restaurants with monthly sale > x for 
select r_id,sum(amount) as "revenue" from orders  where monthname(date) like 'June' group by r_id; 
select r_id,sum(amount) as "revenue" from orders  where monthname(date) like 'June' group by r_id having  revenue > 500; 
select o.r_id,r_name ,sum(amount) as "revenue" from orders o join restaurants r  on o.r_id = r.r_id 
where monthname(date) like 'June' group by o.r_id having  revenue > 500; 

#  4.Q)show all orders with order for a particualar customer in a particular data range 

select * from orders where user_id = (select user_id from users  where name like "Ankit");

select * from orders where user_id = (select user_id from users  where name like "Ankit") 
and (date >'2022-06-10' and date <'2022-07-10'); 


select * from orders o join restaurants r  on o.r_id = r.r_id;
select o.order_id ,r.r_name from orders o join restaurants r  on o.r_id = r.r_id where user_id = (select user_id from users  where name like "Ankit") 
and (date >'2022-06-10' and date <'2022-07-10'); 

# 5.Q)To find which food id  is ordered  by joining order details and order  
select r.r_name,o.order_id,f_id from orders o join restaurants r  on o.r_id = r.r_id  join order_detail od on o.order_id = od.order_id
where user_id = (select user_id from users  where name like "Ankit") 
and (date >'2022-06-10' and date <'2022-07-10'); 


# here  we join to get f_di to f_name
select r.r_name,o.order_id,f.f_name from orders o join restaurants r  on o.r_id = r.r_id  join order_detail od on o.order_id = od.order_id
join food f on  od.f_id = f.f_id
where user_id = (select user_id from users  where name like "Ankit") 
and (date >'2022-06-10' and date <'2022-07-10'); 


# 6.Q) Find restaurants with max repeated customers  

select * from orders ;
select r_id,user_id ,count(*) from orders group by r_id ,user_id;  # give no of order placed of by combination of r_id and user_id 

select r_id,user_id ,count(*)   as "vistis" from orders group by r_id ,user_id  having count(*)>1; # this whole code represent a table so we can use it as table as below 
select r_id,count(*) from (select r_id,user_id ,count(*)   as "vistis" from orders group by r_id ,user_id  having count(*)>1) t group by r_id;  # here t is alias  of derived table of above 
select r_name,count(*) from (select r_id,user_id ,count(*)   as "vistis" from orders group by r_id ,user_id  having count(*)>1) t 
join restaurants r on t.r_id= r.r_id 
group by t.r_id order by count(*) desc limit 1;  # here t is alias  of derived table of above 


############7.Q)month over month revenue growth of zomato ! ################

# here we assume all sales are of zomato hence zomato gets 
select sum(amount) as revenue ,monthname(date) as month from orders group by monthname(date) order by month desc;

select month,((revenue-prev)/prev)*100 from (
  with sale as 
 (
 select sum(amount) as revenue ,monthname(date) as month from orders group by monthname(date) order by month desc
 )
 select month ,revenue,lag(revenue,1) over(order by  revenue) as prev from sales) t ;


########## find costumer favourite food #########

select o.user_id , od.f_id,count(*) as frequency from order_detail od join orders o  on od.order_id = o.order_id  group by user_id ,f_id;

with temp as 
 ( select o.user_id , od.f_id,count(*) as frequency from order_detail od join orders o  on od.order_id = o.order_id
 group by user_id ,f_id) 
 select *from temp1 t1 where t1.frequency= (select max(frequency) from temp t2 where t2.user_id = t1.user_id);
 













