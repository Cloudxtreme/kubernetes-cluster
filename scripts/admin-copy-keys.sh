#!/bin/sh
mkdir -p ~/.kube/rn
scp bborbe@host.rocketsource.de:/var/lib/libvirt/images/kubernetes/scripts/kubernetes-ca.pem ~/.kube/rn/
scp bborbe@host.rocketsource.de:/var/lib/libvirt/images/kubernetes/scripts/kubernetes-admin.pem ~/.kube/rn/
scp bborbe@host.rocketsource.de:/var/lib/libvirt/images/kubernetes/scripts/kubernetes-admin-key.pem ~/.kube/rn/
