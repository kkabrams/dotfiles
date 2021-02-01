#!/bin/bash
# cd to home so I don't end up with everything starting in the dir I started startx in
## stuff in here should NOT have a valid TERM variable...
cd ~
unset TERM
export TERM
exec 2>&1
exec > ~/.local/var/log/xinitrc${DISPLAY}
echo "starting xinitrc..."
## I gave up on using a mouse left-handed.
#xmodmap -e "pointer = 3 2 1"

xrdb -load ~/.Xresources
## should this be just /run instead of /var/run?
export DBUS_SESSION_BUS_ADDRESS=unix:path=/var/run/user/$(id -u)/bus
unset GPG_TTY

## don't remember exactly why these are here.
## going to make planes out of branches and hope nothing bad happens
export GTK_IM_MODULE=xim
export XMODIFIERS=@im=xim
export QT_IM_MODULE=xim

dbus-update-activation-environment --systemd DISPLAY
eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

/home/epoch/.Xsetroot &
s6-svscan ~/.local/x11services &
xsetroot -cursor_name left_ptr
oneko #kill the kitty to stop X session.
gkey-lock
