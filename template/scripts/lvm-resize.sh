#!/bin/bash

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	lvextend --size ${PARTITION_SIZE} /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker\${i}
done

