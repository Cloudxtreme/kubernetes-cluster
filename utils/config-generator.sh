#!/bin/bash

function generate_configs {
	echo "generate_configs started"
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
	echo "copy_scripts finished"
}

function copy_script {
	echo "copy_script $1 started"
	render template/scripts/$1 > scripts/$1
	echo "copy_script $1 finished"
}

function generate_mac {
	printf "$MACPREFIX%x" $1
}

function create_nodes {
	echo "create_nodes started"
	
	ETCD="http://$NETWORK.10:2379,http://$NETWORK.9:2379"
	INITIAL_CLUSTER="kubernetes-master=http://$NETWORK.10:2380,kubernetes-storage=http://$NETWORK.9:2380"
	for ((i=0; i < WORKER_AMOUNT; i++)) do
		value=$((20 + $i))
		ETCD="$ETCD,http://$NETWORK.$value:2379"
		INITIAL_CLUSTER="$INITIAL_CLUSTER,kubernetes-worker$i=http://$NETWORK.$value:2380"
	done

	create_node "kubernetes-master" "kubernetes-master" "10"
	create_node "kubernetes-storage" "kubernetes-storage" "9"
	for ((i=0; i < WORKER_AMOUNT; i++)) do
		value=$((20 + $i))
		create_node "kubernetes-worker" "kubernetes-worker$i" "$value"
	done
	echo "create_nodes finished"
}

function create_node {
	echo "create_nodes $2 started"
	NODENAME=$2
	NODEIP="$NETWORK.$3"
	NODEMAC=$(generate_mac "$3")
	create_ssl $2
	copy_user_data $1 $2
	echo "create_nodes $2 finished"
}

function copy_user_data {
	echo "copy_user_data for $2 started"
	mkdir -p $1/config/openstack/latest
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