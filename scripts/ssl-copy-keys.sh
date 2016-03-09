#!/bin/sh

# kubernetes-master
mkdir -p ../kubernetes-master/ssl
cp ca.pem ../kubernetes-master/ssl/ca.pem
cp apiserver.pem ../kubernetes-master/ssl/apiserver.pem
cp apiserver-key.pem ../kubernetes-master/ssl/apiserver-key.pem
#chmod 600 ../kubernetes-master/ssl/*.pem
chown root:root ../kubernetes-master/ssl/*.pem

# kubernetes-worker0
mkdir -p ../kubernetes-worker0/ssl
cp ca.pem ../kubernetes-worker0/ssl/ca.pem
cp worker0-worker.pem ../kubernetes-worker0/ssl/worker.pem
cp worker0-worker-key.pem ../kubernetes-worker0/ssl/worker-key.pem
#chmod 600 ../kubernetes-worker0/ssl/*.pem
chown root:root ../kubernetes-worker0/ssl/*.pem

# kubernetes-worker1
mkdir -p ../kubernetes-worker1/ssl
cp ca.pem ../kubernetes-worker1/ssl/ca.pem
cp worker1-worker.pem ../kubernetes-worker1/ssl/worker.pem
cp worker1-worker-key.pem ../kubernetes-worker1/ssl/worker-key.pem
#chmod 600 ../kubernetes-worker1/ssl/*.pem
chown root:root ../kubernetes-worker1/ssl/*.pem

# kubernetes-worker2
mkdir -p ../kubernetes-worker2/ssl
cp ca.pem ../kubernetes-worker2/ssl/ca.pem
cp worker2-worker.pem ../kubernetes-worker2/ssl/worker.pem
cp worker2-worker-key.pem ../kubernetes-worker2/ssl/worker-key.pem
#chmod 600 ../kubernetes-worker2/ssl/*.pem
chown root:root ../kubernetes-worker2/ssl/*.pem
