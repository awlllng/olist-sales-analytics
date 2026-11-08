-- Delivery delay vs customer review score
-- Only orders with status 'delivered' and a known delivery date are counted
-- Late = delivered after the estimated date; all years included
-- Orders with several reviews: scores are averaged per order (one row per order)
-- Orders without a review are not included (JOIN drops them)
-- Check: sum of orders_count = 95,824 (unique reviewed delivered orders)
SELECT
    CASE
      WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'late'
      ELSE 'on_time'
    END AS delivery_status,
  COUNT(*) AS orders_count,
  ROUND(AVG(r.review_score),2) AS avg_score,
  ROUND(COUNT(*) * 100 / SUM(COUNT(*)) OVER (), 2) AS share_pct
FROM `olist-analytics-practice.olist.orders` AS o
JOIN (
  SELECT
    order_id,
    AVG(review_score) AS review_score
  FROM `olist-analytics-practice.olist.order_reviews`
  GROUP BY order_id
) AS r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status
