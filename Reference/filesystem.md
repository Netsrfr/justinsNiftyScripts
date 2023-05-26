### Extend Live Root Volume
##### EC2 | Ubuntu
List disks and note the device to extend.
> `lsblk`
> Example: /dev/nvme0n1

Identify the filesystem
> `df -hT`

Grow partition and resize the volume.
> `growpart /dev/nvme0n1 1`

Resize the volume
> ext4: `resize2fs /dev/nvme0n1p1`

> xfs: `xfs_growfs d /`