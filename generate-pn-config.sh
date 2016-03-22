#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

################################################################################

API_SERVER="172.16.90.1"
CLUSTER_NAME="cluster-pn"
REGION="pn"
WORKER_AMOUNT=3
NETWORK="172.16.90"
MACPREFIX="00:16:3e:2f:90:"
LVM_VG="system"
PARTITION_PREFIX=""
VM_PREFIX=""

################################################################################

source "utils/config-generator.sh"

generate_configs