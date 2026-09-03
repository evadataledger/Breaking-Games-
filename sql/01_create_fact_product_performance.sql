DROP TABLE IF EXISTS fact_product_performance;

CREATE TABLE fact_product_performance AS
SELECT
    dp.product_id,
    dp.product_title,
    COALESCE(ss.total_sales, 0.0) AS total_sales,
    COALESCE(ss.net_items_sold, 0) AS net_items_sold,
    CASE
        WHEN COALESCE(ss.net_items_sold, 0) = 0 THEN 0.0
        ELSE COALESCE(ss.total_sales, 0.0) / ss.net_items_sold
    END AS aov,
    COALESCE(
        (
            SELECT SUM(r.pageviews)
            FROM referrals r
            WHERE r.landing_page = '/products/' || dp.product_slug
        ),
        0
    ) AS total_pageviews
FROM dim_product AS dp
LEFT JOIN shopify_sales AS ss
    ON ss.product_id = dp.product_id;
