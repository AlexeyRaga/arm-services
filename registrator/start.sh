#!/bin/bash

public_ip="$(ip ro | awk '/^default/{print $9}')"

docker run -d --name registrator \
           -v /var/run/docker.sock:/tmp/docker.sock \
           -h $HOSTNAME \
           alexeyraga/arm-registrator \
           consul://${public_ip}:8500