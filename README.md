## master

1. run_docker_bootstrap.sh
2. run_etcd.sh
3. stop docker
4. run_flannel.sh
5. run_k8s_master.sh
6. run_k8s_svc_proxy.sh
7. start docker

refer to [here](http://kubernetes.io/v1.1/docs/getting-started-guides/docker-multinode/master.html)


## worker

1. run_docker_bootstrap.sh
2. stop docker
3. run_flannel.sh <k8s_master_ip>
4. run_k8s_worker.sh <k8s_master_ip>
5. run_k8s_svc_proxy.sh <k8s_master_ip>
6. start docker

refer to [here](http://kubernetes.io/v1.1/docs/getting-started-guides/docker-multinode/worker.html)

> NOTICE: we use the default 'udp' backend, and must open firewall on port 8285 for UDP on all nodes including both master and worker
for flannel config details, refer to https://github.com/coreos/flannel


## TEST

refer to [here](http://kubernetes.io/v1.1/docs/getting-started-guides/docker-multinode/testing.html)

