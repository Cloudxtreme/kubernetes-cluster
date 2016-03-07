# CoreOs

## Install 3 Nodes

`wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_qemu_image.img.bz2 -O - | bzcat > coreos_production_qemu_image.img`

`qemu-img convert coreos_production_qemu_image.img -O raw coreos_production_qemu_image.raw`

`lvcreate -L 10G -n coreos0 system` 
`lvcreate -L 10G -n coreos1 system` 
`lvcreate -L 10G -n coreos2 system` 

`dd bs=1M iflag=direct oflag=direct if=coreos_production_qemu_image.raw of=/dev/system/coreos0` 
`dd bs=1M iflag=direct oflag=direct if=coreos_production_qemu_image.raw of=/dev/system/coreos1` 
`dd bs=1M iflag=direct oflag=direct if=coreos_production_qemu_image.raw of=/dev/system/coreos2` 

`cd /var/lib/libvirt/images`

`git clone https://bborbe@bitbucket.org/bborbe/coreos.git`

```
virt-install \
--import \
--debug \
--serial pty \
--accelerate \
--ram 1024 \
--vcpus 2 \
--os-type linux \
--os-variant virtio26 \
--noautoconsole \
--nographics \
--name coreos0 \
--disk /dev/mapper/system-coreos0 \
--filesystem /var/lib/libvirt/images/coreos/coreos0/config/,config-2,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:1f:3d:a9,type=bridge
```

```
virt-install \
--import \
--debug \
--serial pty \
--accelerate \
--ram 1024 \
--vcpus 2 \
--os-type linux \
--os-variant virtio26 \
--noautoconsole \
--nographics \
--name coreos1 \
--disk /dev/mapper/system-coreos1 \
--filesystem /var/lib/libvirt/images/coreos/coreos1/config/,config-2,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:0d:03:6a,type=bridge
```

```
virt-install \
--import \
--debug \
--serial pty \
--accelerate \
--ram 1024 \
--vcpus 2 \
--os-type linux \
--os-variant virtio26 \
--noautoconsole \
--nographics \
--name coreos2 \
--disk /dev/mapper/system-coreos2 \
--filesystem /var/lib/libvirt/images/coreos/coreos2/config/,config-2,type=mount,mode=squash \
--network bridge=br0,mac=00:16:3e:9d:5d:d8,type=bridge
```

## Start first node

`virsh start coreos0`

`export FLEETCTL_ENDPOINT=http://192.168.178.136:4001`
`ETCDCTL_ENDPOINT=http://192.168.178.136:2379`
`etcdctl member list`

## Start second node

`etcdctl member add coreos1 http://192.168.178.137:2380`
`virsh start coreos1`
`etcdctl member list`

## Start third node

`etcdctl member add coreos2 http://192.168.178.138:2380`
`virsh start coreos2`
`etcdctl member list`
