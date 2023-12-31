#!/bin/bash
pacman -Sy --noconfirm networkmanager grub 
systemctl enable NetworkManager
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
sleep 3
echo '###########################'
echo 'You only get one chance'
echo '###########################'
sleep 5
echo '################'
echo 'Root Password'
echo '################'
passwd
sleep 2
# Generates the locale
# The sed -i commands remove the uncomments the line
sed -i "/en_US.UTF-8 UTF-8/s/^#//g"  /etc/locale.gen
sed -i "/en_US ISO-8859-1/s/^#//g"  /etc/locale.gen
locale-gen
sleep 2
echo 'LANG=en_US.UTF-8' >> /etc/locale.conf
echo 'archbox' >> /etc/hostname
ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime
useradd -mg wheel justaturtle
echo '################'
echo 'User Password'
echo '################'
passwd justaturtle
sed -i "/%wheel ALL=(ALL:ALL) ALL/s/^#//g" /etc/sudoers
echo 'Defaults !tty_tickets' >> /etc/sudoers
sleep 2
echo '########'
echo 'Great'
echo '########'

# Installs essential packages
pacman -S --noconfirm xorg-server xorg-xinit 
pacman -S --noconfirm rofi
pacman -S --noconfirm python-pip
pacman -S --noconfirm firefox
pacman -S --noconfirm wget
pacman -S --noconfirm alacritty 
pacman -S --noconfirm nitrogen
pacman -S --noconfirm i3-gaps
pacman -S --noconfirm dolphin
pacman -S --noconfirm ttf-inconsolata
pacman -S --noconfirm htop
pacman -S --noconfirm sddm
systemctl enable sddm
# Creates .xinitrc
touch .xinitrc
# Writes exec qtile in .xinitrc
echo 'exec i3' | cat > .xinitrc
cat .xinitrc
sleep 3
# Gets stuff that you might need later on 
# If you use an amd chip comment the line down
pacman -S --noconfirm xf86-video-intel
echo '#################################################################################'
echo 'Now the script will end but you have to do some things to finish installation
First : type "exit"
Second: type "umount -R /mnt"
Third : type "reboot"
After reboot type startx'
echo '#################################################################################'
sleep 10
echo 'Bye bye'

