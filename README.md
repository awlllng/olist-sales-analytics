# Olist E-commerce: Sales Overview, 2017

A portfolio project in SQL (BigQuery), Google Sheets and Tableau Public, based on the public Brazilian e-commerce dataset from Olist.

## Key findings

- **Revenue grew about 8.8x from January to November 2017** (111.8k to 987.8k BRL). November was the strongest month (16.6% of the year's revenue, +52% vs October). December fell 26.5% from that peak but stayed 12% above October. Total revenue from delivered orders in 2017: 5.96M BRL. *The November peak is probably seasonal (sales events), but one year of data cannot confirm it.*
- **Revenue is spread across many categories.** The top 3 are bed_bath_table (490.6k BRL), watches_gifts (475.6k) and health_beauty (473.8k), together 24% of revenue. The top 10 categories give 63%.
- **Orders are concentrated in a few states.** Sao Paulo (SP) alone places 39% of orders (17,071 of 43,428); SP, RJ and MG together place 65%, and the top 10 states 90%.
- **Late deliveries are linked to lower review scores.** 8% of reviewed delivered orders arrived late; their average score is 2.57 vs 4.29 for on-time orders, a gap of 1.7 points. This shows an association, not a proven cause.

## Dashboard

![Dashboard](images/dashboard.png)

[Open the interactive dashboard on Tableau Public](https://public.tableau.com/app/profile/maksym.tertyshnyi/viz/OlistE-commerce_17944926696140/OlistE-commerceSalesOverview2017)

## Limitations

- Only one year of data (2017), so seasonality is a hypothesis.
- Revenue only: the dataset has no cost data, so profit is not analysed.
- The delivery analysis includes only delivered orders that have a review, and the score difference does not prove that delays cause low scores.

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
