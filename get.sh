#!/bin/bash

while :
do
  date
  echo "--- Start Speedtest"
  python3 speedtest.py
  RET=$?
  if [ ${RET} -ne 0 ];
  then
    echo "Exit status not 0"
    echo "Sleep 60 s"
    sleep 60
  fi
  date
  echo "Sleep 60 mins"
  sleep 120
done
