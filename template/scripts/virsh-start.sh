#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

echo \"start machines ...\"
\${SCRIPT_ROOT}/virsh-start-etcd.sh
\${SCRIPT_ROOT}/virsh-start-storage.sh
\${SCRIPT_ROOT}/virsh-start-master.sh
\${SCRIPT_ROOT}/virsh-start-worker.sh
