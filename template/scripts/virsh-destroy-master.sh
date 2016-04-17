#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

virsh destroy ${VM_PREFIX}kubernetes-master
