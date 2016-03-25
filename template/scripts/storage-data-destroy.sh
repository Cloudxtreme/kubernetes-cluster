#!/bin/bash

lvremove /dev/${LVM_VG}/${PARTITION_PREFIX}kubernetes-storage-data
