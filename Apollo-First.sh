#!/bin/bash
echo '################'
echo 'Starting script'
echo '################'
sleep 2
chmod +x Apollo-Second.sh
echo '################################################'
echo 'Press Ctrl+C when you want to stop pinging'
echo '################################################'
sleeo 5
ping archlinux.org
sleep 2
timedatectl set-ntp true
timedatectl status
fdisk -l 
sleep 4
echo '###################################'
echo 'Now we are gonna make  partitions'
echo '###################################'
sleep 2
(
echo m;
# Changes label to gpt
echo o;
# This is for a swap partition dev/sda1
echo n;
echo p;
echo ;
echo ;
echo +5G;
# For bootloader /dev/sda2
echo n;  
echo p;
echo ;
echo ;
echo +256M
 # For rest of files /dev/sda3
echo n; 
echo p;
echo ;
echo ;
echo ;
# Makes /dev/sda1 into a swap partition
echo t;
echo 1;
echo L;
echo 82;
echo p;
echo a;
echo 2;
sleep 10
echo p;
# Writes the partitions
echo w;




)| fdisk /dev/sda
lsblk
mkswap /dev/sda1 
swapon /dev/sda1
# Makes /dev/sda2 & 3 into .ext4 
mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot
lsblk 
sleep 5
pacstrap /mnt base base-devel linux linux-firmware vim  
sleep 4
genfstab -U /mnt >> /mnt/etc/fstab
# Copying the second script to /mnt
cp -r /root/Apollo-Installer/Apollo-Second.sh /mnt
sleep 2
echo '#################################################'
echo 'Now start the second script after chroot (ls)'
echo '#################################################'

sleep 4
arch-chroot /mnt /bin/bash
