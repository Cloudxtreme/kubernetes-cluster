#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=$(dirname "${BASH_SOURCE}")

################################################################################

PUBLIC_IP="172.16.50.1"
REGION="rn"
NETWORK="172.16.30"
MACPREFIX="00:16:3e:2f:30:"
LVM_VG="vg0"
STORAGE_SIZE="50G"
WORKER_SIZE="25G"
DISK_PREFIX="bb_"
VM_PREFIX="bb_"
HOST=host.rocketsource.de
BRIDGE=br0

################################################################################

source "utils/config-generator.sh"

generate_configs