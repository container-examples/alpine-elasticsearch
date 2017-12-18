# ElasticSearch [![Build Status](https://drone.aurelienperrier.com/api/badges/Docker-example/alpine-elasticsearch/status.svg?branch=master)](https://drone.aurelienperrier.com/Docker-example/alpine-elasticsearch)

## Versions

Alpine : `3.7`   
ElasticSearch : `6.1.0`   

## Commands

Build : `docker build -t perriea/alpine-elasticsearch:3.7 .`   
Pull : `docker pull perriea/alpine-elasticsearch:3.7`   

Run : `docker run -d -p 9200:9200 -p 9300:9300 perriea/alpine-elasticsearch:3.7`