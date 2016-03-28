#!/bin/bash

echo \"destroying machines ...\"
virsh destroy ${VM_PREFIX}kubernetes-master
virsh destroy ${VM_PREFIX}kubernetes-storage
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	virsh destroy ${VM_PREFIX}kubernetes-worker\${i}
done
