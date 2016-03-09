#!/bin/sh

echo "downloading image ..."
#wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > /tmp/coreos_production_qemu_image.img
wget http://beta.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > /tmp/coreos_production_qemu_image.img
#wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > /tmp/coreos_production_qemu_image.img

echo "converting image ..."
qemu-img convert /tmp/coreos_production_qemu_image.img -O raw /tmp/coreos_production_qemu_image.raw

echo "create lvm volumes ..."
lvcreate -L 10G -n kubernetes-master system
lvcreate -L 10G -n kubernetes-worker0 system
lvcreate -L 10G -n kubernetes-worker1 system
lvcreate -L 10G -n kubernetes-worker2 system

echo "writing images ..."
dd bs=1M iflag=direct oflag=direct if=/tmp/coreos_production_qemu_image.raw of=/dev/system/kubernetes-master
dd bs=1M iflag=direct oflag=direct if=/tmp/coreos_production_qemu_image.raw of=/dev/system/kubernetes-worker0
dd bs=1M iflag=direct oflag=direct if=/tmp/coreos_production_qemu_image.raw of=/dev/system/kubernetes-worker1
dd bs=1M iflag=direct oflag=direct if=/tmp/coreos_production_qemu_image.raw of=/dev/system/kubernetes-worker2

./virsh-create.sh

echo "done"
