#!/bin/bash

if [ "$1" == "" ]; then
    echo "input <master_ip>"
    exit 1
fi
MASTER_IP=$1

source k8s.conf

sudo docker run \
    --volume=/:/rootfs:ro \
    --volume=/sys:/sys:ro \
    --volume=/dev:/dev \
    --volume=/var/lib/docker/:/var/lib/docker:rw \
    --volume=/var/lib/kubelet/:/var/lib/kubelet:rw \
    --volume=/var/run:/var/run:rw \
    --net=host \
    --privileged=true \
    --pid=host \ 
    -d \
    --name ${K8S_WORKER_CONTAINER_NAME} \
    ${K8S_IMAGE} /hyperkube kubelet --api-servers=http://${MASTER_IP}:${K8S_MASTER_PORT} --v=2 --address=0.0.0.0 --enable-server --hostname-override=$(hostname -i) --cluster-dns=10.0.0.10 --cluster-domain=cluster.local
