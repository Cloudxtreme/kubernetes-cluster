#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

function generate_configs {
	echo "generate_configs started"

	# Avaiable Version:
	# https://gcr.io/v2/google-containers/hyperkube-amd64/tags/list
	# https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md
	K8S_VERSION="1.2.3"

	K8S_SERVICE_IP="10.103.0.1"
	SERVICE_NETWORK="10.103.0.0/16"
	POD_NETWORK="10.102.0.0/16"
	CLUSTER_DOMAIN="cluster.local"
	CLUSTER_DNS="10.103.0.10"
	CLUSTER_NAME="cluster-${REGION}"

	MASTER_IP=${NETWORK}.10
	STORAGE_IP=${NETWORK}.9

	DISK_CACHE=${DISK_CACHE:="none"}
	DISK_IO=${DISK_IO:="native"}

	STORAGE_SIZE=${STORAGE_SIZE:="10G"}
	NODE_SIZE=${NODE_SIZE:="10G"}
	DOCKER_SIZE=${DOCKER_SIZE:="10G"}
	WORKER_SIZE=${WORKER_SIZE:="10G"}
	WORKER_DOCKER_SIZE=${WORKER_DOCKER_SIZE:="10G"}

	DISK_PREFIX=${DISK_PREFIX:=""}
	VM_PREFIX=${VM_PREFIX:=""}

	MASTER_MEMORY=${MASTER_MEMORY:="1000"}
	STORAGE_MEMORY=${STORAGE_MEMORY:="750"}
	ETCD_MEMORY=${ETCD_MEMORY:="750"}
	WORKER_MEMORY=${WORKER_MEMORY:="3000"}

	WORKER_AMOUNT=${WORKER_AMOUNT:="3"}
	ETCD_AMOUNT=${ETCD_AMOUNT:="3"}

	BRIDGE=${BRIDGE:="privatebr0"}

	WORKER_CPU_CORES=${WORKER_CPU_CORES:="2"}
	STORAGE_CPU_CORES=${STORAGE_CPU_CORES:="2"}
	MASTER_CPU_CORES=${MASTER_CPU_CORES:="2"}
	ETCD_CPU_CORES=${ETCD_CPU_CORES:="2"}

	create_nodes
	copy_scripts
	echo "generate_configs finished"
}

function copy_scripts {
	echo "copy_scripts started"
	mkdir -p scripts
	SCRIPTS=$(cd template/scripts; ls -1)
	for f in $SCRIPTS
	do
		copy_script "$f"
	done
	chmod 644 scripts/*
	chmod 755 scripts/*.sh
	echo "copy_scripts finished"
}

function copy_script {
	echo "copy_script $1 started"
	render template/scripts/$1 > scripts/$1
	echo "copy_script $1 finished"
}

function generate_mac {
	printf "$MACPREFIX%02x" $1
}

function create_nodes {
	echo "create_nodes started"
	
	ETCD_ENDPOINTS=""
	INITIAL_CLUSTER=""
	for ((i=0; i < ETCD_AMOUNT; i++)) do
		value=$((15 + $i))
		if [ $i == 0 ]; then
			ETCD_ENDPOINTS="http://${NETWORK}.$value:2379"
			INITIAL_CLUSTER="kubernetes-etcd$i=http://${NETWORK}.$value:2380"
		else
			ETCD_ENDPOINTS="${ETCD_ENDPOINTS},http://${NETWORK}.$value:2379"
			INITIAL_CLUSTER="$INITIAL_CLUSTER,kubernetes-etcd$i=http://${NETWORK}.$value:2380"
		fi
	done

	create_node "master" "master" "10"
	create_node "storage" "storage" "9"
	for ((i=0; i < ETCD_AMOUNT; i++)) do
		value=$((15 + $i))
		create_node "etcd" "etcd$i" "$value"
	done
	for ((i=0; i < WORKER_AMOUNT; i++)) do
		value=$((20 + $i))
		create_node "worker" "worker$i" "$value"
	done
	echo "create_nodes finished"
}

function create_node {
	echo "create_nodes $2 started"
	HOSTNAME="kubernetes-$2"
	NODEIP="${NETWORK}.$3"
	NODENAME="${NODEIP}"
	NODEMAC=$(generate_mac "$3")
	create_ssl "kubernetes-$2"
	copy_user_data "kubernetes-$1" "kubernetes-$2"
	echo "create_nodes $2 finished"
}

function copy_user_data {
	echo "copy_user_data for $2 started"
	mkdir -p $2/config/openstack/latest
	render template/$1/config/openstack/latest/user_data > $2/config/openstack/latest/user_data
	echo "copy_user_data for $2 finished"
}

function create_ssl {
	echo "create_ssl for $1 started"
	mkdir -p $1/ssl
	touch $1/ssl/.keep
	echo "create_ssl for $1 finished"
}

function render {
  eval "echo \"$(cat $1)\""
}
