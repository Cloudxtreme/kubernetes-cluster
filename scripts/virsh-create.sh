#!/bin/sh

echo "create virsh node-master ..."
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
--name node-master \
--disk /dev/mapper/system-node--master \
--filesystem /var/lib/libvirt/images/coreos/node-master/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/node-master/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:1f:3d:a9,type=bridge

echo "create virsh node-worker0 ..."
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
--name node-worker0 \
--disk /dev/mapper/system-node--worker0 \
--filesystem /var/lib/libvirt/images/coreos/node-worker0/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/node-worker0/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:0d:03:6a,type=bridge

echo "create virsh node-worker1 ..."
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
--name node-worker1 \
--disk /dev/mapper/system-node--worker1 \
--filesystem /var/lib/libvirt/images/coreos/node-worker1/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/node-worker1/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:cc:51:23,type=bridge

echo "create virsh node-worker2 ..."
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
--name node-worker2 \
--disk /dev/mapper/system-node--worker2 \
--filesystem /var/lib/libvirt/images/coreos/node-worker2/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/node-worker2/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:9d:5d:d8,type=bridge
