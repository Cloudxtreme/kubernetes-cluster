#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

################################################################################

CLUSTER_NAME="cluster1"
REGION="rn"
WORKER_AMOUNT=3
NETWORK="172.16.30"
MACPREFIX="00:16:3e:2f:06:"
LVM_VG="vg0"
PARTITION_PREFIX="bb_"
VM_PREFIX="bb_"

################################################################################

source "utils/config-generator.sh"

generate_configs