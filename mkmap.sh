#!/bin/bash -e

SOURCE="http://vpn0.freifunk.in-kiel.de"
DEST="$1"
[ -d "$DEST" ] || exit 1

cd "$(dirname "$0")"/

wget -q -O json/alfred.158.json "$SOURCE/alfred.cgi?158"
wget -q -O json/alfred.159.json "$SOURCE/alfred.cgi?159"
wget -q -O json/batman.json 	"$SOURCE/batman.cgi"

PATH="$(dirname "$0")/bin:$PATH" ./backend.py -d $DEST --prune 999 --vpn de:ad:be:ef:ff:01

