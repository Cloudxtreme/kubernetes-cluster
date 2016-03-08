#!/bin/sh

echo "reboot machines ..."
virsh reboot node-master
virsh reboot node-worker0
virsh reboot node-worker1
virsh reboot node-worker2

echo "done"
