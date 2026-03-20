DROP TABLE IF EXISTS gold.fact_neighborhood_analysis;

CREATE TABLE gold.fact_neighborhood_analysis AS
SELECT 
    z.Borough AS district,
    z.Zone AS area,
    t.payment_method_name,
    COUNT(*) AS total_trips,
    ROUND(AVG(t.tip_amount), 2) AS avg_tip,
    ROUND(AVG(t.total_amount), 2) AS avg_total_fare,
    ROUND(AVG(t.tip_amount / NULLIF(t.total_amount, 0)) * 100, 2) AS tip_percentage,
    SUM(t.total_amount) AS total_revenue
FROM silver.trips_cleaned t
JOIN silver.dim_zones z ON t.PULocationID = z.LocationID
WHERE t.payment_type = 1 -- Credit Card
GROUP BY z.Borough, z.Zone, t.payment_method_name
HAVING COUNT(*) > 1000
ORDER BY avg_tip DESC;

DROP TABLE IF EXISTS gold.report_monthly_trends;

CREATE TABLE gold.report_monthly_trends AS
SELECT 
    DATE_TRUNC('month', pickup_time) AS month_period,
    COUNT(*) AS trips_count,
    ROUND(SUM(total_amount), 2) AS monthly_revenue,
    ROUND(AVG(trip_distance), 2) AS avg_distance_miles
FROM silver.trips_cleaned
GROUP BY month_period
ORDER BY month_period;


SELECT * FROM gold.fact_neighborhood_analysis LIMIT 10;

SELECT * FROM gold.report_monthly_trends;

-- Pandemic Impact
SELECT 
    ROUND(AVG(CASE WHEN pickup_time < '2020-01-01' THEN tip_amount END), 2) as avg_tip_2019,
    ROUND(AVG(CASE WHEN pickup_time >= '2020-01-01' THEN tip_amount END), 2) as avg_tip_2020,
    ROUND(
        (AVG(CASE WHEN pickup_time < '2020-01-01' THEN tip_amount END) - 
         AVG(CASE WHEN pickup_time >= '2020-01-01' THEN tip_amount END)) / 
         AVG(CASE WHEN pickup_time < '2020-01-01' THEN tip_amount END) * 100, 2
    ) as tip_drop_percentage
FROM silver.trips_cleaned
WHERE payment_type = 1;