#!/bin/bash

source k8s.conf

# run etcd on docker-bootstrap
sudo docker -H ${DOCKER_BOOTSTRAP_SOCK} run \
    --net=host \
    --name=${ETCD_CONTAINER_NAME} \
    -d ${ETCD_IMAGE} /usr/local/bin/etcd --addr=127.0.0.1:${ETCD_PORT} --bind-addr=0.0.0.0:${ETCD_PORT} --data-dir=/var/etcd/data
sleep 10
echo "run etcd success"
# config etcd
sudo docker -H ${DOCKER_BOOTSTRAP_SOCK} run \
    --net=host ${ETCD_IMAGE} etcdctl set ${ETCD_INIT_KEY} "${ETCD_INIT_VALUE}"
echo "config etcd success"
