#!/bin/bash

if [ ! -d "$HIVE_HOME/metastore_db" ]; then
  schematool -dbType derby -initSchema
  hive --service metastore &
  sleep 2
  hive -f /tmp/init-airline.sql
  hive --service hiveserver2
  rm /tmp/init-airline.sql
else
    hive --service metastore &
    hive --service hiveserver2
fi


