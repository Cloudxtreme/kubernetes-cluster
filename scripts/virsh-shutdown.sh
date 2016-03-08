#!/bin/sh

echo "shutdown machines ..."
virsh shutdown node-master
virsh shutdown node-worker0
virsh shutdown node-worker1
virsh shutdown node-worker2

echo "done"
