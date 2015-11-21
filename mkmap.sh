#!/bin/bash -e

SOURCE="http://vpn0.ffnord.net"
DEST="$1"
[ -d "$DEST" ] || exit 1

cd "$(dirname "$0")"/

wget -q -O json/alfred.158.json "$SOURCE/alfred.cgi?158"
wget -q -O json/alfred.159.json "$SOURCE/alfred.cgi?159"
wget -q -O json/batman.json 	"$SOURCE/batman.cgi"

PATH="$(dirname "$0")/bin:$PATH" ./backend.py -d $DEST --prune 999 --vpn fe:ed:be:ff:ff:00

# the file blacklist contains long and latitude values, that should be replaced in the form
# 53.123456, 10.123456/53.456789, 10.456789
# new ffmap-backend: "latitude": 54.30895, "longitude": 10.07595
# therefore two lines for long und lat in blacklist now
#cat blacklist|while read geo ; do if [ "$geo" != "" ]; then sed -i "s/$geo/" json/nodes.json; fi; done

