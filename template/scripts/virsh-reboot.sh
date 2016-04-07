#!/bin/bash

echo \"reboot machines ...\"
virsh reboot ${VM_PREFIX}kubernetes-master
virsh reboot ${VM_PREFIX}kubernetes-storage
for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	virsh reboot ${VM_PREFIX}kubernetes-etcd\${i}
done
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	virsh reboot ${VM_PREFIX}kubernetes-worker\${i}
done

echo \"done\"
