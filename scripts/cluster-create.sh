#!/bin/sh

if [ ! -f /mnt/images/coreos/coreos_production_qemu_image.img ]; then
  echo "downloading image ..."
  #wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > /mnt/images/coreos/coreos_production_qemu_image.img
  wget http://beta.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > /mnt/images/coreos/coreos_production_qemu_image.img
  #wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > /mnt/images/coreos/coreos_production_qemu_image.img
fi

echo "converting image ..."
qemu-img convert /mnt/images/coreos/coreos_production_qemu_image.img -O raw /mnt/images/coreos/coreos_production_qemu_image.raw

echo "create lvm volumes ..."
lvcreate -L 10G -n bb_kubernetes-master vg0
lvcreate -L 10G -n bb_kubernetes-worker0 vg0
lvcreate -L 10G -n bb_kubernetes-worker1 vg0
lvcreate -L 10G -n bb_kubernetes-worker2 vg0

echo "writing images ..."
dd bs=1M iflag=direct oflag=direct if=/mnt/images/coreos/coreos_production_qemu_image.raw of=/dev/vg0/bb_kubernetes-master
dd bs=1M iflag=direct oflag=direct if=/mnt/images/coreos/coreos_production_qemu_image.raw of=/dev/vg0/bb_kubernetes-worker0
dd bs=1M iflag=direct oflag=direct if=/mnt/images/coreos/coreos_production_qemu_image.raw of=/dev/vg0/bb_kubernetes-worker1
dd bs=1M iflag=direct oflag=direct if=/mnt/images/coreos/coreos_production_qemu_image.raw of=/dev/vg0/bb_kubernetes-worker2

./virsh-create.sh

echo "done"
