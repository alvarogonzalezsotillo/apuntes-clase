sudo umount -l /mnt/nas-writable
sudo mkdir -p /mnt/nas-writable
sudo mount -t cifs //10.1.0.100/nfspriv /mnt/nas-writable -o credentials=$(pwd)/credentials,uid=root,gid=wheel,file_mode=0770,dir_mode=0770
