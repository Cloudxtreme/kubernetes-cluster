#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

virsh undefine ${VM_PREFIX}kubernetes-master
