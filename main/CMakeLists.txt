set(component_srcs "main.c" "http_server.c" "mqtt_sub.c" "hd44780.c")

idf_component_register(SRCS "${component_srcs}"
                       INCLUDE_DIRS ".")
