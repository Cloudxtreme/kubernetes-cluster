#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

################################################################################

PUBLIC_IP="172.16.50.1"
REGION="rn"
NETWORK="172.16.30"
MACPREFIX="00:16:3e:2f:30:"
LVM_VG="vg0"
STORAGE_SIZE="50G"
PARTITION_SIZE="25G"
PARTITION_PREFIX="bb_"
VM_PREFIX="bb_"
MASTER_MEMORY=1024
STORAGE_MEMORY=512
WORKER_MEMORY=3072
HOST=host.rocketsource.de
BRIDGE=br0
WORKER_AMOUNT=3

################################################################################

source "utils/config-generator.sh"

generate_configs