use rushi;

show tables;
SELECT * FROM ORDERS;

-- a. SELECT, WHERE, ORDER BY
SELECT order_id, user_id, order_date, total_amount 
FROM orders WHERE order_date 
BETWEEN '2025-01-01' AND '2025-12-31' 
ORDER BY total_amount DESC;

-- 2️⃣ GROUP BY + Aggregate
SELECT  month(order_date) AS month,
       sum(total_amount) AS total_revenue,
       count(order_id) AS total_orders
FROM orders
GROUP BY month(order_date)
ORDER BY month;

-- 3️⃣ INNER JOIN
SELECT oi.order_item_id, oi.order_id, p.name, oi.quantity, oi.unit_price
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id;

-- 4️⃣ LEFT JOIN (Users + Orders)
SELECT u.user_id, u.email, o.order_id, o.order_date, o.total_amount
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id;

-- 5 RIGHT JOIN (Users + Orders)
SELECT u.user_id, u.email, o.order_id, o.order_date, o.total_amount
FROM users u
RIGHT JOIN orders o ON u.user_id = o.user_id;

-- 6 Subquery (Uncorrelated)
SELECT order_id, total_amount,
       total_amount / (SELECT sum(total_amount) FROM orders) AS revenue_share
FROM orders;

-- 7 Subquery (Correlated)
SELECT u.user_id, u.email,
       (SELECT MAX(o.order_date)
        FROM orders o
        WHERE o.user_id = u.user_id) AS last_order
FROM users u;

-- 8 aggregate functions (SUM, AVG)
SELECT sum(total_amount) as Sum , avg(total_amount) as average FROM orders;

-- 9 Monthly Average Revenue
SELECT order_date,
       SUM(total_amount) / COUNT(DISTINCT user_id) AS monthly_arpu
FROM orders
GROUP BY order_date;

-- 10 Create View for Lifetime Value (LTV)
CREATE VIEW user_ltv AS
SELECT u.user_id,
       u.email,
       COUNT(o.order_id) AS orders_count,
       SUM(o.total_amount) AS lifetime_spend,
       MAX(o.order_date) AS last_order_date
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.email;

-- Check the view
SELECT * FROM user_ltv;

-- 11 Optimization Example (Before)
EXPLAIN ANALYZE
SELECT u.user_id, SUM(o.total_amount)
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE year(o.order_date) = 2025
GROUP BY u.user_id;

-- 12 Optimization Example (After)
EXPLAIN ANALYZE
SELECT u.user_id, SUM(o.total_amount)
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE o.order_date >= '2025-01-01' AND o.order_date < '2026-01-01'
GROUP BY u.user_id;