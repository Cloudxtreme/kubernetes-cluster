#!/bin/sh

echo "destroying machines ..."
virsh destroy kubernetes-master
virsh destroy kubernetes-worker0
virsh destroy kubernetes-worker1
virsh destroy kubernetes-worker2

echo "undefine machines ..."
virsh undefine kubernetes-master
virsh undefine kubernetes-worker0
virsh undefine kubernetes-worker1
virsh undefine kubernetes-worker2
