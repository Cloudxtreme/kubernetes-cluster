#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

mkdir -p ~/.kube/${REGION}

scp ${USER}@${HOST}:/var/lib/libvirt/images/kubernetes/scripts/kubernetes-ca.pem ~/.kube/${REGION}/
scp ${USER}@${HOST}:/var/lib/libvirt/images/kubernetes/scripts/kubernetes-admin.pem ~/.kube/${REGION}/
scp ${USER}@${HOST}:/var/lib/libvirt/images/kubernetes/scripts/kubernetes-admin-key.pem ~/.kube/${REGION}/
