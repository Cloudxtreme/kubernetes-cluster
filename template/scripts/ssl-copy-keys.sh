#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

SCRIPT_ROOT=\$(dirname "\${BASH_SOURCE}")

# kubernetes-master
mkdir -p \${SCRIPT_ROOT}/../kubernetes-master/ssl
cp \${SCRIPT_ROOT}/kubernetes-ca.pem \${SCRIPT_ROOT}/../kubernetes-master/ssl/ca.pem
cp \${SCRIPT_ROOT}/kubernetes-apiserver.pem \${SCRIPT_ROOT}/../kubernetes-master/ssl/apiserver.pem
cp \${SCRIPT_ROOT}/kubernetes-apiserver-key.pem \${SCRIPT_ROOT}/../kubernetes-master/ssl/apiserver-key.pem
#chmod 600 \${SCRIPT_ROOT}/../kubernetes-master/ssl/*.pem
chown root:root \${SCRIPT_ROOT}/../kubernetes-master/ssl/*.pem

# kubernetes-storage
mkdir -p \${SCRIPT_ROOT}/../kubernetes-storage/ssl
cp \${SCRIPT_ROOT}/kubernetes-ca.pem \${SCRIPT_ROOT}/../kubernetes-storage/ssl/ca.pem
cp \${SCRIPT_ROOT}/kubernetes-storage.pem \${SCRIPT_ROOT}/../kubernetes-storage/ssl/storage.pem
cp \${SCRIPT_ROOT}/kubernetes-storage-key.pem \${SCRIPT_ROOT}/../kubernetes-storage/ssl/storage-key.pem
#chmod 600 \${SCRIPT_ROOT}/../kubernetes-storage/ssl/*.pem
chown root:root \${SCRIPT_ROOT}/../kubernetes-storage/ssl/*.pem

# kubernetes-etcd
for ((i=0; i < ${ETCD_AMOUNT}; i++)) do
	mkdir -p \${SCRIPT_ROOT}/../kubernetes-etcd\${i}/ssl
	cp \${SCRIPT_ROOT}/kubernetes-ca.pem \${SCRIPT_ROOT}/../kubernetes-etcd\${i}/ssl/ca.pem
	cp \${SCRIPT_ROOT}/kubernetes-etcd\${i}.pem \${SCRIPT_ROOT}/../kubernetes-etcd\${i}/ssl/etcd.pem
	cp \${SCRIPT_ROOT}/kubernetes-etcd\${i}-key.pem \${SCRIPT_ROOT}/../kubernetes-etcd\${i}/ssl/etcd-key.pem
	#chmod 600 \${SCRIPT_ROOT}/../kubernetes-etcd\${i}/ssl/*.pem
	chown root:root \${SCRIPT_ROOT}/../kubernetes-etcd\${i}/ssl/*.pem
done

# kubernetes-worker
for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	mkdir -p \${SCRIPT_ROOT}/../kubernetes-worker\${i}/ssl
	cp \${SCRIPT_ROOT}/kubernetes-ca.pem \${SCRIPT_ROOT}/../kubernetes-worker\${i}/ssl/ca.pem
	cp \${SCRIPT_ROOT}/kubernetes-worker\${i}.pem \${SCRIPT_ROOT}/../kubernetes-worker\${i}/ssl/worker.pem
	cp \${SCRIPT_ROOT}/kubernetes-worker\${i}-key.pem \${SCRIPT_ROOT}/../kubernetes-worker\${i}/ssl/worker-key.pem
	#chmod 600 \${SCRIPT_ROOT}/../kubernetes-worker\${i}/ssl/*.pem
	chown root:root \${SCRIPT_ROOT}/../kubernetes-worker\${i}/ssl/*.pem
done

