#!/bin/sh

cd /tmp

echo "downloading image ..."
#wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > coreos_production_qemu_image.img
wget http://beta.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > coreos_production_qemu_image.img
#wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > coreos_production_qemu_image.img

echo "converting image ..."
qemu-img convert coreos_production_qemu_image.img -O raw coreos_production_qemu_image.raw

echo "create lvm volumes ..."
lvcreate -L 10G -n node-master system
lvcreate -L 10G -n node-worker0 system
lvcreate -L 10G -n node-worker1 system
lvcreate -L 10G -n node-worker2 system

echo "writing images ..."
dd bs=1M iflag=direct oflag=direct if=coreos_production_qemu_image.raw of=/dev/system/node-master
dd bs=1M iflag=direct oflag=direct if=coreos_production_qemu_image.raw of=/dev/system/node-worker0
dd bs=1M iflag=direct oflag=direct if=coreos_production_qemu_image.raw of=/dev/system/node-worker1
dd bs=1M iflag=direct oflag=direct if=coreos_production_qemu_image.raw of=/dev/system/node-worker2

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
--filesystem /var/lib/libvirt/images/coreos/node-master/etc/kubernetes/,etc-kubernetes,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/node-master/srv/kubernetes/,srv-kubernetes/,type=mount,mode=squash \
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
--filesystem /var/lib/libvirt/images/coreos/node-worker0/etc/kubernetes/,etc-kubernetes/,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/node-worker0/srv/kubernetes/,srv-kubernetes/,type=mount,mode=squash \
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
--filesystem /var/lib/libvirt/images/coreos/node-worker1/etc/kubernetes/,etc-kubernetes/,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/node-worker1/srv/kubernetes/,srv-kubernetes/,type=mount,mode=squash \
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
--filesystem /var/lib/libvirt/images/coreos/node-worker2/etc/kubernetes/,etc-kubernetes/,type=mount,mode=squash \
--filesystem /var/lib/libvirt/images/coreos/node-worker2/srv/kubernetes/,srv-kubernetes/,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:9d:5d:d8,type=bridge

echo "starting machines ..."
virsh start node-master
virsh start node-worker0
virsh start node-worker1
virsh start node-worker2

echo "done"
