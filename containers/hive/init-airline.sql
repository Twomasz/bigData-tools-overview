CREATE EXTERNAL TABLE default.airline_data (
  actualelapsedtime        INT, 
  airtime                  INT, 
  arrdelay                 INT, 
  arrtime                  INT, 
  crsarrtime               INT, 
  crsdeptime               INT, 
  crselapsedtime           INT, 
  cancellationcode         STRING, 
  cancelled                INT, 
  carrierdelay             INT, 
  dayofweek                INT, 
  dayofmonth               INT, 
  depdelay                 INT, 
  deptime                  INT, 
  dest                     STRING, 
  distance                 INT, 
  diverted                 INT, 
  flightnum                INT, 
  lateaircraftdelay        INT, 
  month                    INT, 
  nasdelay                 INT, 
  origin                   STRING, 
  securitydelay            INT, 
  tailnum                  STRING, 
  taxiin                   INT, 
  taxiout                  INT, 
  uniquecarrier            STRING, 
  weatherdelay             INT, 
  year                     INT
)
ROW FORMAT SERDE
  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'field.delim'=',',
  'serialization.format'=','
)
STORED AS INPUTFORMAT
  'org.apache.hadoop.mapred.TextInputFormat'
OUTPUTFORMAT
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  'hdfs://host.docker.internal:9000/user/hive/warehouse/dataset'
TBLPROPERTIES (
  'bucketing_version'='2',
  'skip.header.line.count'='0'
);
