#!/bin/sh

# node-master
mkdir -p ../node-master/ssl
cp ca.pem ../node-master/ssl/ca.pem
cp apiserver.pem ../node-master/ssl/apiserver.pem
cp apiserver-key.pem ../node-master/ssl/apiserver-key.pem
#chmod 600 ../node-master/ssl/*.pem
chown root:root ../node-master/ssl/*.pem

# node-worker0
mkdir -p ../node-worker0/ssl
cp ca.pem ../node-worker0/ssl/ca.pem
cp worker0-worker.pem ../node-worker0/ssl/worker.pem
cp worker0-worker-key.pem ../node-worker0/ssl/worker-key.pem
#chmod 600 ../node-worker0/ssl/*.pem
chown root:root ../node-worker0/ssl/*.pem

# node-worker1
mkdir -p ../node-worker1/ssl
cp ca.pem ../node-worker1/ssl/ca.pem
cp worker1-worker.pem ../node-worker1/ssl/worker.pem
cp worker1-worker-key.pem ../node-worker1/ssl/worker-key.pem
#chmod 600 ../node-worker1/ssl/*.pem
chown root:root ../node-worker1/ssl/*.pem

# node-worker2
mkdir -p ../node-worker2/ssl
cp ca.pem ../node-worker2/ssl/ca.pem
cp worker2-worker.pem ../node-worker2/ssl/worker.pem
cp worker2-worker-key.pem ../node-worker2/ssl/worker-key.pem
#chmod 600 ../node-worker2/ssl/*.pem
chown root:root ../node-worker2/ssl/*.pem
