#!/bin/bash

public_ip="$(ip ro | awk '/^default/{print $9}')"

docker run -d --name consul -h $HOSTNAME \
    -v /mnt/consul:/data \
    -p 8300:8300 \
    -p 8301:8301 -p 8301:8301/udp \
    -p 8302:8302 -p 8302:8302/udp \
    -p 8400:8400 \
    -p 8500:8500 \
    -p 53:53 -p 53:53/udp \
    alexeyraga/arm-consul -advertise $public_ip -server --bootstrap "$@"