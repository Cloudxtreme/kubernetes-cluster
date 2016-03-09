#!/bin/sh

echo "starting machines ..."
virsh start kubernetes-master
virsh start kubernetes-worker0
virsh start kubernetes-worker1
virsh start kubernetes-worker2

echo "done"
