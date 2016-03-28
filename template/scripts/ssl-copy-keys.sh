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
cp kubernetes-storage.pem ../kubernetes-storage/ssl/storage.pem
cp kubernetes-storage-key.pem ../kubernetes-storage/ssl/storage-key.pem
#chmod 600 ../kubernetes-storage/ssl/*.pem
chown root:root ../kubernetes-storage/ssl/*.pem

# kubernetes-worker
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	mkdir -p ../kubernetes-worker\${i}/ssl
	cp kubernetes-ca.pem ../kubernetes-worker\${i}/ssl/ca.pem
	cp kubernetes-worker\${i}.pem ../kubernetes-worker\${i}/ssl/worker.pem
	cp kubernetes-worker\${i}-key.pem ../kubernetes-worker\${i}/ssl/worker-key.pem
	#chmod 600 ../kubernetes-worker\${i}/ssl/*.pem
	chown root:root ../kubernetes-worker\${i}/ssl/*.pem
done

