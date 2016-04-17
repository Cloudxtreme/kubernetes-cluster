#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

echo \"shutdown machines ...\"
\${SCRIPT_ROOT}/virsh-shutdown-etcd.sh
\${SCRIPT_ROOT}/virsh-shutdown-storage.sh
\${SCRIPT_ROOT}/virsh-shutdown-master.sh
\${SCRIPT_ROOT}/virsh-shutdown-worker.sh
