# firebird-docker-armhf
Firebird server image. Dockerfile for armv7 devices like Linux-sunxi boards running linux Armbian distro with hypriot compiled docker for arm more info: Linux-sunxi: www.linux-sunxi.org Armbian: www.armbian.com hypriot: www.hypriot.com

this images is based of https://github.com/jacobalberty/firebird-docker efort but adapted for armhf. I think that is valid for rpi2/2+ also.

images for "testing", when it works ok I will changue to "works".

Image derived from a armhf/debian jessie.

# docker Firebird

## Supported tags and respective `Dockerfile` links

[`2.5-sc`, `latest` (*2.5-sc/Dockerfile*)](https://github.com/jacobalberty/firebird-docker/blob/master/2.5-sc/Dockerfile)

[## What's New
## Default Username/password
The default username and password are now set to SYSDBA/masterkey.
Please note that the 3.0 tag does not yet include the default password and will change every time a new build is pushed.
Check /var/firebird/etc/SYSDBA.password for the credentials for your current build.

## Description
This is a Firebird SQL Database container.

## Default Login information
Username: SYSDBA
Password: masterkey
Please be sure to change your password as soon as you log in.

## Environment Variables:
### `TZ`
TimeZone. (i.e. America/Chicago)

## Server Architectures
At the moment only the "Super Classic" and "Super Server" architectures are available.

### SC
Super Classic.
### SS
Super Server.
### CS
Classic Server.

Latest is the same as 2.5-sc

## Volumes:

### `/databases/`
Default location to put database files

### `/var/firebird/run`
guardian lock DIR

### `/var/firebird/etc`
config files DIR
message files DIR

### `/var/firebird/log`
log files DIR

### `/var/firebird/system`
security database DIR

### `/tmp/firebird`
Database lock directory

## Exposes: 
### 3050/tcp

## Events
Please note for events to work properly you must either configure RemoteAuxPort and forward it with -p using a direct mapping where both sides internal and external use the same port or use --net=host to allow the random port mapping to work.
see: http://www.firebirdfaq.org/faq53/ for more information on event port mapping.
