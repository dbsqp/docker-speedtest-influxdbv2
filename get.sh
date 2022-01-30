#!/bin/bash

if [ -z "$SPEEDTEST_PERIOD" ];
then
  sleepPeriod=3600
else
  sleepPeriod=$SPEEDTEST_PERIOD
fi

while :
do
  date
  echo "### Start Speedtest ###"
  python3 speedtest.py
  RET=$?
  if [ ${RET} -ne 0 ];
  then
    echo "Exit status not 0, retry in 1 min"
    sleep 60
    python3 speedtest.py
  fi
  date
  echo "### Sleep $sleepPeriod s"
  sleep $sleepPeriod
done
