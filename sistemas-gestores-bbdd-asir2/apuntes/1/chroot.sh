# Mount Kernel Virtual File Systems
TARGETDIR="/mnt/chroot"

sudo mkdir -p $TARGETDIR
sudo mkdir -p $TARGETDIR/proc
sudo mkdir -p $TARGETDIR/sys
sudo mkdir -p $TARGETDIR/dev

sudo  mount -t proc proc $TARGETDIR/proc
sudo  mount -t sysfs sysfs $TARGETDIR/sys
sudo  mount -t devtmpfs devtmpfs $TARGETDIR/dev
sudo  mount -t tmpfs tmpfs $TARGETDIR/dev/shm
sudo  mount -t devpts devpts $TARGETDIR/dev/pts

sudo mkdir -p $TARGETDIR/lib
sudo mkdir -p $TARGETDIR/usr
sudo mkdir -p $TARGETDIR/lib64
sudo mkdir -p $TARGETDIR/etc
#sudo cp /etc/passwd $TARGETDIR/etc/passwd 

sudo mount -o bind /lib $TARGETDIR/lib
sudo mount -o bind /lib64 $TARGETDIR/lib64
sudo mount -o bind /usr $TARGETDIR/usr
sudo mount -o bind /etc $TARGETDIR/etc

sudo chroot $TARGETDIR /usr/bin/bash



