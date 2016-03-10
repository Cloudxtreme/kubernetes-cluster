#!/bin/sh

echo "reboot machines ..."
virsh reboot bb_kubernetes-master
virsh reboot bb_kubernetes-storage
virsh reboot bb_kubernetes-worker0
virsh reboot bb_kubernetes-worker1
virsh reboot bb_kubernetes-worker2

echo "done"
