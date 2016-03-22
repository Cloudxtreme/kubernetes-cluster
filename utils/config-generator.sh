#!/bin/bash

WORKER_AMOUNT=3

function generate_configs {
	echo "generate_configs started"
	create_directories
	echo "generate_configs finished"
}

function create_directories {
	echo "create_directories started"
	create_ssl "kubernetes-master"
	copy_user_data "kubernetes-master"
	create_ssl "kubernetes-storage"
	copy_user_data "kubernetes-storage"
	for ((i=0; i < WORKER_AMOUNT; i++)) do
		create_ssl "kubernetes-worker$i"
		copy_user_data "kubernetes-worker$i"
	done
	echo "create_directories finished"
}

function copy_user_data {
	echo "copy_user_data for $1 started"
	mkdir -p $1/config/openstack/latest
	render template/$1/config/openstack/latest/user_data > $1/config/openstack/latest/user_data
	echo "copy_user_data for $1 finished"
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