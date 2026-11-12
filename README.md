# Olist E-commerce: Sales Overview, 2017

A portfolio project in SQL (BigQuery), Google Sheets and Tableau Public, based on the public Brazilian e-commerce dataset from Olist.

## Business problem

Olist is a Brazilian e-commerce company. This project uses its public dataset (about 100,000 orders) to answer four questions that a sales team might ask:

1. How did revenue change during 2017, and which months were the strongest and the weakest?
2. Which product categories bring in the most revenue?
3. Which Brazilian states place the most orders?
4. Are late deliveries linked to lower customer review scores?

The answers could help decide when to focus sales efforts, which categories and regions to prioritise, and whether delivery performance needs attention.

Scope: the revenue, category and state figures cover delivered orders placed in 2017. The delivery analysis covers delivered orders from all years that have a review.

*This is a portfolio project. The questions are modelled on what a sales team might ask; they are not a real client request.*

## Approach

**How revenue is defined**

- Revenue = the sum of item `price` (freight is excluded).
- Only orders with status `delivered` are counted, because a delivered order is a completed sale. Canceled, unavailable and in-progress orders may never turn into revenue. This is a fairly strict definition; a looser one (for example, all approved orders) would give higher numbers.
- This is revenue, not profit: the dataset contains no cost data.
- The month comes from the order purchase date, not the delivery date.
- Orders are counted as distinct `order_id`, because one order can have many item rows.

**Data checks**

- The 12 monthly revenue values add up to the total of 5,962,902.01.
- Revenue summed over all product categories equals the same total. The category translation table is joined with a LEFT JOIN so that no rows are lost.
- Orders summed over all 27 states equal 43,428, the same as a plain count on the orders table.
- A first version of the monthly query was missing the year filter; the check against the total caught it.

**Reviews**

- Reviews are linked to orders, not to products, which is enough for the delivery question.
- Some orders have more than one review (96,353 rows for 95,824 unique orders), which duplicated orders after the join. Scores are therefore averaged per order, so each order appears once.
- Delivered orders without a review are not part of the delivery analysis.
