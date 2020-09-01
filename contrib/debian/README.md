
Debian
====================
This directory contains files used to package keepscoind/keepscoin-qt
for Debian-based Linux systems. If you compile keepscoind/keepscoin-qt yourself, there are some useful files here.

## keepscoin: URI support ##


keepscoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install keepscoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your keepscoinqt binary to `/usr/bin`
and the `../../share/pixmaps/keepscoin128.png` to `/usr/share/pixmaps`

keepscoin-qt.protocol (KDE)

