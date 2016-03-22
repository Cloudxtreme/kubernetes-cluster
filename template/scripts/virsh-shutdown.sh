#!/bin/sh

echo \"shutdown machines ...\"
virsh shutdown bb_kubernetes-master
virsh shutdown bb_kubernetes-storage
virsh shutdown bb_kubernetes-worker0
virsh shutdown bb_kubernetes-worker1
virsh shutdown bb_kubernetes-worker2

echo \"done\"
