#!/bin/bash
#set -x

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/clear" -m ""
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/cursor" -m "off"
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/blink" -m "off"

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/col" -m "0"
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/line" -m "0"

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/puts" -m "Hello World!"
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/putc" -m "!"

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/col" -m "0"
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/line" -m "1"

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/puts" -m "Hello World!"
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/putc" -m "!"

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/col" -m "0"
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/line" -m "1"

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/cursor" -m "on"
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/blink" -m "on"


for ((col=0; col<13; col++))
do
	mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/col" -m "${col}"
	sleep 0.5
done

sleep 3

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/cursor" -m "off"
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/blink" -m "off"

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/clear" -m ""

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/col" -m "3"
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/line" -m "0"

LANG=C
_date=`date "+%Y/%m/%d"`
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/puts" -m "${_date}"

for i in `seq 10`
do
	mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/col" -m "4"
	mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/line" -m "1"

	_time=`date "+%H:%M:%S"`
	mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/puts" -m "${_time}"
	sleep 0.5
done

sleep 3

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/clear" -m ""

mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/col" -m "4"
mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/line" -m "0"

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
	mosquitto_pub -h broker.emqx.io -p 1883 -t "/api/hd44780/putc" -m "${i}"
	sleep 1.0
done

