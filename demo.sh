#!/bin/bash
#set -x

curl -X POST -H "Content-Type: application/json" http://esp32-server.local:8080/api/clear

curl -X POST -H "Content-Type: application/json" -d '{"col":0, "line":0}' http://esp32-server.local:8080/api/gotoxy

curl -X POST -H "Content-Type: application/json" -d '{"str":"Hello World!!"}' http://esp32-server.local:8080/api/puts

curl -X POST -H "Content-Type: application/json" -d '{"col":0, "line":1}' http://esp32-server.local:8080/api/gotoxy

curl -X POST -H "Content-Type: application/json" -d '{"str":"Hello World!!"}' http://esp32-server.local:8080/api/puts

curl -X POST -H "Content-Type: application/json" -d '{"lcd":"on", "cursor":"on", "blink":"on"}' http://esp32-server.local:8080/api/control

for ((col=0; col<13; col++))
do
	#str="{\"col\":${col}, \"line\":1}"
	str1="{\"col\":${col}"
	str2="\"line\":1}"
	str=$str1,$str2
	curl -X POST -H "Content-Type: application/json" -d $str http://esp32-server.local:8080/api/gotoxy
	sleep 0.5
done

sleep 3

curl -X POST -H "Content-Type: application/json" -d '{"lcd":"on", "cursor":"off", "blink":"off"}' http://esp32-server.local:8080/api/control

curl -X POST -H "Content-Type: application/json" http://esp32-server.local:8080/api/clear

curl -X POST -H "Content-Type: application/json" -d '{"col":3, "line":0}' http://esp32-server.local:8080/api/gotoxy

LANG=C
_date=`date "+%Y/%m/%d"`
str="{\"str\":\"${_date}\"}"
curl -X POST -H "Content-Type: application/json" -d ${str} http://esp32-server.local:8080/api/puts

for i in `seq 10`
do
	curl -X POST -H "Content-Type: application/json" -d '{"col":4, "line":1}' http://esp32-server.local:8080/api/gotoxy

	_time=`date "+%H:%M:%S"`
	str="{\"str\":\"${_time}\"}"
	curl -X POST -H "Content-Type: application/json" -d ${str} http://esp32-server.local:8080/api/puts
	sleep 1
done

sleep 3

curl -X POST -H "Content-Type: application/json" http://esp32-server.local:8080/api/clear

curl -X POST -H "Content-Type: application/json" -d '{"col":4, "line":0}' http://esp32-server.local:8080/api/gotoxy

text3='
T
h
a
n
k
s
!
!
'
for i in ${text3}; do
	str="{\"char\":\"${i}\"}"
	curl -X POST -H "Content-Type: application/json" -d ${str} http://esp32-server.local:8080/api/putc
	sleep 1.0
done



