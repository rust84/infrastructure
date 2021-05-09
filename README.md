## Create Proxmox template

Create a template from the Ubuntu cloud-init image.

```
qm create 9200 --name focal-server-cloudimg-amd64 --memory 4096 --cpu cputype=host --cores 4 --serial0 socket --vga serial0 --net0 virtio,bridge=vmbr0 --agent enabled=1,fstrim_cloned_disks=1
qm importdisk 9200 /var/lib/vz/template/iso/focal-server-cloudimg-amd64.img local-zfs -format qcow2
qm set 9200 --scsihw virtio-scsi-pci --scsi0 local-zfs:vm-9200-disk-0,ssd=1,discard=on
qm template 9200
```

## Generate seed ISOs

Run `create-k3s-seed-iso.sh $node` to generate a seed iso from the cloud-init file which will be attached as a cdrom device at boot.

## Create the node

Clone the template and attach the seed iso cdrom.

```
qm clone 9200 402 --name k3s-e --format raw --full --storage local-zfs
qm resize 402 scsi0 64G
qm set 402 --boot c --bootdisk scsi0
qm set 402 -cdrom /var/lib/vz/template/iso/k3s-seed-k3s-e.iso
(cluster) qm migrate 402 proxmox-c --with-local-disks --online
```