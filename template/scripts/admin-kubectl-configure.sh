#!/bin/bash

mkdir -p \$HOME/.kube/${REGION}
kubectl config set-cluster ${REGION}-cluster --server=https://${PUBLIC_IP}:443 --certificate-authority=\$HOME/.kube/${REGION}/kubernetes-ca.pem
kubectl config set-credentials ${REGION}-admin --certificate-authority=\$HOME/.kube/${REGION}/kubernetes-ca.pem --client-key=\$HOME/.kube/${REGION}/kubernetes-admin-key.pem --client-certificate=\$HOME/.kube/${REGION}/kubernetes-admin.pem
kubectl config set-context ${REGION}-system --cluster=${REGION}-cluster --user=${REGION}-admin
kubectl config use-context ${REGION}-system

echo \"test with 'kubectl get nodes'\"