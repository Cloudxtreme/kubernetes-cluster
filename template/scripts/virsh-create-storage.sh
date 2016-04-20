#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

function generate_mac {
	printf \"${MACPREFIX}%02x\" \$1
}

NODEMAC=\$(generate_mac \"9\")
echo \"create virsh kubernetes-storage mac=\${NODEMAC} ...\"
virt-install \\
--import \\
--debug \\
--serial pty \\
--accelerate \\
--ram ${STORAGE_MEMORY} \\
--vcpus ${STORAGE_CPU_CORES} \\
--cpu=host \\
--os-type linux \\
--os-variant virtio26 \\
--noautoconsole \\
--nographics \\
--name ${VM_PREFIX}kubernetes-storage \\
--disk /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-storage,bus=virtio,cache=${DISK_CACHE},io=${DISK_IO} \\
--disk /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-storage-docker,bus=virtio,cache=${DISK_CACHE},io=${DISK_IO} \\
--disk /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-storage-data,bus=virtio,cache=${DISK_CACHE},io=${DISK_IO} \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-storage/config/,config-2,type=mount,mode=squash \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-storage/ssl/,kubernetes-ssl,type=mount,mode=squash \\
--network bridge=${BRIDGE},mac=\${NODEMAC},type=bridge,model=virtio
