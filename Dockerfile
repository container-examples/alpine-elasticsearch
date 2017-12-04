FROM alpine:3.6

LABEL MAINTAINER="Aurelien PERRIER <perrie_a@etna-alternance.net>"
LABEL APP="elasticsearch"
LABEL APP_VERSION="6.0.0"
LABEL APP_REPOSITORY="https://github.com/elastic/elasticsearch/releases"
LABEL APP_DESCRIPTION="logging"

ENV TIMEZONE Europe/Paris
ENV VERSION 6.0.0
ENV PATH /usr/share/elasticsearch/bin:$PATH

# Install dependencies && tmp
RUN apk add --no-cache openjdk8-jre su-exec bash \
  && apk add --no-cache -t .build-deps wget

# Download & install binary
RUN echo "===> Install Elasticsearch..." \
  && cd /tmp \
  && wget --no-check-certificate -q -O elasticsearch.tar.gz "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}.tar.gz" \
  && tar -xf elasticsearch.tar.gz \
  && mv elasticsearch-$VERSION /usr/share/elasticsearch \
  && adduser -D -h /usr/share/elasticsearch elasticsearch

# Create paths & uninstall tmp dependencies
RUN echo "===> Creating Elasticsearch Paths..." \
  && mkdir -p /usr/share/elasticsearch/data /usr/share/elasticsearch/logs /usr/share/elasticsearch/config /usr/share/elasticsearch/config/scripts /usr/share/elasticsearch/plugins \
  && chown -R elasticsearch:elasticsearch /usr/share/elasticsearch \
  && rm -rf /tmp/* \
  && apk del --purge .build-deps

# Copy configuration
COPY ./files /usr/share/elasticsearch/config
COPY ./scripts/start.sh /

WORKDIR /usr/share/elasticsearch

VOLUME ["/usr/share/elasticsearch/data"]

EXPOSE 9200 9300

ENTRYPOINT ["/start.sh"]
CMD ["elasticsearch"]