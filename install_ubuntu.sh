#!/bin/bash




plugins=( libvirt-blkstat libvirt-cputime libvirt-ifstat libvirt-mem libvirt__cputime libvirt__ifstat libvirt__mem libvirt__blkstat apt_ubuntu )



exit 1

plugins_lib=/usr/share/munin/plugins/
plugins_live=/etc/munin/plugins/

cd $plugins_lib
for plugin in ${plugins[@]}
do
 wget http://hulk.true.nl/$plugin -O $plugins_lib/$plugin
 ln -s $plugins_lib/$plugin $plugins_live
done
ln -s $plugins_lib/nfs_client $plugins_live 
