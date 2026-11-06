-- Top 10 product categories by revenue, 2017
-- Revenue = sum of item price (freight excluded)
-- Only orders with status 'delivered' are counted
-- Categories without a translation or name are grouped as 'unknown'
-- Check: sum over all categories = 5,962,902.01 (matches 00_total_revenue_2017.sql)
SELECT
    COALESCE(pcn.string_field_1, 'unknown') AS category,
    ROUND(SUM(oi.price),2) AS revenue
  FROM `olist-analytics-practice.olist.orders` AS o
  JOIN `olist-analytics-practice.olist.order_items` AS oi ON o.order_id = oi.order_id
  JOIN `olist-analytics-practice.olist.products` AS p ON oi.product_id = p.product_id
  LEFT JOIN `olist-analytics-practice.olist.product_category_name_translation` AS pcn ON p.product_category_name = pcn.string_field_0
  WHERE o.order_status = 'delivered' AND EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
  GROUP BY category
  ORDER BY revenue DESC
  LIMIT 10
