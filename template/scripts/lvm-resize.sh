#!/bin/bash

for ((i=0; i < ${WORKER_AMOUNT}; i++)) do
	lvextend --size ${SYSTEM_SIZE} /dev/${LVM_VG}/${DISK_PREFIX}kubernetes-worker\${i}
done

