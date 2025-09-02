FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    qemu-system-x86 \
    qemu-utils \
    net-tools \
    && apt-get clean

RUN mkdir /data
WORKDIR /data

ENTRYPOINT [ "qemu-system-x86_64" ]

