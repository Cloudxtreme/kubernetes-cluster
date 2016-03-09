#!/bin/sh

# https://coreos.com/kubernetes/docs/latest/openssl.html

# CA Key
openssl genrsa -out ca-key.pem 2048
openssl req -x509 -new -nodes -key ca-key.pem -days 10000 -out ca.pem -subj "/CN=kube-ca"

# Master Key
openssl genrsa -out apiserver-key.pem 2048
openssl req -new -key apiserver-key.pem -out apiserver.csr -subj "/CN=kube-apiserver" -config openssl.cnf
openssl x509 -req -in apiserver.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out apiserver.pem -days 365 -extensions v3_req -extfile openssl.cnf

# Worker 0 Key
WORKER_FQDN="worker0"
WORKER_IP=172.16.20.0.20
openssl genrsa -out kubernetes-${WORKER_FQDN}-key.pem 2048
WORKER_IP=${WORKER_IP} openssl req -new -key kubernetes-${WORKER_FQDN}-key.pem -out kubernetes-${WORKER_FQDN}.csr -subj "/CN=${WORKER_FQDN}" -config worker-openssl.cnf
WORKER_IP=${WORKER_IP} openssl x509 -req -in kubernetes-${WORKER_FQDN}.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out kubernetes-${WORKER_FQDN}.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf

# Worker 1 Key
WORKER_FQDN="worker1"
WORKER_IP=172.16.20.0.21
openssl genrsa -out kubernetes-${WORKER_FQDN}-key.pem 2048
WORKER_IP=${WORKER_IP} openssl req -new -key kubernetes-${WORKER_FQDN}-key.pem -out kubernetes-${WORKER_FQDN}.csr -subj "/CN=${WORKER_FQDN}" -config worker-openssl.cnf
WORKER_IP=${WORKER_IP} openssl x509 -req -in kubernetes-${WORKER_FQDN}.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out kubernetes-${WORKER_FQDN}.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf

# Worker 2 Key
WORKER_FQDN="worker2"
WORKER_IP=172.16.20.0.22
openssl genrsa -out kubernetes-${WORKER_FQDN}-key.pem 2048
WORKER_IP=${WORKER_IP} openssl req -new -key kubernetes-${WORKER_FQDN}-key.pem -out kubernetes-${WORKER_FQDN}.csr -subj "/CN=${WORKER_FQDN}" -config worker-openssl.cnf
WORKER_IP=${WORKER_IP} openssl x509 -req -in kubernetes-${WORKER_FQDN}.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out kubernetes-${WORKER_FQDN}.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf

# Admin Key
openssl genrsa -out admin-key.pem 2048
openssl req -new -key admin-key.pem -out admin.csr -subj "/CN=kube-admin"
openssl x509 -req -in admin.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out admin.pem -days 365
