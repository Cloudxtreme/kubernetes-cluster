#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

\${SCRIPT_ROOT}/virsh-create-etcd.sh
\${SCRIPT_ROOT}/virsh-create-storage.sh
\${SCRIPT_ROOT}/virsh-create-master.sh
\${SCRIPT_ROOT}/virsh-create-worker.sh
