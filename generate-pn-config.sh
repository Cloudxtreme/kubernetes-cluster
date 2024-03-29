#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=$(dirname "${BASH_SOURCE}")

################################################################################

PUBLIC_IP="172.16.70.4"
REGION="pn"
NETWORK="172.16.90"
MACPREFIX="00:16:3e:2f:90:"
LVM_VG="system"
HOST=sun.pn.benjamin-borbe.de

################################################################################

source "utils/config-generator.sh"

generate_configs