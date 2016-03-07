#!/bin/sh

# node-master
mkdir -p ../node-master/kubernetes/ssl
cp ca.pem ../node-master/kubernetes/ssl/ca.pem
cp apiserver.pem ../node-master/kubernetes/ssl/apiserver.pem
cp apiserver-key.pem ../node-master/kubernetes/ssl/apiserver-key.pem
chmod 600 ../node-master/kubernetes/ssl/*-key.pem
chown root:root ../node-master/kubernetes/ssl/*-key.pem

# node-worker0
mkdir -p ../node-master/kubernetes/ssl
cp ca.pem ../node-master/kubernetes/ssl/ca.pem
cp worker0-worker.pem ../node-master/kubernetes/ssl/worker0-worker.pem
cp worker0-worker-key.pem ../node-master/kubernetes/ssl/worker0-worker-key.pem
ln -s ../node-master/kubernetes/ssl/worker0-worker.pem ../node-master/kubernetes/ssl/worker.pem
ln -s ../node-master/kubernetes/ssl/worker0-worker-key.pem ../node-master/kubernetes/ssl/worker-key.pem
chmod 600 ../node-master/kubernetes/ssl/*-key.pem
chown root:root ../node-master/kubernetes/ssl/*-key.pem

# node-worker1
mkdir -p ../node-master/kubernetes/ssl
cp ca.pem ../node-master/kubernetes/ssl/ca.pem
cp worker1-worker.pem ../node-master/kubernetes/ssl/worker1-worker.pem
cp worker1-worker-key.pem ../node-master/kubernetes/ssl/worker1-worker-key.pem
ln -s ../node-master/kubernetes/ssl/worker1-worker.pem ../node-master/kubernetes/ssl/worker.pem
ln -s ../node-master/kubernetes/ssl/worker1-worker-key.pem ../node-master/kubernetes/ssl/worker-key.pem
chmod 600 ../node-master/kubernetes/ssl/*-key.pem
chown root:root ../node-master/kubernetes/ssl/*-key.pem

# node-worker2
mkdir -p ../node-master/kubernetes/ssl
cp ca.pem ../node-master/kubernetes/ssl/ca.pem
cp worker2-worker.pem ../node-master/kubernetes/ssl/worker2-worker.pem
cp worker2-worker-key.pem ../node-master/kubernetes/ssl/worker2-worker-key.pem
ln -s ../node-master/kubernetes/ssl/worker2-worker.pem ../node-master/kubernetes/ssl/worker.pem
ln -s ../node-master/kubernetes/ssl/worker2-worker-key.pem ../node-master/kubernetes/ssl/worker-key.pem
chmod 600 ../node-master/kubernetes/ssl/*-key.pem
chown root:root ../node-master/kubernetes/ssl/*-key.pem
