FROM ubuntu:latest

RUN apt-get update && apt-get -y install nano curl libtool automake autoconf curl python2-minimal build-essential

COPY ./lisksdk.sh /app/.lisksdk.sh
RUN chmod +x /app/.lisksdk.sh
RUN /app/.lisksdk.sh

WORKDIR /app