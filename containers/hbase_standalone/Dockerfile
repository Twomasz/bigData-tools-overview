FROM openjdk:8-jdk-slim

ENV HBASE_VERSION=2.5.11
ENV HBASE_HOME=/opt/hbase

WORKDIR /opt

# Instalacja narzędzi + pobranie HBase
RUN apt-get update && apt-get install -y wget tar procps nano && \
    wget -q https://downloads.apache.org/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz && \
    tar -xzf hbase-${HBASE_VERSION}-bin.tar.gz && \
    mv hbase-${HBASE_VERSION} hbase && \
    rm hbase-${HBASE_VERSION}-bin.tar.gz

# Skopiuj plik konfiguracyjny
COPY hbase-site.xml ${HBASE_HOME}/conf/hbase-site.xml

# Dodaj bin do PATH, aby działały np. hbase shell
ENV PATH="${HBASE_HOME}/bin:$PATH"

# Wystaw porty
EXPOSE 2181 16000 16010 16020 16030

# Uruchomienie HBase + log tail, aby kontener był aktywny
# CMD ${HBASE_HOME}/bin/start-hbase.sh && tail -f ${HBASE_HOME}/logs/hbase-*-master-*.log

CMD ["/bin/sh", "-c", "/opt/hbase/bin/start-hbase.sh"]
# 