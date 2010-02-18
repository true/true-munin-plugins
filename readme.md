Getting started
===============
For Ubuntu hosts, execute:

    wget -qO- http://github.com/true/true-munin-plugins/raw/master/install_ubuntu.sh | bash

You will then see a dialog and you can check all the special munin plugins
you want to install.

New plugin types should each have their own folder. By default,
all of their files will be symlinked to the munin plugin dir.

So you're done!


Special cases
=============

If special treatment is required, you can place your own install script:

    install.sh

inside a plugin subdir, which is then executed instead of the default symlinking.


Adding more plugins
===================
The install script automatically iterates over newly added dirs & files, so
it should not be modified for the purpose of adding new plugins.
Just drop them in this repo.

Or mail me if it's too much hassle for you