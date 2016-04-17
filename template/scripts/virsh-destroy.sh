#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

echo \"destroy machines ...\"
\${SCRIPT_ROOT}/virsh-destroy-etcd.sh
\${SCRIPT_ROOT}/virsh-destroy-storage.sh
\${SCRIPT_ROOT}/virsh-destroy-master.sh
\${SCRIPT_ROOT}/virsh-destroy-worker.sh
