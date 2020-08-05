FROM docker.elastic.co/logstash/logstash:7.8.1

ADD ./conf/logstash.conf /config/logstash.conf
CMD ["logstash", "-f", "/config/logstash.conf"]
