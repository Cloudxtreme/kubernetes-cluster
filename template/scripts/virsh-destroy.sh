#!/bin/bash

echo \"destroying machines ...\"
virsh destroy ${VM_PREFIX}kubernetes-master
virsh destroy ${VM_PREFIX}kubernetes-storage
virsh destroy ${VM_PREFIX}kubernetes-worker0
virsh destroy ${VM_PREFIX}kubernetes-worker1
virsh destroy ${VM_PREFIX}kubernetes-worker2

echo \"undefine machines ...\"
virsh undefine ${VM_PREFIX}kubernetes-master
virsh undefine ${VM_PREFIX}kubernetes-storage
virsh undefine ${VM_PREFIX}kubernetes-worker0
virsh undefine ${VM_PREFIX}kubernetes-worker1
virsh undefine ${VM_PREFIX}kubernetes-worker2
