#!/bin/bash
set -x

function getdirs() {
    wget -qO- "http://github.com/true/true-munin-plugins${1}?raw=true" |html2text |egrep '/$' |egrep -v '^_' |sed 's#[^a-z0-9A-Z_]##g'
}

apt-get -fym install html2text dialog

list=""
for dir in $(getdirs '/'); do
    status="on"
    if [ "${dir}" = "libvirt" ]; then
        status="off"
    fi

    list="${list} ${dir} ${dir} ${status}"
done

dialog --checklist "Which plugins do you want to install?" 20 40 10 ${list}  2> /tmp/answer$$
plugins=$(cat /tmp/answer$$)

for plugin in ${plugins}; do
    echo $plugin;
    # /usr/share/munin/plugins/


done



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
