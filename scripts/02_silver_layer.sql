CREATE TABLE silver.dim_zones AS
SELECT 
    LocationID,
    Borough,
    Zone,
    TRIM(service_zone) AS service_zone
FROM bronze.taxi_zones;

ALTER TABLE silver.dim_zones ADD PRIMARY KEY (LocationID);


CREATE TABLE silver.trips_cleaned AS
SELECT 
    VendorID,
    tpep_pickup_datetime AS pickup_time,
    tpep_dropoff_datetime AS dropoff_time,
    (tpep_dropoff_datetime - tpep_pickup_datetime) AS duration,
    passenger_count,
    trip_distance,
    PULocationID,
    DOLocationID,
    payment_type,
    fare_amount,
    tip_amount,
    tolls_amount,
    total_amount,
    congestion_surcharge,
    CASE 
        WHEN payment_type = 1 THEN 'Credit Card' 
        WHEN payment_type = 2 THEN 'Cash' 
        ELSE 'Other' 
    END AS payment_method_name
FROM bronze.raw_trips
WHERE tpep_pickup_datetime >= '2019-01-01 00:00:00'::TIMESTAMP 
  AND tpep_pickup_datetime <  '2020-07-01 00:00:00'::TIMESTAMP
  AND total_amount > 0 
  AND trip_distance > 0
  AND passenger_count > 0
  AND tpep_dropoff_datetime > tpep_pickup_datetime;

CREATE INDEX idx_silver_pickup ON silver.trips_cleaned(pickup_time);
CREATE INDEX idx_silver_pulocation ON silver.trips_cleaned(PULocationID);
CREATE INDEX idx_silver_payment ON silver.trips_cleaned(payment_type);