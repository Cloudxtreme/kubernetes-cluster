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
HOST=fire.hm.benjamin-borbe.de

################################################################################

source "utils/config-generator.sh"

generate_configs