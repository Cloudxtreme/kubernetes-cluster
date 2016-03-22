#!/bin/sh

echo \"reboot machines ...\"
virsh reboot ${VM_PREFIX}kubernetes-master
virsh reboot ${VM_PREFIX}kubernetes-storage
virsh reboot ${VM_PREFIX}kubernetes-worker0
virsh reboot ${VM_PREFIX}kubernetes-worker1
virsh reboot ${VM_PREFIX}kubernetes-worker2

echo \"done\"
