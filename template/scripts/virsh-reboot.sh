#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

echo \"reboot machines ...\"
\${SCRIPT_ROOT}/virsh-reboot-etcd.sh
\${SCRIPT_ROOT}/virsh-reboot-storage.sh
\${SCRIPT_ROOT}/virsh-reboot-master.sh
\${SCRIPT_ROOT}/virsh-reboot-worker.sh
