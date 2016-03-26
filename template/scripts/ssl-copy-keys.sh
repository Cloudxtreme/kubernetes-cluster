#!/bin/bash

# kubernetes-master
mkdir -p ../kubernetes-master/ssl
cp kubernetes-ca.pem ../kubernetes-master/ssl/ca.pem
cp kubernetes-apiserver.pem ../kubernetes-master/ssl/apiserver.pem
cp kubernetes-apiserver-key.pem ../kubernetes-master/ssl/apiserver-key.pem
#chmod 600 ../kubernetes-master/ssl/*.pem
chown root:root ../kubernetes-master/ssl/*.pem

# kubernetes-storage
mkdir -p ../kubernetes-storage/ssl
cp kubernetes-ca.pem ../kubernetes-storage/ssl/ca.pem
cp kubernetes-storage.pem ../kubernetes-storage/ssl/worker.pem
cp kubernetes-storage-key.pem ../kubernetes-storage/ssl/worker-key.pem
#chmod 600 ../kubernetes-storage/ssl/*.pem
chown root:root ../kubernetes-storage/ssl/*.pem

# kubernetes-worker0
mkdir -p ../kubernetes-worker0/ssl
cp kubernetes-ca.pem ../kubernetes-worker0/ssl/ca.pem
cp kubernetes-worker0.pem ../kubernetes-worker0/ssl/worker.pem
cp kubernetes-worker0-key.pem ../kubernetes-worker0/ssl/worker-key.pem
#chmod 600 ../kubernetes-worker0/ssl/*.pem
chown root:root ../kubernetes-worker0/ssl/*.pem

# kubernetes-worker1
mkdir -p ../kubernetes-worker1/ssl
cp kubernetes-ca.pem ../kubernetes-worker1/ssl/ca.pem
cp kubernetes-worker1.pem ../kubernetes-worker1/ssl/worker.pem
cp kubernetes-worker1-key.pem ../kubernetes-worker1/ssl/worker-key.pem
#chmod 600 ../kubernetes-worker1/ssl/*.pem
chown root:root ../kubernetes-worker1/ssl/*.pem

# kubernetes-worker2
mkdir -p ../kubernetes-worker2/ssl
cp kubernetes-ca.pem ../kubernetes-worker2/ssl/ca.pem
cp kubernetes-worker2.pem ../kubernetes-worker2/ssl/worker.pem
cp kubernetes-worker2-key.pem ../kubernetes-worker2/ssl/worker-key.pem
#chmod 600 ../kubernetes-worker2/ssl/*.pem
chown root:root ../kubernetes-worker2/ssl/*.pem
