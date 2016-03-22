#!/bin/sh

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
--network bridge=br0,mac=${MACPREFIX}a,type=bridge

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
--network bridge=br0,mac=${MACPREFIX}9,type=bridge

echo \"create virsh kubernetes-worker0 ...\"
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
--name ${VM_PREFIX}kubernetes-worker0 \\
--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker0 \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker0/config/,config-2,type=mount,mode=squash \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker0/ssl/,kubernetes-ssl,type=mount,mode=squash \\
--network bridge=br0,mac=${MACPREFIX}14,type=bridge

echo \"create virsh kubernetes-worker1 ...\"
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
--name ${VM_PREFIX}kubernetes-worker1 \\
--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker1 \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker1/config/,config-2,type=mount,mode=squash \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker1/ssl/,kubernetes-ssl,type=mount,mode=squash \\
--network bridge=br0,mac=${MACPREFIX}15,type=bridge

echo \"create virsh kubernetes-worker2 ...\"
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
--name ${VM_PREFIX}kubernetes-worker2 \\
--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker2 \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker2/config/,config-2,type=mount,mode=squash \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker2/ssl/,kubernetes-ssl,type=mount,mode=squash \\
--network bridge=br0,mac=${MACPREFIX}16,type=bridge
