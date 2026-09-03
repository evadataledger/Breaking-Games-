-- Validate expected grain: one row per product
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT product_id) AS distinct_products
FROM fact_product_performance;

-- Check for duplicate product IDs
SELECT
    product_id,
    COUNT(*) AS product_count
FROM fact_product_performance
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Check required columns for NULL values
SELECT
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_product_id,
    SUM(CASE WHEN product_title IS NULL THEN 1 ELSE 0 END) AS null_product_title,
    SUM(CASE WHEN total_sales IS NULL THEN 1 ELSE 0 END) AS null_total_sales,
    SUM(CASE WHEN net_items_sold IS NULL THEN 1 ELSE 0 END) AS null_net_items_sold,
    SUM(CASE WHEN aov IS NULL THEN 1 ELSE 0 END) AS null_aov,
    SUM(CASE WHEN total_pageviews IS NULL THEN 1 ELSE 0 END) AS null_total_pageviews
FROM fact_product_performance;
