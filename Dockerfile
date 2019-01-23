FROM openjdk:8u151-jre-alpine

LABEL org.label-schema.name="kafka" 

ARG kafka_version=2.1.0
ARG scala_version=2.12
ARG glibc_version=2.28-r0
ARG vcs_ref=unspecified
ARG build_date=unspecified

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka \
    GLIBC_VERSION=$glibc_version

ENV PATH=${PATH}:${KAFKA_HOME}/bin

COPY tmp/download-kafka.sh tmp/versions.sh tmp/start-kafka.sh tmp/server.properties.template /tmp/

RUN apk add --no-cache bash curl jq docker \
  && mkdir /opt \
  && chmod a+x /tmp/*.sh \
  && mv /tmp/start-kafka.sh /tmp/versions.sh /usr/bin \
  && sync && /tmp/download-kafka.sh \
  && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt \
  && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
  && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka \
  && mv /tmp/server.properties.template /opt/kafka/config/server.properties.template \
  && rm /opt/kafka/config/server.properties \
  && rm /tmp/* \
  && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
  && apk add --no-cache --allow-untrusted glibc-${GLIBC_VERSION}.apk \
  && rm glibc-${GLIBC_VERSION}.apk

EXPOSE 9092

CMD ["start-kafka.sh"]