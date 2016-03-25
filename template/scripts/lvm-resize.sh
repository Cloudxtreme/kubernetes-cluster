#!/bin/bash

lvextend --size ${PARTITION_SIZE} /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker0
lvextend --size ${PARTITION_SIZE} /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker1
lvextend --size ${PARTITION_SIZE} /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-worker2
