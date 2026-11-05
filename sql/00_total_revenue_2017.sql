-- Total revenue for 2017
-- Revenue = sum of item price (freight excluded)
-- Only orders with status 'delivered' are counted

SELECT
  ROUND(SUM(oi.price), 2) AS revenue_2017
FROM `olist-analytics-practice.olist.orders` AS o
JOIN `olist-analytics-practice.olist.order_items` AS oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
