#!/bin/bash

echo \"starting machines ...\"
virsh start ${VM_PREFIX}kubernetes-master
virsh start ${VM_PREFIX}kubernetes-storage
for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	virsh start ${VM_PREFIX}kubernetes-etcd\${i}
done
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	virsh start ${VM_PREFIX}kubernetes-worker\${i}
done

echo \"done\"
