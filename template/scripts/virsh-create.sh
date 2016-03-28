#!/bin/bash

echo \"create virsh kubernetes-master ...\"
virt-install \\
--import \\
--debug \\
--serial pty \\
--accelerate \\
--ram ${MASTER_MEMORY} \\
--vcpus 2 \\
--os-type linux \\
--os-variant virtio26 \\
--noautoconsole \\
--nographics \\
--name ${VM_PREFIX}kubernetes-master \\
--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-master \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-master/config/,config-2,type=mount,mode=squash \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-master/ssl/,kubernetes-ssl,type=mount,mode=squash \\
--network bridge=${BRIDGE},mac=${MACPREFIX}10,type=bridge

echo \"create virsh kubernetes-storage ...\"
virt-install \\
--import \\
--debug \\
--serial pty \\
--accelerate \\
--ram ${STORAGE_MEMORY} \\
--vcpus 2 \\
--os-type linux \\
--os-variant virtio26 \\
--noautoconsole \\
--nographics \\
--name ${VM_PREFIX}kubernetes-storage \\
--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage \\
--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage-data \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-storage/config/,config-2,type=mount,mode=squash \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-storage/ssl/,kubernetes-ssl,type=mount,mode=squash \\
--network bridge=${BRIDGE},mac=${MACPREFIX}9,type=bridge

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	echo \"create virsh kubernetes-worker\${i} ...\"
	value=$((20 + \$i))
	virt-install \\
	--import \\
	--debug \\
	--serial pty \\
	--accelerate \\
	--ram ${WORKER_MEMORY} \\
	--vcpus 2 \\
	--os-type linux \\
	--os-variant virtio26 \\
	--noautoconsole \\
	--nographics \\
	--name ${VM_PREFIX}kubernetes-worker\${i} \\
	--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker\${i} \\
	--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker\${i}/config/,config-2,type=mount,mode=squash \\
	--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker\${i}/ssl/,kubernetes-ssl,type=mount,mode=squash \\
	--network bridge=${BRIDGE},mac=${MACPREFIX}${value},type=bridge
done
