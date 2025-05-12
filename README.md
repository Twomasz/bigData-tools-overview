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

2. Upload data
```sql
-- Create keyspace
CREATE KEYSPACE IF NOT EXISTS airline_data
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- Use the new keyspace
USE airline_data;

-- Create table
CREATE TABLE IF NOT EXISTS flights (
    id UUID PRIMARY KEY,
    year INT,
    month INT,
    day_of_month INT,
    day_of_week INT,
    dep_time INT,
    crs_dep_time INT,
    arr_time INT,
    crs_arr_time INT,
    unique_carrier TEXT,
    flight_num INT,
    tail_num TEXT,
    actual_elapsed_time INT,
    crs_elapsed_time INT,
    air_time INT,
    arr_delay INT,
    dep_delay INT,
    origin TEXT,
    dest TEXT,
    distance INT,
    taxi_in INT,
    taxi_out INT,
    cancelled BOOLEAN,
    cancellation_code TEXT,
    diverted BOOLEAN,
    carrier_delay INT,
    weather_delay INT,
    nas_delay INT,
    security_delay INT,
    late_aircraft_delay INT
);
```

3. Run **PySpark** locally
```shell
pyspark --packages com.datastax.spark:spark-cassandra-connector_2.12:3.5.0
```

### HBase (not working)

1. Build database container
```shell
cd ./containers/hbase_min
docker build -t my-hbase-img .
docker run -d --name my_hbase -p 16010:16010 -p 9090:9090 -p 8080:8080 -p 16000:16000 -p 16301:16301 -p 2181:2181 my-hbase-img 
sleep 60
docker exec -it my_hbase hbase shell
```

2. Upload data
```shell
create 'test_table', 'cf'
put 'test_table', 'row1', 'cf:name', 'Alice'
put 'test_table', 'row2', 'cf:name', 'Bob'
put 'test_table', 'row3', 'cf:name', 'Charlie'
scan 'test_table'
```


3. Run **PySpark** locally
```shell
# pyspark --packages org.apache.hbase.connectors.spark:hbase-spark:1.0.1 --files /project_root/containers/hbase_min/hbase-site.xml
pyspark --packages org.apache.hbase.connectors.spark:hbase-spark:1.0.1 --files /home/tomek/programming/studies/sem2/ztbd/containers/hbase_min/hbase-site.xml 

# just in case add: --jars /path/to/hbase-client-2.4.17.jar,/path/to/hbase-protocol-2.4.17.jar
```

### Second try with docker-compose (not working)

```shell
docker run -d --name hbase --hostname hbase-docker \
  -p 2181:2181 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 \
  myhbase
```

```shell
# add host to /etc/hosts -> 127.0.0.1 hbase-docker
sudo sh -c 'echo "127.0.0.1 hbase-docker" >> /etc/hosts' 
```

```shell
pyspark --packages org.apache.hbase:hbase-client:2.5.4,\
org.apache.hbase:hbase-common:2.5.4,org.apache.hbase:hbase-mapreduce:2.5.4 
```

```python
conf = {"hbase.zookeeper.quorum": "hbase-docker",
        "hbase.zookeeper.property.clientPort": "2181",
        "hbase.mapreduce.inputtable": "NazwaTwojejTabeli"}
hbase_rdd = spark.sparkContext.newAPIHadoopRDD(
    "org.apache.hadoop.hbase.mapreduce.TableInputFormat",
    "org.apache.hadoop.hbase.io.ImmutableBytesWritable",
    "org.apache.hadoop.hbase.client.Result",
    conf=conf
)
hbase_rdd.collect()
```


### Snowflake
```shell
docker pull localstack/snowflake:latest
export LOCALSTACK_AUTH_TOKEN="ls-RuMEgARu-SiRu-6683-FaVa-XUcA2651435a"
localstack start
sudo sh -c 'echo "127.0.0.1 snowflake.localhost.localstack.cloud" >> /etc/hosts' 
```

```shell
pyspark --packages net.snowflake:snowflake-jdbc:3.19.0,net.snowflake:spark-snowflake_2.12:3.1.1
```