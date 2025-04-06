# Apache overview


### Download dataset
Go to [kaggle/airline-data](https://www.kaggle.com/datasets/bulter22/airline-data/code) and download the archive
```shell
mkdir -p ./data && cd ./data/
unzip airline-data.zip
```

### Setup environment
```shell
python -m venv venv
source venv/bin/activate
python -m pip install -r requirements.txt
```

### Cassandra

1. Build database container
```shell
cd ./containers/cassandra
docker build -t my-cassandra-img .
docker run --name my_cassandra -p 9042:9042 my-cassandra-img
sleep 180  # wait 3 mins to start running
docker exec -it my_cassandra cqlsh
```

2. Create keyspace in Cassandra
```sql
-- Create keyspace
CREATE KEYSPACE IF NOT EXISTS airline_data
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- Use the new keyspace
USE airline_data;

-- Create table
CREATE TABLE IF NOT EXISTS flights (
    flight_id UUID PRIMARY KEY,
    fl_date DATE,
    op_carrier TEXT,
    op_carrier_fl_num TEXT,
    origin TEXT,
    dest TEXT,
    crs_dep_time TEXT,
    dep_time TEXT,
    dep_delay FLOAT,
    taxi_out FLOAT,
    wheels_off TEXT,
    wheels_on TEXT,
    taxi_in FLOAT,
    crs_arr_time TEXT,
    arr_time TEXT,
    arr_delay FLOAT,
    cancelled BOOLEAN,
    cancellation_code TEXT,
    diverted BOOLEAN,
    crs_elapsed_time FLOAT,
    actual_elapsed_time FLOAT,
    air_time FLOAT,
    distance FLOAT,
    carrier_delay FLOAT,
    weather_delay FLOAT,
    nas_delay FLOAT,
    security_delay FLOAT,
    late_aircraft_delay FLOAT
);
```

3. Run **PySpark** locally
```shell
pyspark --packages com.datastax.spark:spark-cassandra-connector_2.12:3.5.0
```

### HBase

1. Build database container
```shell
cd ./containers/hbase
docker build -t my-hbase-img .
docker run -d --name my_hbase -p 16010:16010 -p 9090:9090 -p 8080:8080 my-hbase-img
sleep 60
docker exec -it my_hbase hbase shell
```

1. Run **pyspark** locally
```shell
pyspark --packages org.apache.hbase.connectors.spark:hbase-spark:2.4.8
```
