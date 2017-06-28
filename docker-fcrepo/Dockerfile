FROM jetty:9.4.6-alpine

ENV FCREPO_VERSION 4.7.3
ENV JAVA_OPTIONS "${JAVA_OPTIONS} -Dfcrepo.modeshape.configuration=classpath:/config/file-simple/repository.json -Dfcrepo.home=/mnt/fedora-data"

RUN apk add --no-cache curl \
    && curl -fSsL -o $JETTY_BASE/webapps/ROOT.war \
    https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-$FCREPO_VERSION/fcrepo-webapp-$FCREPO_VERSION.war \
    && apk del curl \
    && mkdir /mnt/fedora-data \
    && chown -R jetty:jetty /mnt/fedora-data

VOLUME /mnt/fedora-data
EXPOSE 8080