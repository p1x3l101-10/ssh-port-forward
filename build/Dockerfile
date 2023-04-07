FROM alpine:latest

RUN apk update && apk upgrade
RUN apk add --no-cache bash openssh-client-default
RUN rm -rf /var/cache/apk/*

COPY ports.sh /entry

RUN chmod +x /entry

ENTRYPOINT ["/entry"]
