#!/bin/sh

echo "starting machines ..."
virsh start node-master
virsh start node-worker0
virsh start node-worker1
virsh start node-worker2

echo "done"
