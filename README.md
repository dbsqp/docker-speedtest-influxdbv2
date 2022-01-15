Do speedtest using Ookla's official CLI program and place it in your influxdb. Based on loganmarchione's docker-speedtest-influxdbv2.

Updated for aligned Influxdb format with my other API InfluxDB containers.


### Environment variables
| Variable         | Required?                  | Definition                                     | Example                                     | Comments                                                                                            |
|------------------|----------------------------|------------------------------------------------|---------------------------------------------|-----------------------------------------------------------------------------------------------------|
| INFLUXDB_SCHEME  | No (default: http)         | Connect to InfluxDB using http or https        | 'https'                                     | Useful if InfluxDB is behind a reverse proxy and you need to use https                              |
| INFLUXDB_HOST    | No (default: localhost)    | Server hosting the InfluxDB                    | 'localhost' or your Docker service name     |                                                                                                     |
| INFLUXDB_PORT    | No (default: 8086)         | InfluxDB port                                  | 8086                                        |                                                                                                     |
| INFLUXDB_USER    | Yes (only for v1)          | Database username                              | influx_username                             | Needs to have the correct permissions                                                               |
| INFLUXDB_PASS    | Yes (only for v1)          | Database password                              | influx_password                             |                                                                                                     |
| INFLUXDB_TOKEN   | Yes (only for v2)          | Token to connect to bucket                     | asdfghjkl                                   | Needs to have the correct permissions. Setting this assumes we're talking to an InfluxDBv2 instance |
| INFLUXDB_ORG     | Yes (only for v2)          | Organization                                   | my_test_org                                 |                                                                                                     |
| INFLUXDB_DB      | Yes                        | Database name                                  | SpeedtestStats                              | Must already be created. In InfluxDBv2, this is the "bucket".                                       |
| SLEEPY_TIME      | No (default: 3600)         | Seconds to sleep between runs                  | 3600                                        | The loop takes about 15-30 seconds to run, so I wouldn't set this value any lower than 60 (1min)    |
| SPEEDTEST_HOST   | No (default: container ID) | Hostname of service where Speedtest is running | server04                                    | Useful if you're running Speedtest on multiple servers                                              |
| SPEEDTEST_SERVER | No (default: random)       | ID number of Speedtest server                  | 41817                                       | See a list of servers and IDs [here](https://c.speedtest.net/speedtest-servers-static.php)          |
