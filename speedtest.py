#!/usr/bin/env python3
# encoding=utf-8

from pytz import timezone
from datetime import datetime
from influxdb_client import InfluxDBClient, Point, WriteOptions
from influxdb_client.client.write_api import 
import json
import os
import sys
import subprocess
import platform


# debug enviroment variables
showraw = False
debug_str=os.getenv("DEBUG", None)
if debug_str is not None:
	debug = debug_str.lower() == "true"
else:
	debug = False


# influxDBv2 envionment variables
influxdb2_host=os.getenv('INFLUXDB2_HOST', "localhost")
influxdb2_port=int(os.getenv('INFLUXDB2_PORT', "8086"))
influxdb2_org=os.getenv('INFLUXDB2_ORG', "Home")
influxdb2_token=os.getenv('INFLUXDB2_TOKEN', "token")
influxdb2_bucket=os.getenv('INFLUXDB2_BUCKET', "DEV")
    
speedtest_server = os.getenv("SPEEDTEST_SERVER")
host = os.getenv("HOST", socket.gethostname())


# hard encoded envionment varables


# report debug/domac status
if debug:
	print ( " debug: TRUE" )
else:
	print ( " debug: FALSE" )


# influxDBv2
influxdb2_url="http://" + influxdb2_host + ":" + str(influxdb2_port)
if debug:
	print ( "influx: "+influxdb2_url )
	print ( "bucket: "+influxdb2_bucket )

client = InfluxDBClient(url=influxdb2_url, token=influxdb2_token, org=influxdb2_org)
write_api = client.write_api(write_options=SYNCHRONOUS)


# Run Speedtest
if speedtest_server:
    print("Running Speedtest : ", speedtest_server)
    speedtest_server_arg = "--server-id="+speedtest_server
    rawResults = subprocess.run(['/usr/bin/speedtest', '--accept-license', '--accept-gdpr', '--format=json', speedtest_server_arg], stdout=subprocess.PIPE, text=True, check=True)
else:
    print("Running Speedtest : random server")
    rawResults = subprocess.run(['/usr/bin/speedtest', '--accept-license', '--accept-gdpr', '--format=json'], stdout=subprocess.PIPE, text=True, check=True)

results = json.loads(rawResults.stdout.strip())


# Basic values
speed_down = results["download"]["bandwidth"]
speed_up = results["upload"]["bandwidth"]
ping_latency = results["ping"]["latency"]
ping_jitter = results["ping"]["jitter"]
result_url = results["result"]["url"]

# Advanced values
speedtest_server_id = results["server"]["id"]
speedtest_server_name = results["server"]["name"]
speedtest_server_location = results["server"]["location"]
speedtest_server_country = results["server"]["country"]
speedtest_server_host = results["server"]["host"]

# Print results to Docker logs
print("download ", speed_down, "bps")
print("  upload ", speed_up, "bps")
print(" latency ", ping_latency, "ms")
print(" jitter  ", ping_jitter, "ms")
if debug:
    print("server id       ", speedtest_server_id)
    print("server name     ", speedtest_server_name)
    print("server location ", speedtest_server_location)
    print("server country  ", speedtest_server_country)
    print("server host     ", speedtest_server_host)
    print("result URL      ", result_url)

senddata={}

senddata["measurement"]="isp"
senddata["tags"]={}
senddata["tags"]["source"]="speedtest.net"
senddata["tags"]["host"]=host
senddata["fields"]={}
senddata["fields"]["download"]=speed_down
senddata["fields"]["upload"]=speed_up
senddata["fields"]["latency"]=ping_latency
senddata["fields"]["jitter"]=ping_jitter

if debug:
    print ("INFLUX: "+influxdb2_bucket)
    print (json.dumps(senddata,indent=4))
write_api.write(bucket=influxdb2_bucket, org=influxdb2_org, record=[senddata])
