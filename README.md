# BBRPlus-5.x (Tuned By MoeClub)

Linux BBRplus Kernel v5.x ported from <a href="https://github.com/MoeClub/BBR" target="_blank">MoeClub/BBR</a> v4.14.153 <br/>
(Please note that **IT DOES NOT** based on v5.x version of BBR, instead just simple ported the v4.14.153 version of BBR)<br/>
And I only tweak .patch file values to match MoeClub-BBR's tuning.

<br/><br/>

# Credits

https://github.com/MoeClub/BBR<br/>
https://github.com/UJX6N/bbrplus-5.10

<br/><br/>

# Highlights

- Merged MoeClub v4.14.153 "tcp_bbr" patches into bbrplus.
- Keep official v5.x "tcp_bbr" module in the kernel, now can do either one (usage below).
```
net.ipv4.tcp_congestion_control = bbrplus
net.ipv4.tcp_congestion_control = bbr
```
<br/><br/>

# Install

You can simply just use releases compiled by me in "Releases" section (deb only, tested on Debian 9.13)<br/>
Script auto install available (tested on Debian 9.13 only, CentOS not supported)
```
v5.10.29 (Stable):
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/tim1014/MoeBBRplus-5.x/main/moe-bbrp_5.10.29_install.sh')

Latest (Unstable):
bash <(wget --no-check-certificate -qO- 'https://raw.githubusercontent.com/tim1014/MoeBBRplus-5.x/main/moe-bbrp_latest_install.sh')
```
Check with the command (IDK why lsmod not showing bbrplus as a module)
```
Dependency: iproute2
ss -ti
```

<br/><br/>

# Patch and build kernel by yourself

### Requirement and Perparation
1. GCC >= 4.9, check with "gcc --version" or install / upgrade using below command.
2. Install dependencies for building kernel (assume that you are root)
```
CentOS:
yum groupinstall Development tools
yum install ncurses-devel bc gcc gcc-c++ ncurses ncurses-devel cmake elfutils-libelf-devel openssl-devel rpm-build redhat-rpm-config asciidoc hmaccalc perl-ExtUtils-Embed xmlto audit-libs-devel binutils-devel elfutils-devel elfutils-libelf-devel newt-devel python-devel zlib-devel

Debian:
apt install build-essential libncurses5-dev
apt build-dep linux

```

<br/>

### Build kernel
1. Get convert patch on this repository, use git or direct download (convert_official_linux-5.10.x_src_to_bbrplus.patch in this repo).
2. Download official Linux Kernel at https://cdn.kernel.org/pub/linux/kernel/v5.x/.
```
Example:
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.10.29.tar.gz
```
3. Extract tar.gz and Change Directory.
```
Example:
tar zxvf linux-5.10.29.tar.gz && cd linux-5.10.29
```
4. Copy convert path to extracted kernel directory.
```
Example:
cp ../convert_official_linux-5.10.x_src_to_bbrplus.patch .
```
5. Do patch job.
```
patch -p1 < convert_official_linux-5.10.x_src_to_bbrplus.patch
```
6. Config build parameters based on current kernel settings.
```
make oldconfig

Press "Enter" key when asked (if you don't know what it is)
Beware option "CONFIG_SYSTEM_TRUSTED_KEYS"
```
7. Disable debug info & module signing.
```
Example:
scripts/config --disable DEBUG_INFO && scripts/config --disable MODULE_SIG
```
8. Build.
```
CentOS:
make rpm-pkg LOCALVERSION=-bbrplus 2>&1 | tee build.log

Debian:
make deb-pkg LOCALVERSION=-bbrplus 2>&1 | tee build.log

You can add -j [core_count] after "make" to use multi core.
If anything goes wrong, check the "build.log" file.
```
9. Collect Kernel Package Files (if succeed)
```
CentOS Files:
/[usr_dir]/rpmbuild/RPMS/x86_64/

Debian:
Parent Directory
```
