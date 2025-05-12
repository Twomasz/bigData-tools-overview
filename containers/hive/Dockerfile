FROM openjdk:8-jdk

ARG HIVE_VERSION=3.1.3
ARG HADOOP_VERSION=3.4.0

ENV HIVE_VERSION=${HIVE_VERSION} \
    HADOOP_VERSION=${HADOOP_VERSION}

ENV JAVA_HOME=/usr/local/openjdk-8
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/hive-${HIVE_VERSION}
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop
ENV HIVE_CONF_DIR=${HIVE_HOME}/conf
ENV PATH=${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:${HIVE_HOME}/bin

RUN apt-get update && \
    apt-get install -y curl && \
    curl -SL https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -o /tmp/hadoop.tar.gz && \
    tar -xzf /tmp/hadoop.tar.gz -C /opt && \
    rm /tmp/hadoop.tar.gz && \
    rm -rf /var/lib/apt/lists/*

RUN curl -SL https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz -o /tmp/hive.tar.gz && \
    tar -xzf /tmp/hive.tar.gz -C /opt && \
    mv /opt/apache-hive-${HIVE_VERSION}-bin $HIVE_HOME && \
    rm /tmp/hive.tar.gz && \
    rm -rf /var/lib/apt/lists/*

COPY ./config/hive-site.xml $HIVE_CONF_DIR/hive-site.xml
COPY init-airline.sql /tmp/init-airline.sql
COPY init-metastore.sh /usr/local/bin/init-metastore.sh

RUN chmod +x /usr/local/bin/init-metastore.sh

EXPOSE 9083 10000

ENTRYPOINT [ "init-metastore.sh" ]