#!/bin/sh

echo \"starting machines ...\"
virsh start bb_kubernetes-master
virsh start bb_kubernetes-storage
virsh start bb_kubernetes-worker0
virsh start bb_kubernetes-worker1
virsh start bb_kubernetes-worker2

echo \"done\"
