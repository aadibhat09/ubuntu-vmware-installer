#!/bin/bash

echo -e "\033[0;32m Installing necessary packages"
sudo apt update
sudo apt install -y build-essential p7zip-full git

echo Installing VMware
wget https://softwareupdate.vmware.com/cds/vmw-desktop/ws/17.5.2/23775571/linux/core/VMware-Workstation-17.5.2-23775571.x86_64.bundle.tar
7z x VMware-Workstation-17.5.2-23775571.x86_64.bundle.tar
chmod +x VMware-Workstation-17.5.2-23775571.x86_64.bundle
./VMware-Workstation-17.5.2-23775571.x86_64.bundle

echo -e "\033[0;32m Updating kernel drivers"
git clone -b tmp/workstation-17.5.2-k6.9.1 https://github.com/nan0desu/vmware-host-modules.git
mv vmware-host-modules/vmmon-only .
mv vmware-host-modules/vmnet-only .
tar -cf vmmon.tar vmmon-only
tar -cf vmnet.tar vmnet-only
sudo cp -v vmmon.tar vmnet.tar /usr/lib/vmware/modules/source/
sudo vmware-modconfig --console --install-all

echo -e "\033[0;32m Removing temporary files"
sudo rm -rf vmmon-only vmnet-only vmware-host-modules vmmon.tar vmnet.tar VMware-Workstation-17.5.2-23775571.x86_64.bundle VMware-Workstation-17.5.2-23775571.x86_64.bundle.tar descriptor.xml

echo -e "\033[0;32m Done!"