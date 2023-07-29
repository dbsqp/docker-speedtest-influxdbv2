Docker image to do speedtest using Ookla's official CLI program and push results into a influxdb bucket. Based on loganmarchione's docker-speedtest-influxdbv2.
Updated for aligned Influxdb format with my other API InfluxDB containers.

Note does not build for arm64 target, see dockerfile and workflow yml for for more info.

Note telegraf now has an internet_speed plugin https://github.com/influxdata/telegraf/tree/master/plugins/inputs/internet_speed

## InfluxDBv2 Setup

Setup InfluxDBv2, create bucket and create a token with write permissions for said bucket.

## Docker Setup
https://hub.docker.com/repository/docker/dbsqp/speedtest-influxdbv2
```
$ docker run -d \
 -e EXPECTED_DOWN="<expected isp upload>" \
 -e EXPECTED_UP="<expected isp upload>" \
 -e SPEEDTEST_SERVER="<Speedtest server id>" \
 -e SPEEDTEST_PERIOD="60" \
 -e INFLUXDB2_HOST="<influxDBv2 SERVER>" \
 -e INFLUXDB2_PORT="8086" \
 -e INFLUXDB2_ORG="Home" \
 -e INFLUXDB2_TOKEN="" \
 -e INFLUXDB2_BUCKET="DEV-Speedtest" \
 --name "Influx-Speedtest" \
dbsqp/speedtest-influxdbv2:latest
```
# Options
EXPECTED_DOWN, EXPECTED_UP, SPEEDTEST_SERVER and SPEEDTEST_PERIOD are optional. Default and recomended period is 1 hour = 3600.
```
 -e INFLUXDB2_SSL="True" \
 -e INFLUXDB2_SSL_VERIFY="False" \
```


# Debug
To report out further details in the log enable debug:
```
 -e DEBUG="true"
```
