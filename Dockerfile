FROM openjdk:8-jre-slim

ENV BBTOOLS_VERSION 38.96
ENV BBTOOLS_URL https://sourceforge.net/projects/bbmap/files/BBMap_${BBTOOLS_VERSION}.tar.gz
ENV BBTOOLS_DIR /opt/bbtools

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${BBTOOLS_DIR} && \
    wget -q ${BBTOOLS_URL} -O /tmp/bbmap.tar.gz && \
    tar -xzf /tmp/bbmap.tar.gz -C ${BBTOOLS_DIR} --strip-components=1 && \
    rm /tmp/bbmap.tar.gz

ENV PATH ${BBTOOLS_DIR}:${PATH}

WORKDIR /data

CMD ["bbmap.sh"]