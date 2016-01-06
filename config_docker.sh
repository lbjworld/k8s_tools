#!/bin/bash

source k8s.conf

export `sudo docker -H ${DOCKER_BOOTSTRAP_SOCK} exec ${FLANNEL_CONTAINER_NAME} cat /run/flannel/subnet.env`

# modify docker daemon config
echo "DOCKER_OPTS=\"--bip=${FLANNEL_SUBNET} --mtu=${FLANNEL_MTU}\"" >> /etc/default/docker
printf "change docker daemon config.\n"

# remove docker0 bridge
DOCKER_BRIDGE="docker0"
if type "brctl" &> /dev/null; then
    printf 'brctl found.\n'
else
    printf 'brctl not found, install brctl.\n'
    sudo apt-get install -y bridge-utils
fi
# bring down default bridge
sudo /sbin/ifconfig ${DOCKER_BRIDGE} down
#sudo brctl delbr ${DOCKER_BRIDGE}
printf "config docker success.\n"
