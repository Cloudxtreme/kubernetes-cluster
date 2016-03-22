#!/bin/sh

echo \"shutdown machines ...\"
virsh shutdown ${VM_PREFIX}kubernetes-master
virsh shutdown ${VM_PREFIX}kubernetes-storage
virsh shutdown ${VM_PREFIX}kubernetes-worker0
virsh shutdown ${VM_PREFIX}kubernetes-worker1
virsh shutdown ${VM_PREFIX}kubernetes-worker2

echo \"done\"
