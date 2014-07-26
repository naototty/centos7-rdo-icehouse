#version=RHEL7
# System authorization information
auth --enableshadow --passalgo=sha512

# Use CDROM installation media
cdrom
# Run the Setup Agent on first boot
firstboot --enable
ignoredisk --only-use=vda
# Keyboard layouts
keyboard --vckeymap=jp106 --xlayouts='jp'
# System language
lang ja_JP.UTF-8

# Network information
network  --bootproto=dhcp --device=eth0 --ipv6=auto --activate
#network  --bootproto=dhcp --device=eth1 --onboot=off --ipv6=auto
#network  --bootproto=dhcp --device=eth2 --onboot=off --ipv6=auto
network  --hostname=icehouse.tech-conoha.tokyo
# Root password
rootpw --iscrypted $1$u7Cafcha$mUWF4AAitWa5Vu..HMrix/
rootpw /
# System timezone
timezone Asia/Tokyo --isUtc
user --groups=wheel --name=n-gohko --iscrypted --gecos="Naoto Gohko" --password=$1$Ghhtxhfa$SVAeNKHm9UnHYgwQqMTgA0

# System bootloader configuration
bootloader --location=mbr --boot-drive=vda
# Partition clearing information
clearpart  --initlabel --list=vda3,vda2
# Disk partitioning information
part /boot --fstype="xfs" --ondisk=vda --size=500
part pv.18 --fstype="lvmpv" --ondisk=vda --size=68435
volgroup centos --pesize=4096 pv.18
logvol swap  --fstype="swap" --size=6984 --name=swap --vgname=centos
logvol none  --fstype="None" --size=51200 --thinpool --name=pool00 --vgname=centos
logvol /  --fstype="xfs" --size=51200 --thin --poolname=pool00 --name=root --vgname=centos

%packages
@base
@core
@virtualization-hypervisor
@virtualization-platform
@virtualization-tools

%end

