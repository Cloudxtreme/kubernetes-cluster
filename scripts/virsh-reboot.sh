#!/bin/sh

echo "reboot machines ..."
virsh reboot kubernetes-master
virsh reboot kubernetes-worker0
virsh reboot kubernetes-worker1
virsh reboot kubernetes-worker2

echo "done"
