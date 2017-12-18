#!/bin/sh

chown -R elastic:elastic /usr/share/elasticsearch
exec su-exec elastic sh /usr/share/elasticsearch/bin/elasticsearch