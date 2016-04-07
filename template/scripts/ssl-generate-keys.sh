#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

# https://coreos.com/kubernetes/docs/latest/openssl.html

KUBERNETES_SVC=${K8S_SERVICE_IP}
MASTER_IP=${MASTER_IP}
FIREWALL_IP=${PUBLIC_IP}
STORAGE_IP=${STORAGE_IP}

# CA Key
openssl genrsa -out \${SCRIPT_ROOT}/kubernetes-ca-key.pem 2048
openssl req -x509 -new -nodes -key \${SCRIPT_ROOT}/kubernetes-ca-key.pem -days 10000 -out \${SCRIPT_ROOT}/kubernetes-ca.pem -subj \"/CN=kube-ca\"

# Master Key
openssl genrsa -out \${SCRIPT_ROOT}/kubernetes-apiserver-key.pem 2048
KUBERNETES_SVC=\${KUBERNETES_SVC} MASTER_IP=\${MASTER_IP} FIREWALL_IP=\${FIREWALL_IP} openssl req -new -key \${SCRIPT_ROOT}/kubernetes-apiserver-key.pem -out \${SCRIPT_ROOT}/kubernetes-apiserver.csr -subj \"/CN=kube-apiserver\" -config \${SCRIPT_ROOT}/openssl.cnf
KUBERNETES_SVC=\${KUBERNETES_SVC} MASTER_IP=\${MASTER_IP} FIREWALL_IP=\${FIREWALL_IP} openssl x509 -req -in \${SCRIPT_ROOT}/kubernetes-apiserver.csr -CA \${SCRIPT_ROOT}/kubernetes-ca.pem -CAkey \${SCRIPT_ROOT}/kubernetes-ca-key.pem -CAcreateserial -out \${SCRIPT_ROOT}/kubernetes-apiserver.pem -days 365 -extensions v3_req -extfile \${SCRIPT_ROOT}/openssl.cnf

# Storage Key
STORAGE_FQDN=\"storage\"
openssl genrsa -out \${SCRIPT_ROOT}/kubernetes-\${STORAGE_FQDN}-key.pem 2048
WORKER_IP=\${STORAGE_IP} openssl req -new -key \${SCRIPT_ROOT}/kubernetes-\${STORAGE_FQDN}-key.pem -out \${SCRIPT_ROOT}/kubernetes-\${STORAGE_FQDN}.csr -subj \"/CN=\${STORAGE_FQDN}\" -config \${SCRIPT_ROOT}/worker-openssl.cnf
WORKER_IP=\${STORAGE_IP} openssl x509 -req -in \${SCRIPT_ROOT}/kubernetes-\${STORAGE_FQDN}.csr -CA \${SCRIPT_ROOT}/kubernetes-ca.pem -CAkey \${SCRIPT_ROOT}/kubernetes-ca-key.pem -CAcreateserial -out \${SCRIPT_ROOT}/kubernetes-\${STORAGE_FQDN}.pem -days 365 -extensions v3_req -extfile \${SCRIPT_ROOT}/worker-openssl.cnf

# Etcd Key
for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	value=\$((15 + \$i))
	ETCD_FQDN=\"etcd\${i}\"
	ETCD_IP=${NETWORK}.${value}
	openssl genrsa -out \${SCRIPT_ROOT}/kubernetes-\${ETCD_FQDN}-key.pem 2048
	WORKER_IP=\${ETCD_IP} openssl req -new -key \${SCRIPT_ROOT}/kubernetes-\${ETCD_FQDN}-key.pem -out \${SCRIPT_ROOT}/kubernetes-\${ETCD_FQDN}.csr -subj \"/CN=\${ETCD_FQDN}\" -config \${SCRIPT_ROOT}/worker-openssl.cnf
	WORKER_IP=\${ETCD_IP} openssl x509 -req -in \${SCRIPT_ROOT}/kubernetes-\${ETCD_FQDN}.csr -CA \${SCRIPT_ROOT}/kubernetes-ca.pem -CAkey \${SCRIPT_ROOT}/kubernetes-ca-key.pem -CAcreateserial -out \${SCRIPT_ROOT}/kubernetes-\${ETCD_FQDN}.pem -days 365 -extensions v3_req -extfile \${SCRIPT_ROOT}/worker-openssl.cnf
done

# Worker Key
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	value=\$((20 + \$i))
	WORKER_FQDN=\"worker\${i}\"
	WORKER_IP=${NETWORK}.${value}
	openssl genrsa -out \${SCRIPT_ROOT}/kubernetes-\${WORKER_FQDN}-key.pem 2048
	WORKER_IP=\${WORKER_IP} openssl req -new -key \${SCRIPT_ROOT}/kubernetes-\${WORKER_FQDN}-key.pem -out \${SCRIPT_ROOT}/kubernetes-\${WORKER_FQDN}.csr -subj \"/CN=\${WORKER_FQDN}\" -config \${SCRIPT_ROOT}/worker-openssl.cnf
	WORKER_IP=\${WORKER_IP} openssl x509 -req -in \${SCRIPT_ROOT}/kubernetes-\${WORKER_FQDN}.csr -CA \${SCRIPT_ROOT}/kubernetes-ca.pem -CAkey \${SCRIPT_ROOT}/kubernetes-ca-key.pem -CAcreateserial -out \${SCRIPT_ROOT}/kubernetes-\${WORKER_FQDN}.pem -days 365 -extensions v3_req -extfile \${SCRIPT_ROOT}/worker-openssl.cnf
done

# Admin Key
openssl genrsa -out \${SCRIPT_ROOT}/kubernetes-admin-key.pem 2048
openssl req -new -key \${SCRIPT_ROOT}/kubernetes-admin-key.pem -out \${SCRIPT_ROOT}/kubernetes-admin.csr -subj \"/CN=kube-admin\"
openssl x509 -req -in \${SCRIPT_ROOT}/kubernetes-admin.csr -CA \${SCRIPT_ROOT}/kubernetes-ca.pem -CAkey \${SCRIPT_ROOT}/kubernetes-ca-key.pem -CAcreateserial -out \${SCRIPT_ROOT}/kubernetes-admin.pem -days 365
