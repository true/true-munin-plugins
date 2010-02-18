#!/bin/bash
set -ex

DIR_PLUGINS_USED="/etc/munin/plugins"

olddir=$(pwd)

# prerequisites
apt-get -fym install html2text dialog git-core

# clone / pull gitrep
[ -d /var/git ] || mkdir -p /var/git
cd /var/git
if [ -d true-munin-plugins/.git ]; then
    cd true-munin-plugins
    git pull
else
    git clone git://github.com/true/true-munin-plugins.git && cd true-munin-plugins
    cd true-munin-plugins
fi

# Index Dirs & prepare checklist
list=""
for dir in $(find -maxdepth 1 -type d |sed 's#\./##g' |egrep -v '(^_|^\.)' |sort); do
    status="on"
    if [ "${dir}" = "libvirt" ]; then
        status="off"
    fi

    list="${list} ${dir} ${dir} ${status}"
done

# Show checklist and save wanted plugins
dialog --checklist "Which plugins do you want to install?" 20 40 10 ${list}  2> /tmp/answer$$
plugins=$(cat /tmp/answer$$)

mkdir -p ${DIR_PLUGINS_USED}

for plugin in ${plugins}; do
    plugin=$(echo "${plugin}" |sed 's#"##g')
    cd ${plugin}

    echo "Installing Plugin: ${plugin}";

    if [ -f "install.sh" ]; then
        echo "  Found ${plugin}/install.sh, executing.."
        source install.sh
    else
        echo "  There was no ${plugin}/install.sh, so just symlinking all files to ${DIR_PLUGINS_USED})"
        for plugfile in $(find ./ -maxdepth 1 -type f |egrep -v '(^\./_|^\./\.)' |sed "s#\./#$(pwd)/#g"); do
            plugbase=$(basename "${plugfile}")
            ln -nfs ${plugfile} ${DIR_PLUGINS_USED}/${plugbase}
        done
    fi
    echo ""
    
    cd - > /dev/null
done

if [ -x /etc/init.d/munin-node ]; then
    echo "Restarting munin-node... "
    /etc/init.d/munin-node restart
fi

# return to working dir
cd ${olddir}
