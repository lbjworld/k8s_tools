#!/bin/bash

source k8s.conf

sudo sh -c "docker -d -H ${DOCKER_BOOTSTRAP_SOCK} -p /var/run/docker-bootstrap.pid --iptables=false --ip-masq=false --bridge=none --graph=/var/lib/docker-bootstrap 2> /var/log/docker-bootstrap.log 1> /dev/null &"
