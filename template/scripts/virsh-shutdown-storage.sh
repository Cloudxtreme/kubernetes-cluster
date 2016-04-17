#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

virsh shutdown ${VM_PREFIX}kubernetes-storage
