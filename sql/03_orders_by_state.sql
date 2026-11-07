-- Top 10 customer states by number of orders, 2017
-- Only orders with status 'delivered' are counted
-- Check: sum over all 27 states = 43,428 (matches plain count from order
SELECT
  c.customer_state,
  COUNT(*) AS total
FROM `olist-analytics-practice.olist.orders` AS o
JOIN `olist-analytics-practice.olist.customers` AS c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered' AND EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
GROUP BY c.customer_state
ORDER BY total DESC
LIMIT 10
