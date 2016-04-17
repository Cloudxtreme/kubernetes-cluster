#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

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
--vcpus ${MASTER_CPU_CORES} \\
--cpu=host \\
--os-type linux \\
--os-variant virtio26 \\
--noautoconsole \\
--nographics \\
--name ${VM_PREFIX}kubernetes-master \\
--disk /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-master,bus=virtio,cache=${NODE_DISK_CACHE},io=${NODE_DISK_IO} \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-master/config/,config-2,type=mount,mode=squash \\
--filesystem /var/lib/libvirt/images/kubernetes/kubernetes-master/ssl/,kubernetes-ssl,type=mount,mode=squash \\
--network bridge=${BRIDGE},mac=\${NODEMAC},type=bridge,model=virtio
