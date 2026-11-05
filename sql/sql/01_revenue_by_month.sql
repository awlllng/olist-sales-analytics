-- Monthly revenue for 2017
-- Revenue = sum of item price (freight excluded)
-- Only orders with status 'delivered' are counted
-- Month is based on order purchase date (not delivery date)
-- Check: sum of 12 months = 5,962,902.01 (matches 00_total_revenue_2017.sql)
SELECT
  ROUND(SUM(oi.price), 2) AS revenue_by_month_2017,
  EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month
FROM `olist-analytics-practice.olist.orders` AS o
JOIN `olist-analytics-practice.olist.order_items` AS oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered' AND EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
GROUP BY month
ORDER BY month
