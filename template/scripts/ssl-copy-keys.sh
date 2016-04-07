#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

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

# kubernetes-etcd
for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	mkdir -p ../kubernetes-etcd\${i}/ssl
	cp kubernetes-ca.pem ../kubernetes-etcd\${i}/ssl/ca.pem
	cp kubernetes-etcd\${i}.pem ../kubernetes-etcd\${i}/ssl/etcd.pem
	cp kubernetes-etcd\${i}-key.pem ../kubernetes-etcd\${i}/ssl/etcd-key.pem
	#chmod 600 ../kubernetes-etcd\${i}/ssl/*.pem
	chown root:root ../kubernetes-etcd\${i}/ssl/*.pem
done

# kubernetes-worker
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	mkdir -p ../kubernetes-worker\${i}/ssl
	cp kubernetes-ca.pem ../kubernetes-worker\${i}/ssl/ca.pem
	cp kubernetes-worker\${i}.pem ../kubernetes-worker\${i}/ssl/worker.pem
	cp kubernetes-worker\${i}-key.pem ../kubernetes-worker\${i}/ssl/worker-key.pem
	#chmod 600 ../kubernetes-worker\${i}/ssl/*.pem
	chown root:root ../kubernetes-worker\${i}/ssl/*.pem
done

