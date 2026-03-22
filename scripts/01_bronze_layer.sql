CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;

CREATE TABLE bronze.taxi_zones (
    LocationID INT,
    Borough TEXT,
    Zone TEXT,
    service_zone TEXT
);

CREATE UNLOGGED TABLE bronze.raw_trips (
    VendorID INT,
    tpep_pickup_datetime TIMESTAMP,
    tpep_dropoff_datetime TIMESTAMP,
    passenger_count INT,
    trip_distance NUMERIC,
    RatecodeID INT,
    store_and_fwd_flag TEXT,
    PULocationID INT,
    DOLocationID INT,
    payment_type INT,
    fare_amount NUMERIC,
    extra NUMERIC,
    mta_tax NUMERIC,
    tip_amount NUMERIC,
    tolls_amount NUMERIC,
    improvement_surcharge NUMERIC,
    total_amount NUMERIC,
    congestion_surcharge NUMERIC 
);

COPY bronze.taxi_zones FROM 'C:\Users\Public\taxi_data\taxi+_zone_lookup.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-01.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-02.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-03.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-04.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-05.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-06.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-07.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-08.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-09.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-10.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-11.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2019-12.csv' WITH (FORMAT csv, HEADER true);

COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2020-01.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2020-02.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2020-03.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2020-04.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2020-05.csv' WITH (FORMAT csv, HEADER true);
COPY bronze.raw_trips FROM 'C:\Users\Public\taxi_data\yellow_tripdata_2020-06.csv' WITH (FORMAT csv, HEADER true);
