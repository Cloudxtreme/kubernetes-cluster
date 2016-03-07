#!/bin/sh

echo "destroying machines ..."
virsh destroy node-master
virsh destroy node-worker0
virsh destroy node-worker1
virsh destroy node-worker2

echo "undefine machines ..."
virsh undefine node-master
virsh undefine node-worker0
virsh undefine node-worker1
virsh undefine node-worker2
