#!/bin/sh

echo "create virsh kubernetes-master ..."
virt-install \
--import \
--debug \
--serial pty \
--accelerate \
--ram 1024 \
--vcpus 2 \
--os-type linux \
--os-variant virtio26 \
--noautoconsole \
--nographics \
--name bb_kubernetes-master \
--disk /dev/vg0/bb_kubernetes-master \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-master/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-master/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:2f:30:a,type=bridge

echo "create virsh kubernetes-storage ..."
virt-install \
--import \
--debug \
--serial pty \
--accelerate \
--ram 256 \
--vcpus 2 \
--os-type linux \
--os-variant virtio26 \
--noautoconsole \
--nographics \
--name bb_kubernetes-storage \
--disk /dev/vg0/bb_kubernetes-storage \
--disk /dev/vg0/bb_kubernetes-storage-data \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-storage/config/,config-2,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:2f:30:9,type=bridge

echo "create virsh kubernetes-worker0 ..."
virt-install \
--import \
--debug \
--serial pty \
--accelerate \
--ram 2048 \
--vcpus 2 \
--os-type linux \
--os-variant virtio26 \
--noautoconsole \
--nographics \
--name bb_kubernetes-worker0 \
--disk /dev/vg0/bb_kubernetes-worker0 \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker0/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker0/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:2f:30:14,type=bridge

echo "create virsh kubernetes-worker1 ..."
virt-install \
--import \
--debug \
--serial pty \
--accelerate \
--ram 2048 \
--vcpus 2 \
--os-type linux \
--os-variant virtio26 \
--noautoconsole \
--nographics \
--name bb_kubernetes-worker1 \
--disk /dev/vg0/bb_kubernetes-worker1 \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker1/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker1/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:2f:30:15,type=bridge

echo "create virsh kubernetes-worker2 ..."
virt-install \
--import \
--debug \
--serial pty \
--accelerate \
--ram 2048 \
--vcpus 2 \
--os-type linux \
--os-variant virtio26 \
--noautoconsole \
--nographics \
--name bb_kubernetes-worker2 \
--disk /dev/vg0/bb_kubernetes-worker2 \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker2/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker2/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:2f:30:16,type=bridge
