#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

################################################################################

K8S_SERVICE_IP="10.103.0.1"
SERVICE_NETWORK="10.103.0.0/16"
POD_NETWORK="10.102.0.0/16"
CLUSTER_DOMAIN="cluster.local"
CLUSTER_DNS="10.103.0.10"
K8S_VERSION="1.1.2"
PUBLIC_IP="172.16.70.4"
CLUSTER_NAME="cluster-pn"
REGION="pn"
WORKER_AMOUNT=3
NETWORK="172.16.90"
MACPREFIX="00:16:3e:2f:90:"
LVM_VG="system"
PARTITION_PREFIX=""
VM_PREFIX=""
MASTER_MEMORY=1024
STORAGE_MEMORY=256
WORKER_MEMORY=2048
HOST=sun.pn.benjamin-borbe.de
BRIDGE=privatebr0

################################################################################

source "utils/config-generator.sh"

generate_configs