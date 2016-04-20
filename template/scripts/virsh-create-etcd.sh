#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

function generate_mac {
	printf \"${MACPREFIX}%02x\" \$1
}

for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	NODEMAC=\$(generate_mac \$((15 + \$i)))
	echo \"create virsh kubernetes-etcd\${i} mac=\${NODEMAC} ...\"
	virt-install \\
	--import \\
	--debug \\
	--serial pty \\
	--accelerate \\
	--ram ${ETCD_MEMORY} \\
	--vcpus ${ETCD_CPU_CORES} \\
	--cpu=host \\
	--os-type linux \\
	--os-variant virtio26 \\
	--noautoconsole \\
	--nographics \\
	--name ${VM_PREFIX}kubernetes-etcd\${i} \\
	--disk /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-etcd\${i},bus=virtio,cache=${DISK_CACHE},io=${DISK_IO} \\
	--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-etcd\${i}/config/,config-2,type=mount,mode=squash \\
	--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-etcd\${i}/ssl/,kubernetes-ssl,type=mount,mode=squash \\
	--network bridge=${BRIDGE},mac=\${NODEMAC},type=bridge,model=virtio
done
