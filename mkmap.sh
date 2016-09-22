#!/bin/bash
if [ $(pgrep -c $(basename $0)) -gt 0 ]; then 
  echo $(basename $0) is already running
  exit 0
fi

load=`grep -o "^." /proc/loadavg`
if [ "$load" -gt 0 ]; then
  #exit if load is equal or bigger than 1.0
  exit 1
fi
FFMAPPATH='/opt/ffmap-backend'
TMPPATH='/tmp/ffmap-backend'
mkdir -p $TMPPATH
cd $FFMAPPATH
cp json/nodes.json $TMPPATH/
python3 $FFMAPPATH/backend.py -d /$TMPPATH/ --aliases $FFMAPPATH/gateway.json -m bat-ffki:/var/run/alfred.bat-ffki.sock -p 62 --vpn de:ad:be:ef:ff:02 de:ad:be:ff:ff:01 de:ad:be:ff:ff:03 de:ad:be:ff:ff:00
cp /$TMPPATH/* /$FFMAPPATH/json/
#python3 $FFMAPPATH/backend.py -d /$FFMAPPATH/json/ -m bat-ffki:/var/run/alfred.bat-ffki.sock -p 62 --vpn de:ad:be:ef:ff:02 de:ad:be:ff:ff:01 de:ad:be:ff:ff:03 de:ad:be:ff:ff:00

# the file blacklist contains long and latitude values, that should be replaced in the form
# 53.123456, 10.123456/53.456789, 10.456789
# new ffmap-backend: "latitude": 54.30895, "longitude": 10.07595
# therefore two lines for long und lat in blacklist now
#test with cat blacklist|grep -v '#'|while read geo ; do if [ "$geo" != "" ]; then sed "s/$geo/" json/nodes.json; fi; done|jq .
cat blacklist|grep -v '#'|while read geo ; do if [ "$geo" != "" ]; then sed -i "s/$geo/g" json/nodes.json; fi; done

sed -i 's/@/(a)/g' /$FFMAPPATH/json/nodes.json 

