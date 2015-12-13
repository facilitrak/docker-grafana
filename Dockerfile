FROM quay.io/facilitrak/consul

ENV GRAFANA_VERSION 2.6.0-beta1
ADD https://grafanarel.s3.amazonaws.com/builds/grafana-${GRAFANA_VERSION}.linux-x64.tar.gz /grafana/grafana.tar.gz
WORKDIR /grafana
RUN apk --update add tar \
    && tar xf grafana.tar.gz --strip-components=1 \
    && rm grafana.tar.gz \
    && apk del --purge tar

COPY consul.json /etc/consul/
COPY run-grafana /bin/

ENV GF_SERVER_HTTP_PORT 80
ENV GF_SERVER_ENABLE_GZIP true

EXPOSE 80
VOLUME /grafana/data

CMD ["run-grafana"]
