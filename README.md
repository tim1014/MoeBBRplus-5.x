# BBRPlus-5.10.x (Tuned By MoeClub)

Linux BBRplus Kernel v5.10.x ported from <a href="https://github.com/MoeClub/BBR" target="_blank">MoeClub/BBR</a> v4.14.153 <br/>
(Please note that **IT DOES NOT** based on v5.10 version of BBR, instead just simple ported the v4.14.153 version of BBR)

<br/><br/>

# Credits

https://github.com/MoeClub/BBR<br/>
https://github.com/UJX6N/bbrplus-5.10

<br/><br/>

# Highlights

- Merged MoeClub v4.14.153 "tcp_bbr" patches into bbrplus.
- Keep official v5.10 "tcp_bbr" module in the kernel, now can do either (usage below).
```
net.ipv4.tcp_congestion_control = bbrplus
net.ipv4.tcp_congestion_control = bbr
```
<br/><br/>

# Install

You can simply just use releases compiled by me in "Releases" section (deb Only)

<br/><br/>

# Patch and build kernel yourself
### Requirement and Perparation
GCC >= 4.9, check with "gcc --version"m or install / upgrade if you haven't.
```
CentOS:
sudo yum groupinstall Development tools
sudo yum install ncurses-devel bc gcc gcc-c++ ncurses ncurses-devel cmake elfutils-libelf-devel openssl-devel rpm-build redhat-rpm-config asciidoc hmaccalc perl-ExtUtils-Embed xmlto audit-libs-devel binutils-devel elfutils-devel elfutils-libelf-devel newt-devel python-devel zlib-devel

Debian:
sudo apt install build-essential libncurses5-dev
sudo apt build-dep linux
```

<br/>

### Build kernel
