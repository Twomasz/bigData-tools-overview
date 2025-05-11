FROM harisekhon/hbase:latest

# Set environment variables for standalone mode
ENV HBASE_CONF_hbase_cluster_distributed=true
ENV HBASE_CONF_hbase_zookeeper_property_clientPort=2181
ENV HBASE_CONF_hbase_zookeeper_quorum=localhost
ENV HBASE_CONF_hbase_rootdir=file:///hbase-data

COPY ./hbase-site.xml hbase-2.1.3/conf/hbase-site.xml

# Expose HBase Web UI and Thrift ports
EXPOSE 16010 9090 8080

# Expose the necessary ports
EXPOSE 16000 16301 2181

# Start HBase in standalone mode
# CMD ["hbase", "master", "start", "--foreground"]

# Command to start HBase and Thrift server
# CMD ["sh", "-c", "hbase master start --foreground & hbase thrift start -p 9090"]