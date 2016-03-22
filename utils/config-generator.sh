#!/bin/bash

function generate_configs {
	echo "generate_configs started"
	create_directories
	echo "generate_configs finished"
}

function create_directories {
	echo "create_directories started"
	mkdir -p kubernetes-master/config kubernetes-master/ssl
	mkdir -p kubernetes-storage/config kubernetes-storage/ssl
	for ((i=0; i < WORKER_AMOUNT; i++)) do
		mkdir -p kubernetes-worker${i}/config kubernetes-worker${i}/ssl
	done
	echo "create_directories finished"
}


function render {
  eval "echo \"$(cat $1)\""
}