FROM alpine:3.7

LABEL MAINTAINER="Aurelien PERRIER <a.perrier89@gmail.com>"
LABEL APP="elasticsearch"
LABEL APP_VERSION="6.0.0"
LABEL APP_REPOSITORY="https://github.com/elastic/elasticsearch/releases"

ENV TIMEZONE Europe/Paris
ENV VERSION 6.0.0
ENV PATH /usr/share/elasticsearch/bin:$PATH

# Install dependencies && tmp
RUN apk add --no-cache openjdk8-jre su-exec bash

WORKDIR /scripts
ADD https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}.tar.gz ./
RUN addgroup elasticsearch && \
      adduser -s /bin/false -G elasticsearch -S -D elasticsearch

# Download & install binary
RUN tar -C . -xzf elasticsearch-${VERSION}.tar.gz && \
      mv elasticsearch-${VERSION} /usr/share/elasticsearch && \
      mkdir -p /usr/share/elasticsearch/data /usr/share/elasticsearch/logs /usr/share/elasticsearch/config /usr/share/elasticsearch/config/scripts /usr/share/elasticsearch/plugins && \
      chown -R elasticsearch:elasticsearch /usr/share/elasticsearch && \
      rm elasticsearch-${VERSION}.tar.gz

# Copy configuration
COPY ./files/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY ./scripts/start.sh start.sh

VOLUME ["/usr/share/elasticsearch/data"]

EXPOSE 9200 9300

ENTRYPOINT ["./start.sh"]
CMD ["elasticsearch"]