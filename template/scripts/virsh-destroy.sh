#!/bin/sh

echo "destroying machines ..."
virsh destroy bb_kubernetes-master
virsh destroy bb_kubernetes-storage
virsh destroy bb_kubernetes-worker0
virsh destroy bb_kubernetes-worker1
virsh destroy bb_kubernetes-worker2

echo "undefine machines ..."
virsh undefine bb_kubernetes-master
virsh undefine bb_kubernetes-storage
virsh undefine bb_kubernetes-worker0
virsh undefine bb_kubernetes-worker1
virsh undefine bb_kubernetes-worker2
