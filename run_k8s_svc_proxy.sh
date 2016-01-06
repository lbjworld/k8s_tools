#!/bin/bash

if [ "$1" == "" ]; then
    MASTER_IP="127.0.0.1"
else
    MASTER_IP=$1
fi

source k8s.conf

docker run -d \
    --net=host \
    --privileged \
    --name ${K8S_SVC_PROXY_CONTAINER_NAME} \
    ${K8S_IMAGE} /hyperkube proxy --master=http://${MASTER_IP}:8080 --v=2
