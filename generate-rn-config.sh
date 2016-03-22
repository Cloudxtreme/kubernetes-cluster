#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

################################################################################

CLUSTER_NAME=cluster1

################################################################################

source "utils/config-generator.sh"

generate_configs