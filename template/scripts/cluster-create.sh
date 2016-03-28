#!/bin/bash

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

echo \"downloading image ...\"
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > /var/lib/libvirt/images/coreos_production_qemu_image.img

echo \"converting image ...\"
qemu-img convert /var/lib/libvirt/images/coreos_production_qemu_image.img -O raw /var/lib/libvirt/images/coreos_production_qemu_image.raw

echo \"create lvm volumes ...\"
lvcreate -L 10G -n ${VM_PREFIX}kubernetes-master ${LVM_VG}
lvcreate -L 10G -n ${VM_PREFIX}kubernetes-storage ${LVM_VG}
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	lvcreate -L ${PARTITION_SIZE} -n \"${VM_PREFIX}kubernetes-worker\${i}\" ${LVM_VG}
done

echo \"writing images ...\"
dd bs=1M iflag=direct oflag=direct if=/var/lib/libvirt/images/coreos_production_qemu_image.raw of=/dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-master
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	dd bs=1M iflag=direct oflag=direct if=/var/lib/libvirt/images/coreos_production_qemu_image.raw of=/dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker\${i}
done

\${SCRIPT_ROOT}/virsh-create.sh

echo \"done\"
