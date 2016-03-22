#!/bin/bash

function generate_configs {
	echo "generate_configs started"
	create_nodes
	echo "generate_configs finished"
}

function generate_mac {
	printf '00:16:3e:2f:06:%x' $1
}

function create_nodes {
	echo "create_nodes started"
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