dwm - dynamic window manager
============================

dwm is an extremely fast, small, and dynamic window manager for X.

Forked by Branislav Blaskovic
-----------------------------

I patched the vanilla DWM and configured it on my own.
More info on [my personal web page](http://blaskovic.sk/).
This fork is tested on Fedora LXDE spin.

dwm-panel by Branislav Blaskovic
--------------------------------

dwm-panel is a daemon which provides titlebar in dwm. 
Use `/usr/bin/dwm-panel` to print available commands.

dwm-menu by Branislav Blaskovic
-------------------------------

In order to get dwm-menu working properly, you need to add your user into sudoers and set this:

    yourusername ALL=(ALL) NOPASSWD: /usr/sbin/pm-suspend

Requirements
------------

In order to build dwm you need the Xlib header files.


Installation
------------

Edit config.mk to match your local setup (dwm is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install dwm (if
necessary as root):

    make clean install

If you are going to use the default bluegray color scheme it is highly
recommended to also install the bluegray files shipped in the dextra package.


Configuration
-------------

The configuration of dwm is done by creating a custom config.h
and (re)compiling the source code.


Running dwm (deprecated in this forked version)
---------------------------------------------
Add the following line to your .xinitrc to start dwm using startx:

    exec dwm

In order to connect dwm to a specific display, make sure that
the DISPLAY environment variable is set correctly, e.g.:

    DISPLAY=foo.bar:1 exec dwm

(This will start dwm on display :1 of the host foo.bar.)

In order to display status info in the bar, you can do something
like this in your .xinitrc:

    while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
    do
    	sleep 1
    done &
    exec dwm

