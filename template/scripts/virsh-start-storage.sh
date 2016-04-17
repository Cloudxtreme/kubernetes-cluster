#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

virsh start ${VM_PREFIX}kubernetes-storage
