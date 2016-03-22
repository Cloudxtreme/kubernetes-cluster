#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

################################################################################

WORKER_AMOUNT=3


################################################################################

source "utils/config-generator.sh"

generate_configs