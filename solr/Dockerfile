FROM golang:alpine as builder

RUN apk --no-cache add git

RUN CGO_ENABLED=0 GOOS=linux go get -a -installsuffix cgo -ldflags '-extldflags "-static"' \
    gitlab.oit.duke.edu/mclibrary/healthcheck

FROM solr:6.6.5-alpine

COPY --from=builder /go/bin/healthcheck /usr/local/bin/healthcheck

ENV HEALTHCHECK_URL "http://127.0.0.1:8983/solr/medspace/admin/ping"

HEALTHCHECK CMD ["/usr/local/bin/healthcheck"]

COPY config /config