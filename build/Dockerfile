FROM alpine:latest

RUN apk add --no-cache bash tinyssh
RUN mkdir /ssh

COPY ports.sh /entry

RUN chmod +x /entry

ENTRYPOINT ["/entry"]
