#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

virsh reboot ${VM_PREFIX}kubernetes-storage
