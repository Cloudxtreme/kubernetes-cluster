#!/bin/bash

function generate_configs {
	echo "generate_configs started"

  # Avaiable Version: https://gcr.io/v2/google-containers/hyperkube-amd64/tags/list
	K8S_VERSION="1.2.0"

	K8S_SERVICE_IP="10.103.0.1"
	SERVICE_NETWORK="10.103.0.0/16"
	POD_NETWORK="10.102.0.0/16"
	CLUSTER_DOMAIN="cluster.local"
	CLUSTER_DNS="10.103.0.10"
	CLUSTER_NAME="cluster-${REGION}"

	MASTER_IP=${NETWORK}.10
	STORAGE_IP=${NETWORK}.9

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
	
	ETCD_ENDPOINTS="http://${MASTER_IP}:2379,http://${STORAGE_IP}:2379"
	INITIAL_CLUSTER="kubernetes-master=http://${NETWORK}.10:2380,kubernetes-storage=http://${STORAGE_IP}:2380"
	for ((i=0; i < WORKER_AMOUNT; i++)) do
		value=$((20 + $i))
		ETCD_ENDPOINTS="${ETCD_ENDPOINTS},http://${NETWORK}.$value:2379"
		INITIAL_CLUSTER="$INITIAL_CLUSTER,kubernetes-worker$i=http://${NETWORK}.$value:2380"
	done

	create_node "master" "master" "10"
	create_node "storage" "storage" "9"
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