#!/bin/bash

function generate_mac {
	printf \"${MACPREFIX}%02x\" \$1
}

NODEMAC=\$(generate_mac \"10\")
echo \"create virsh kubernetes-master mac=\${NODEMAC} ...\"
virt-install \\
--import \\
--debug \\
--serial pty \\
--accelerate \\
--ram ${MASTER_MEMORY} \\
--vcpus 2 \\
--cpu=host \\
--os-type linux \\
--os-variant virtio26 \\
--noautoconsole \\
--nographics \\
--name ${VM_PREFIX}kubernetes-master \\
--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-master,bus=virtio,cache=writethrough,io=native \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-master/config/,config-2,type=mount,mode=squash \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-master/ssl/,kubernetes-ssl,type=mount,mode=squash \\
--network bridge=${BRIDGE},mac=\${NODEMAC},type=bridge,model=virtio

NODEMAC=\$(generate_mac \"9\")
echo \"create virsh kubernetes-storage mac=\${NODEMAC} ...\"
virt-install \\
--import \\
--debug \\
--serial pty \\
--accelerate \\
--ram ${STORAGE_MEMORY} \\
--vcpus 2 \\
--cpu=host \\
--os-type linux \\
--os-variant virtio26 \\
--noautoconsole \\
--nographics \\
--name ${VM_PREFIX}kubernetes-storage \\
--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage,bus=virtio,cache=writethrough,io=native \\
--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage-data,bus=virtio,cache=writethrough,io=native \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-storage/config/,config-2,type=mount,mode=squash \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-storage/ssl/,kubernetes-ssl,type=mount,mode=squash \\
--network bridge=${BRIDGE},mac=\${NODEMAC},type=bridge,model=virtio

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	NODEMAC=\$(generate_mac \$((20 + \$i)))
	echo \"create virsh kubernetes-worker\${i} mac=\${NODEMAC} ...\"
	virt-install \\
	--import \\
	--debug \\
	--serial pty \\
	--accelerate \\
	--ram ${WORKER_MEMORY} \\
	--vcpus 2 \\
	--cpu=host \\
	--os-type linux \\
	--os-variant virtio26 \\
	--noautoconsole \\
	--nographics \\
	--name ${VM_PREFIX}kubernetes-worker\${i} \\
	--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker\${i},bus=virtio,cache=writethrough,io=native \\
	--disk /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker\${i}-storage,bus=virtio,cache=writethrough,io=native \\
	--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker\${i}/config/,config-2,type=mount,mode=squash \\
	--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-worker\${i}/ssl/,kubernetes-ssl,type=mount,mode=squash \\
	--network bridge=${BRIDGE},mac=\${NODEMAC},type=bridge,model=virtio
done
