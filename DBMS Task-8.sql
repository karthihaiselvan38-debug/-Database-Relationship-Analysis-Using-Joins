
use ecommerce_db;

select c.customer_id, c.customer_name, o.order_id,
o.order_date, o.total_amount
from customers c
inner join orders o
on c.customer_id = o.customer_id;

select o.order_id, o.order_date, o.total_amount,
p.payment_mode, p.payment_status
from orders o
inner join payment p
on o.order_id = p.order_id;

select c.customer_name, o.order_id,
pr.product_name, od.quantity
from customers c
inner join orders o on c.customer_id = o.customer_id
inner join order_details od on o.order_id = od.order_id
inner join products pr on od.product_id = pr.product_id;

select c.customer_name, o.order_id, o.order_date
from customers c
left join orders o
on c.customer_id = o.customer_id;

select c.customer_id, c.customer_name
from customers c
left join orders o
on c.customer_id = o.customer_id
where o.order_id is null;

select p.product_id, p.product_name, od.order_id
from products p
left join order_details od
on p.product_id = od.product_id;

select c.customer_name, o.order_id,
o.order_date, o.total_amount
from customers c
right join orders o
on c.customer_id = o.customer_id;

select o.order_id, o.customer_id
from customers c
right join orders o
on c.customer_id = o.customer_id
where c.customer_id is null;

select p.payment_id, p.payment_mode,
p.payment_status, o.order_id, o.order_date
from orders o
right join payment p
on o.order_id = p.order_id;

select c.customer_name, pr.product_name,
od.quantity, o.order_date, o.total_amount,
p.payment_status
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
join products pr on od.product_id = pr.product_id
left join payment p on o.order_id = p.order_id;

select c.customer_name, pr.product_name,
od.quantity, o.order_date
from customers c
join orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
join products pr on od.product_id = pr.product_id
where c.customer_id = 1;

select c.customer_name,
sum(o.total_amount) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_name,
count(o.order_id) as total_orders
from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

select c.customer_name, o.order_id,
o.order_date, o.total_amount
from customers c
join orders o on c.customer_id = o.customer_id
where o.order_date = (
    select max(o2.order_date)
    from orders o2
    where o2.customer_id = c.customer_id
);

select c.customer_name, o.order_id,
o.order_date, o.order_status
from customers c
join orders o on c.customer_id = o.customer_id;

select p.product_name,
sum(od.quantity) as quantity_sold,
sum(od.quantity * od.price) as total_revenue
from products p
join order_details od on p.product_id = od.product_id
group by p.product_id, p.product_name;

select payment_mode,
count(*) as total_transactions,
sum(case when payment_status = 'success'
then 1 else 0 end) as successful_payments
from payment
group by payment_mode;

select c.customer_name,
sum(o.total_amount) as total_spent
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by total_spent desc;

select c.customer_name,
count(o.order_id) as total_orders
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by total_orders desc;

select c.customer_name,
sum(o.total_amount) as highest_spending
from customers c
join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
order by highest_spending desc
limit 1;
