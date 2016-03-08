#!/bin/sh

echo "stopping machines ..."
virsh shutdown node-master
virsh shutdown node-worker0
virsh shutdown node-worker1
virsh shutdown node-worker2

echo "starting machines ..."
virsh start node-master
virsh start node-worker0
virsh start node-worker1
virsh start node-worker2

echo "done"
