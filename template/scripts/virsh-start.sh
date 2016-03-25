#!/bin/bash

echo \"starting machines ...\"
virsh start ${VM_PREFIX}kubernetes-master
virsh start ${VM_PREFIX}kubernetes-storage
virsh start ${VM_PREFIX}kubernetes-worker0
virsh start ${VM_PREFIX}kubernetes-worker1
virsh start ${VM_PREFIX}kubernetes-worker2

echo \"done\"
