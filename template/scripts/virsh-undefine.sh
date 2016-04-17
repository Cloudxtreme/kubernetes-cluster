#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

echo \"undefine machines ...\"
\${SCRIPT_ROOT}/virsh-undefine-etcd.sh
\${SCRIPT_ROOT}/virsh-undefine-storage.sh
\${SCRIPT_ROOT}/virsh-undefine-master.sh
\${SCRIPT_ROOT}/virsh-undefine-worker.sh
