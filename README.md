# esp-idf-remote-hd44780
Control the HD44780 using HTTP.   
I use [this](https://github.com/UncleRus/esp-idf-lib) library.   
It's great work.   

![slide-1](https://user-images.githubusercontent.com/6020549/215234141-5bc314df-4147-4925-b9c8-d0b4c9a7cb74.JPG)

# Software requirements
ESP-IDF V4.4/V5.0.   

# Hardware requirements
Character display using HD44780.   
Usually called 1602LCD/1604LCD.   

# Installation
```Shell
git clone https://github.com/nopnop2002/esp-idf-remote-hd44780
cd esp-idf-remote-hd44780
git clone https://github.com/UncleRus/esp-idf-lib.git
idf.py menuconfig
idf.py flash
```

# Configuration

![config-top](https://user-images.githubusercontent.com/6020549/215234404-aaf6ba86-282e-4f1a-aa17-8f53c93194e4.jpg)
![config-app](https://user-images.githubusercontent.com/6020549/215234407-49bdf156-efe0-459c-a729-1561c8288985.jpg)

## WiFi Setting   
![config-wifi-1](https://user-images.githubusercontent.com/6020549/215234488-b980e32a-96d0-49b7-93dc-c1f476780975.jpg)

You can connect using the mDNS hostname instead of the IP address.   
![config-wifi-2](https://user-images.githubusercontent.com/6020549/215234489-ad51183b-1c9a-47ad-a06f-1d7fbd9d520e.jpg)

You can use static IP.   
![config-wifi-3](https://user-images.githubusercontent.com/6020549/215234490-02c33ef4-79f6-4839-91d8-33ba38578964.jpg)

## Device Setting   
![config-device](https://user-images.githubusercontent.com/6020549/215234557-7e48c50d-8d3c-4883-859f-d65775c8300a.jpg)



# Wiring
|LCD||ESP32|ESP32S2/S3|ESP32C2/C3||
|:-:|:-:|:-:|:-:|:-:|:-|
|VSS|--|GND|GND|GND||
|VDD|--|3.3V|3.3V|3.3V||
|VO|--||||Variable resistor output|
|RS|--|GPIO19|GPIO1|GPIO0|*1|
|RW|--|GND|GND|GND||
|E|--|GPIO18|GPIO2|GPIO1|*1|
|D0|--|N/C|N/C|N/C||
|D1|--|N/C|N/C|N/C||
|D2|--|N/C|N/C|N/C||
|D3|--|N/C|N/C|N/C||
|D4|--|GPIO5|GPIO3|GPIO2|*1|
|D5|--|GPIO17|GPIO4|GPIO3|*1|
|D6|--|GPIO16|GPIO5|GPIO4|*1|
|D7|--|GPIO4|GPIO6|GPIO5|*1|
|A|--|5V|5V|5V|*2|
|A|--|3.3V|3.3V|3.3V|*2|
|K|--|GND|GND|GND||

(*1) You can change any GPIO using menuconfig.   

(*2) 5V for 5V modules. 3.3V for 3.3V modules.   


# API

- cursor:off blink:off(default)   
```curl -X POST -H "Content-Type: application/json" -d '{"lcd":"on", "cursor":"off", "blink":"off"}' http://esp32-server.local:8080/api/control```

- cursor:on blink:off   
```curl -X POST -H "Content-Type: application/json" -d '{"lcd":"on", "cursor":"on", "blink":"off"}' http://esp32-server.local:8080/api/control```

- cursor:off blink:on    
```curl -X POST -H "Content-Type: application/json" -d '{"lcd":"on", "cursor":"off", "blink":"on"}' http://esp32-server.local:8080/api/control```

- cursor:on blink:on   
```curl -X POST -H "Content-Type: application/json" -d '{"lcd":"on", "cursor":"on", "blink":"on"}' http://esp32-server.local:8080/api/control```

- clear lcd   
```curl -X POST -H "Content-Type: application/json" http://esp32-server.local:8080/api/clear```

- set position   
```curl -X POST -H "Content-Type: application/json" -d '{"col":0, "line":0}' http://esp32-server.local:8080/api/gotoxy```

- put character on lcd   
```curl -X POST -H "Content-Type: application/json" -d '{"char":"s"}' http://esp32-server.local:8080/api/putc```

- put string on lcd   
```curl -X POST -H "Content-Type: application/json" -d '{"str":"abcdefghijklmn"}' http://esp32-server.local:8080/api/puts```

- backlight on   
```curl -X POST -H "Content-Type: application/json" -d '{"backlight":"on"}' http://esp32-server.local:8080/api/backlight```

___A transistor is required for backlight control.___   
```
                  emitter
ESP32 GND -----------------+
                           |
                    base   /
ESP32 BL  -----^^^--------|    SS8050
                           \
               collector   |
                           +------- LCD K
ESP32 3.3V/5V ----------------------LCD A

```

- backlight off   
```curl -X POST -H "Content-Type: application/json" -d '{"backlight":"off"}' http://esp32-server.local:8080/api/backlight```


# Demo   
```
sudo apt install curl
bash demo.sh
```
