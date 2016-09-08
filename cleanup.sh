#!/bin/sh

# Remove Linux headers
apt-get -y remove build-essential linux-headers-$(uname -r)
apt-get -y autoremove
apt-get -y clean

# Remove Virtualbox specific files
rm -rf /usr/src/vboxguest* /usr/src/virtualbox-ose-guest*
rm -rf *.iso *.iso.? /tmp/vbox /home/vagrant/.vbox_version

# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# remove under tmp directory
rm -rf /tmp/*

# Make eth0 auto dhcp
echo 'auto eth0' >> /etc/network/interfaces
echo 'iface eth0 inet dhcp' >> /etc/network/interfaces
# Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces

dd if=/dev/zero of=/EMPTY bs=1M
rm -rf /EMPTY
