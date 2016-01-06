#!/bin/bash

if [ "$1" != "" ]; then
    MASTER_IP=$1
fi

source k8s.conf

# run flannel
if [ "${MASTER_IP}" == "" ]; then
    sudo docker -H ${DOCKER_BOOTSTRAP_SOCK} run \
        --name ${FLANNEL_CONTAINER_NAME} \
        -d --net=host --privileged -v /dev/net:/dev/net \
        ${FLANNEL_IMAGE}
else
    sudo docker -H ${DOCKER_BOOTSTRAP_SOCK} run \
        --name ${FLANNEL_CONTAINER_NAME} \
        -d --net=host --privileged -v /dev/net:/dev/net \
        --etcd-endpoints=http://${MASTER_IP}:${ETCD_PORT} \
        ${FLANNEL_IMAGE}
fi
echo "run flannel success."
# print flannel subnet setting
echo "flannel info:"
sudo docker -H ${DOCKER_BOOTSTRAP_SOCK} exec ${FLANNEL_CONTAINER_NAME} cat /run/flannel/subnet.env
