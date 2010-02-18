For Ubuntu hosts, execute:

    wget -qO- http://github.com/true/true-munin-plugins/raw/master/install_ubuntu.sh | bash

You will then see a dialog and you can check all the special munin plugins
you want to install.

New plugin types should each have their own folder. By default,
all of their files will be symlinked to the munin plugin dir.

If special treatment is required, you should place a file

    install.sh

inside a plugin subdir, which is then executed instead of the default symlinking
action.


The install script automatically iterates over newly added dirs & files, so
it should not be modified for the purpose of adding new plugins.
Just drop them in this repo.