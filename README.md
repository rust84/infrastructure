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
qm clone 9200 401 --name k3s-e --format raw --full --storage local-zfs
qm resize 401 scsi0 100G
qm set 401 --boot c --bootdisk scsi0
qm set 401 -cdrom /var/lib/vz/template/iso/k3s-seed-k3s-e.iso
(cluster) qm migrate 401 proxmox-c --with-local-disks --online
```

## Pass through physical disks

Find the drive by-id.

`find /dev/disk/by-id/ -type l|xargs -I{} ls -l {}|grep -v -E '[0-9]$' |sort -k11|cut -d' ' -f9,10,11,12`

Map the disk to the VM.

```
root@pm:~# qm set 401  -scsi2 /dev/disk/by-id/ata-CT500MX500SSD1_2048E4D3D172
update VM 401: -scsi2 /dev/disk/by-id/ata-CT500MX500SSD1_2048E4D3D172
```