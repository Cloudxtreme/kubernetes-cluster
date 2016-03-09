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
--disk /dev/vg0/kubernetes-master \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-master/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-master/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:2f:06:41,type=bridge

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
--disk /dev/vg0/kubernetes-worker0 \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker0/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker0/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:fe:ab:50,type=bridge

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
--disk /dev/vg0/kubernetes-worker1 \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker1/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker1/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:14:36:8d,type=bridge

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
--disk /dev/vg0/kubernetes-worker2 \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker2/config/,config-2,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker2/ssl/,kubernetes-ssl,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:00:8d:91,type=bridge
