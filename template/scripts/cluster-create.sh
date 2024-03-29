#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

echo \"downloading image ...\"
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > /var/lib/libvirt/images/coreos_production_qemu_image.img
#wget http://beta.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > /var/lib/libvirt/images/coreos_production_qemu_image.img
#wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > /var/lib/libvirt/images/coreos_production_qemu_image.img

echo \"converting image ...\"
qemu-img convert /var/lib/libvirt/images/coreos_production_qemu_image.img -O raw /var/lib/libvirt/images/coreos_production_qemu_image.raw

echo \"create lvm volumes ...\"

lvcreate -L ${NODE_SIZE} -n ${DISK_PREFIX}kubernetes-master ${LVM_VG}
lvcreate -L ${DOCKER_SIZE} -n \"${DISK_PREFIX}kubernetes-master-docker\" ${LVM_VG}

lvcreate -L ${NODE_SIZE} -n ${DISK_PREFIX}kubernetes-storage ${LVM_VG}
lvcreate -L ${DOCKER_SIZE} -n \"${DISK_PREFIX}kubernetes-storage-docker\" ${LVM_VG}

for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	lvcreate -L ${NODE_SIZE} -n \"${DISK_PREFIX}kubernetes-etcd\${i}\" ${LVM_VG}
	lvcreate -L ${DOCKER_SIZE} -n \"${DISK_PREFIX}kubernetes-etcd\${i}-docker\" ${LVM_VG}
done

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	lvcreate -L ${WORKER_SIZE} -n \"${DISK_PREFIX}kubernetes-worker\${i}\" ${LVM_VG}
	lvcreate -L ${WORKER_DOCKER_SIZE} -n \"${DISK_PREFIX}kubernetes-worker\${i}-docker\" ${LVM_VG}
done

echo \"writing images ...\"
dd bs=1M iflag=direct oflag=direct if=/var/lib/libvirt/images/coreos_production_qemu_image.raw of=/dev/${LVM_VG}/${DISK_PREFIX}kubernetes-master
dd bs=1M iflag=direct oflag=direct if=/var/lib/libvirt/images/coreos_production_qemu_image.raw of=/dev/${LVM_VG}/${DISK_PREFIX}kubernetes-storage
for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	dd bs=1M iflag=direct oflag=direct if=/var/lib/libvirt/images/coreos_production_qemu_image.raw of=/dev/${LVM_VG}/${DISK_PREFIX}kubernetes-etcd\${i}
done
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	dd bs=1M iflag=direct oflag=direct if=/var/lib/libvirt/images/coreos_production_qemu_image.raw of=/dev/${LVM_VG}/${DISK_PREFIX}kubernetes-worker\${i}
done

\${SCRIPT_ROOT}/virsh-create.sh

echo \"done\"
