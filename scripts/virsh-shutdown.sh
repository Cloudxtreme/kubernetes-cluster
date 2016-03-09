#!/bin/sh

echo "shutdown machines ..."
virsh shutdown kubernetes-master
virsh shutdown kubernetes-worker0
virsh shutdown kubernetes-worker1
virsh shutdown kubernetes-worker2

echo "done"
