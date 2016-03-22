#!/bin/sh

mkdir -p $HOME/.kube/rn
kubectl config set-cluster rn-cluster --server=https://172.16.50.1 --certificate-authority=$HOME/.kube/rn/kubernetes-ca.pem
kubectl config set-credentials rn-admin --certificate-authority=$HOME/.kube/rn/kubernetes-ca.pem --client-key=$HOME/.kube/rn/kubernetes-admin-key.pem --client-certificate=$HOME/.kube/rn/kubernetes-admin.pem
kubectl config set-context rn-system --cluster=rn-cluster --user=rn-admin
kubectl config use-context rn-system

echo "test with 'kubectl get nodes'"
