FROM registry.alauda.cn/alaudasa/fluentd:0.12

### install plugins
USER root
RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo -u fluent gem install \
        fluent-plugin-elasticsearch \
        fluent-plugin-record-reformer \
 && sudo -u fluent gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem
USER fluent


ADD fluent.conf /fluentd/etc/fluent.conf
EXPOSE 24224
VOLUME /var/log-archives/

