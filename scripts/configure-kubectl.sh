#!/bin/sh

kubectl config set-cluster default-cluster --server=https://192.168.178.3 --certificate-authority=/Users/bborbe/.kubectl/kubernetes-ca.pem
kubectl config set-credentials default-admin --certificate-authority=/Users/bborbe/.kubectl/kubernetes-ca.pem --client-key=/Users/bborbe/.kubectl/kubernetes-admin-key.pem --client-certificate=/Users/bborbe/.kubectl/kubernetes-admin.pem
kubectl config set-context default-system --cluster=default-cluster --user=default-admin
kubectl config use-context default-system

echo "test with 'kubectl get nodes'"