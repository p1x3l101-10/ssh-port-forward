FROM alpine:latest

RUN apk add --no-cache bash
RUN mkdir /ssh

COPY ports.sh /entry

RUN chmod +x /entry

ENTRYPOINT ["/entry"]
