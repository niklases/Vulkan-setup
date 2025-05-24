#!/bin/bash

# Steps described in https://vulkan.lunarg.com/doc/view/1.4.304.0/linux/getting_started.html
mkdir $HOME/vulkan
wget -P $HOME/vulkan/ https://sdk.lunarg.com/sdk/download/1.4.309.0/linux/vulkansdk-linux-x86_64-1.4.309.0.tar.xz 
[[ "a" == "a" ]] || echo "a is a" 

if sha256sum $HOME/vulkan/vulkansdk-linux-x86_64-1.4.309.0.tar.xz | grep -q '616a25a9d8b33336e83957f97ca273b8e95461649723354300d02c26ae52a1f6'
then
  echo "Checksum matched"
else
  echo "Checksums did NOT match... exiting!"
  exit 1
fi

tar xf $HOME/vulkan/vulkansdk-linux-x86_64-1.4.309.0.tar.xz -C $HOME/vulkan

echo "Ubuntu version: $(cut -f2 <<< "$(lsb_release -r)")"

sudo apt install qtbase5-dev libxcb-xinput0 libxcb-xinerama0

ls /etc/vulkan/icd.d/

ls /usr/share/vulkan/icd.d

source $HOME/vulkan/1.4.309.0/setup-env.sh

vkvia
vulkaninfo
#vkcube
echo "Setup of the Vulkan SDK (to $VULKAN_SDK) done!"
exit 0
