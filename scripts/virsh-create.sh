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
--name kubernetes-master \
--disk /dev/mapper/system-node--master \
--filesystem /var/lib/libvirt/images/coreos/kubernetes-master/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/kubernetes-master/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:1f:3d:a9,type=bridge

echo "create virsh kubernetes-worker0 ..."
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
--name kubernetes-worker0 \
--disk /dev/mapper/system-node--worker0 \
--filesystem /var/lib/libvirt/images/coreos/kubernetes-worker0/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/kubernetes-worker0/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:0d:03:6a,type=bridge

echo "create virsh kubernetes-worker1 ..."
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
--name kubernetes-worker1 \
--disk /dev/mapper/system-node--worker1 \
--filesystem /var/lib/libvirt/images/coreos/kubernetes-worker1/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/kubernetes-worker1/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:cc:51:23,type=bridge

echo "create virsh kubernetes-worker2 ..."
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
--name kubernetes-worker2 \
--disk /dev/mapper/system-node--worker2 \
--filesystem /var/lib/libvirt/images/coreos/kubernetes-worker2/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/kubernetes-worker2/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:9d:5d:d8,type=bridge
