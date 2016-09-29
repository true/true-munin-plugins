Getting started
===============
On Ubuntu hosts, as root, execute:

    wget --no-check-certificate -O- https://github.com/true/true-munin-plugins/raw/master/install_ubuntu.sh | bash

You will then see a dialog and you can check all the special munin plugins
you want to install.

New plugin types should each have their own folder. By default,
all of their files will be symlinked to the munin plugin dir.

So you're done!

Automatic plugin detection
==========================

In an effort to be able to just place all plugins and use munin's autoconf option to sort out if it needs to be enabled or not, I (ron) have made directories plugin-conf.d and munin-plugins. All plugins need to be tested if autoconf works, and if so moved to munin-plugins (and an entry in plugin-conf.d if needed). I don't think install_ubuntu.sh has been used in the past years, mostly plugins were pulled when needed, as is descibed in wiki pages per service.
