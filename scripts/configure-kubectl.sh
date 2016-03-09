#!/bin/sh

kubectl config set-cluster default-cluster --server=https://172.16.20.10 --certificate-authority=/Users/bborbe/.kubectl/ca.pem
kubectl config set-credentials default-admin --certificate-authority=/Users/bborbe/.kubectl/ca.pem --client-key=/Users/bborbe/.kubectl/admin-key.pem --client-certificate=/Users/bborbe/.kubectl/admin.pem
kubectl config set-context default-system --cluster=default-cluster --user=default-admin
kubectl config use-context default-system

echo "test with 'kubectl get nodes'"