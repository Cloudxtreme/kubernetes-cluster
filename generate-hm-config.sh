#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=$(dirname "${BASH_SOURCE}")

################################################################################

PUBLIC_IP="172.16.60.6"
REGION="hm"
NETWORK="172.16.20"
MACPREFIX="00:16:3e:2f:20:"
LVM_VG="system"
HOST=fire.hm.benjamin-borbe.de
STORAGE_SIZE="5G"

################################################################################

source "utils/config-generator.sh"

generate_configs