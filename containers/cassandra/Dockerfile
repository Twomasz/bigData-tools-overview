# Use the official Cassandra base image
FROM cassandra:4.0

# Set environment variables
ENV CASSANDRA_CLUSTER_NAME=TestCluster
ENV CASSANDRA_START_RPC=true

# Expose the default Cassandra CQL port
EXPOSE 9042

# Define a volume for Cassandra data
VOLUME /var/lib/cassandra

# Command to start Cassandra
CMD ["cassandra", "-f"]

