#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

################################################################################

PUBLIC_IP="172.16.60.6"
REGION="hm"
NETWORK="172.16.20"
MACPREFIX="00:16:3e:2f:20:"
LVM_VG="system"
PARTITION_PREFIX=""
VM_PREFIX=""
MASTER_MEMORY=1024
STORAGE_MEMORY=256
WORKER_MEMORY=2048
HOST=fire.hm.benjamin-borbe.de
BRIDGE=privatebr0

################################################################################

source "utils/config-generator.sh"

generate_configs