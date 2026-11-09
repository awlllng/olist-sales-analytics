-- KPIs for 2017: revenue, number of orders, average order value
-- Revenue = sum of item price (freight excluded)
-- Only orders with status 'delivered' are counted
-- Orders are counted as distinct order_id (an order has many item rows)
-- Check: revenue = 5,962,902.01, orders = 43,428
SELECT
  ROUND(SUM(oi.price),2) AS total_revenue,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND((SUM(oi.price))/(COUNT(DISTINCT o.order_id)),2) AS avg_order_value
FROM `olist-analytics-practice.olist.orders` AS o
JOIN `olist-analytics-practice.olist.order_items` AS oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered' AND EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
