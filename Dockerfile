FROM openjdk:8-jre
MAINTAINER Sumit Bagga <bigdatasumit@gmail.com>


ARG NIFI_VERSION=1.12.1
ARG BASE_URL=http://archive.apache.org/dist/nifi
ARG MIRROR_BASE_URL=${MIRROR_BASE_URL:-${BASE_URL}}

ENV NIFI_HOME=/opt/nifi
ENV JAVA_HOME=/usr/local/openjdk-8
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/openjdk-8/bin
ENV BASE_URL=http://archive.apache.org/dist/nifi
ENV NIFI_VERSION=1.12.1

ADD start_nifi.sh /${NIFI_HOME}/

RUN apt-get install bash

RUN mkdir -p ${NIFI_HOME} && curl ${BASE_URL}/${NIFI_VERSION}/nifi-${NIFI_VERSION}-bin.tar.gz | tar xvz -C ${NIFI_HOME} && mv ${NIFI_HOME}/nifi-${NIFI_VERSION}/* ${NIFI_HOME} && rm -rf ${NIFI_HOME}/nifi-${NIFI_VERSION} && rm -rf *.tar.gz


EXPOSE 8080 8081 8443

VOLUME [${NIFI_HOME}/logs ${NIFI_HOME}/flowfile_repository ${NIFI_HOME}/database_repository ${NIFI_HOME}/content_repository ${NIFI_HOME}/provenance_repository]

ENV BANNER_TEXT= S2S_PORT=

WORKDIR ${NIFI_HOME}
RUN chmod +x ./start_nifi.sh
CMD ./start_nifi.sh
