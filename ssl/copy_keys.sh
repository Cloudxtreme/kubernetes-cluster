#!/bin/sh

# node-master
mkdir -p ../node-master/etc/kubernetes/ssl
cp ca.pem ../node-master/etc/kubernetes/ssl/ca.pem
cp apiserver.pem ../node-master/etc/kubernetes/ssl/apiserver.pem
cp apiserver-key.pem ../node-master/etc/kubernetes/ssl/apiserver-key.pem
chmod 600 ../node-master/etc/kubernetes/ssl/*.pem
chown root:root ../node-master/etc/kubernetes/ssl/*.pem

# node-worker0
mkdir -p ../node-worker0/etc/kubernetes/ssl
cp ca.pem ../node-worker0/etc/kubernetes/ssl/ca.pem
cp worker0-worker.pem ../node-worker0/etc/kubernetes/ssl/worker0-worker.pem
cp worker0-worker-key.pem ../node-worker0/etc/kubernetes/ssl/worker0-worker-key.pem
cd ../node-worker0/etc/kubernetes/ssl
ln -s worker0-worker.pem worker.pem
ln -s worker0-worker-key.pem worker-key.pem
cd -
chmod 600 ../node-worker0/etc/kubernetes/ssl/*.pem
chown root:root ../node-worker0/etc/kubernetes/ssl/*.pem

# node-worker1
mkdir -p ../node-worker1/etc/kubernetes/ssl
cp ca.pem ../node-worker1/etc/kubernetes/ssl/ca.pem
cp worker1-worker.pem ../node-worker1/etc/kubernetes/ssl/worker1-worker.pem
cp worker1-worker-key.pem ../node-worker1/etc/kubernetes/ssl/worker1-worker-key.pem
cd ../node-worker1/etc/kubernetes/ssl
ln -s worker1-worker.pem worker.pem
ln -s worker1-worker-key.pem worker-key.pem
cd -
chmod 600 ../node-worker1/etc/kubernetes/ssl/*.pem
chown root:root ../node-worker1/etc/kubernetes/ssl/*.pem

# node-worker2
mkdir -p ../node-worker2/etc/kubernetes/ssl
cp ca.pem ../node-worker2/etc/kubernetes/ssl/ca.pem
cp worker2-worker.pem ../node-worker2/etc/kubernetes/ssl/worker2-worker.pem
cp worker2-worker-key.pem ../node-worker2/etc/kubernetes/ssl/worker2-worker-key.pem
cd ../node-worker2/etc/kubernetes/ssl
ln -s worker2-worker.pem worker.pem
ln -s worker2-worker-key.pem worker-key.pem
cd -
chmod 600 ../node-worker2/etc/kubernetes/ssl/*.pem
chown root:root ../node-worker2/etc/kubernetes/ssl/*.pem
