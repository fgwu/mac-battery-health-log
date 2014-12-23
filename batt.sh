#!/bin/bash

#now=`date`
minsec=43200 #12*60*60
nowsec=`date +%s`
#prevsec=`date -ju -f "%a %b %d %T %Z %Y" "$(tail -n 1 .batt/batt.log|cut -d , -f 6)" "+%s"`
prevsec=`cat ~/.batt/.tmp`
limitsec=$(($prevsec+$minsec))
if [ $nowsec -gt $limitsec ]
then
#    echo arrived
    nowu=`date -u`
    datenow=`date -u +%D`
    cnt=`system_profiler SPPowerDataType | grep "Cycle Count" | awk -F: '{print $2}'`
    origcap=8440
    fulcap=`system_profiler SPPowerDataType | grep "Full Charge Capacity" | awk -F: '{print $2}'`
    health=$((fulcap*100/origcap))
    echo $datenow,$cnt,$fulcap,$origcap,$health,$nowu >> ~/.batt/batt.log
 #   echo $prevsec, $nowsec, $limitsec, arrived >> ~/.batt/batt.log2
    echo `date +%s` > ~/.batt/.tmp
#else
 #   echo not arrive yet
 #   echo $prevsec, $nowsec, $limitsec, not arrive yet >> ~/.batt/batt.log2
fi
