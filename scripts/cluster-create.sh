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

./virsh-create.sh

echo "done"
