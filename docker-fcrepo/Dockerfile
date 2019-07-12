FROM golang:alpine as builder

RUN apk --no-cache add git

RUN CGO_ENABLED=0 GOOS=linux go get -a -installsuffix cgo -ldflags '-extldflags "-static"' \
    gitlab.oit.duke.edu/mclibrary/healthcheck

FROM jetty:9.4.6-alpine

ENV FCREPO_VERSION 4.7.3
ENV JAVA_OPTIONS "${JAVA_OPTIONS} -Dfcrepo.modeshape.configuration=classpath:/config/file-simple/repository.json -Dfcrepo.home=/mnt/fedora-data"

RUN apk add --no-cache curl \
    && curl -fSsL -o $JETTY_BASE/webapps/ROOT.war \
    https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-$FCREPO_VERSION/fcrepo-webapp-$FCREPO_VERSION.war \
    && apk del curl \
    && mkdir /mnt/fedora-data \
    && chown -R jetty:jetty /mnt/fedora-data

COPY --from=builder /go/bin/healthcheck /usr/local/bin/healthcheck

ENV HEALTHCHECK_URL "http://127.0.0.1:8080/rest"

HEALTHCHECK CMD ["/usr/local/bin/healthcheck"]

VOLUME /mnt/fedora-data

EXPOSE 8080