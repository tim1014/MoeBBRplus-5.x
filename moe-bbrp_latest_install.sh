#!/bin/bash

### Thanks MoeClub for the script

# Check root
[ "$EUID" -ne '0' ] && echo -e "\n\nError: This script must be run as root!\n\n" && exit 1;

# Donwload
## Check latest version
kernel_ver_backup="5.10.29-bbrplus"
kernel_ver=$(wget -qO- "https://github.com/tim1014/MoeBBRplus-5.x/tags"|grep "/tim1014/MoeBBRplus-5.x/releases/tag/"|head -1|sed -r 's/.*tag\/(.+)\">.*/\1/')
[[ -z ${kernel_ver} ]] && kernel_ver=${kernel_ver_backup}

headurl="https://github.com/tim1014/MoeBBRplus-5.x/releases/download/${kernel_ver}/linux-headers-${kernel_ver}_${kernel_ver}_amd64.deb"
imgurl="https://github.com/tim1014/MoeBBRplus-5.x/releases/download/${kernel_ver}/linux-image-${kernel_ver}_${kernel_ver}_amd64.deb"

echo -e "\n\nDownload Header\n\n"
wget --no-check-certificate -qP '/tmp' $headurl
echo -e "\n\nDownload Image\n\n"
wget --no-check-certificate -qP '/tmp' $imgurl

# Install Kernel
dpkg -i "/tmp/linux-headers-${kernel_ver}_${kernel_ver}_amd64.deb"
dpkg -i "/tmp/linux-image-${kernel_ver}_${kernel_ver}_amd64.deb"
[ $? -eq 0 ] || exit 1 

# Update /etc/sysctl.conf
sed -i '/net\.core\.default_qdisc/d' /etc/sysctl.conf
sed -i '/net\.ipv4\.tcp_congestion_control/d' /etc/sysctl.conf
while [ -z "$(sed -n '$p' /etc/sysctl.conf)" ]; do sed -i '$d' /etc/sysctl.conf; done
sed -i '$a\net.core.default_qdisc=fq_codel\nnet.ipv4.tcp_congestion_control=bbrplus\n\n' /etc/sysctl.conf

# Remove other kernel and update-grub
item="linux-image-${kernel_ver}"
while true; do
  List_Kernel="$(dpkg -l |grep 'linux-image\|linux-modules\|linux-generic' |grep -v "${item}")"
  Num_Kernel="$(echo "$List_Kernel" |sed '/^$/d' |wc -l)"
  [ "$Num_Kernel" -eq "0" ] && break
  for kernel in `echo "$List_Kernel" |awk '{print $2}'`
    do
      if [ -f "/var/lib/dpkg/info/${kernel}.prerm" ]; then
        sed -i 's/linux-check-removal/#linux-check-removal/' "/var/lib/dpkg/info/${kernel}.prerm"
        sed -i 's/uname -r/echo purge/' "/var/lib/dpkg/info/${kernel}.prerm"
      fi
      dpkg --force-depends --purge "$kernel"
    done
  done
apt-get autoremove -y

echo -e "\n\nPlease reboot...\n\n"
