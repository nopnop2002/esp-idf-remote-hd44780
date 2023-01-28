#include <stdio.h>
#include <inttypes.h>
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"
#include "esp_log.h"
//#include <sys/time.h>

#include <http.h>
#include <hd44780.h>
#include <esp_idf_lib_helpers.h>

extern QueueHandle_t xQueueHttp;

void hd44780(void *pvParameters)
{
    hd44780_t lcd = {
        .write_cb = NULL,
        .font = HD44780_FONT_5X8,
        .lines = 2,
        .pins = {
            .rs = CONFIG_RS_GPIO,
            .e  = CONFIG_E_GPIO,
            .d4 = CONFIG_D4_GPIO,
            .d5 = CONFIG_D5_GPIO,
            .d6 = CONFIG_D6_GPIO,
            .d7 = CONFIG_D7_GPIO,
            .bl = HD44780_NOT_USED
        }
    };

	// Enable backlight control
	if (CONFIG_BL_GPIO != -1) {
		lcd.pins.bl = CONFIG_BL_GPIO;
		ESP_LOGW(pcTaskGetName(0), "GPIO%d is used for backlight control.", CONFIG_BL_GPIO);
	}

	// Enable 4-line display
#if CONFIG_4LINE
	lcd.lines = 4;
	ESP_LOGW(pcTaskGetName(0), "Enable 4-line display.");
#endif

    ESP_ERROR_CHECK(hd44780_init(&lcd));

	HTTP_t httpBuf;
	while(1) {
		// Wait for input
		ESP_LOGI(pcTaskGetName(0),"Waitting ....");
		xQueueReceive(xQueueHttp, &httpBuf, portMAX_DELAY);
		ESP_LOGI(pcTaskGetName(0), "httpBuf.function=[%s]", httpBuf.function);
	
		if (strcmp(httpBuf.function, "control") == 0) {
			ESP_LOGI(pcTaskGetName(0),"control lcd=%d cursor=%d blink=%d", httpBuf.lcd, httpBuf.cursor, httpBuf.blink);
			hd44780_control(&lcd, httpBuf.lcd, httpBuf.cursor, httpBuf.blink);
		} else if (strcmp(httpBuf.function, "clear") == 0) {
			hd44780_clear(&lcd);
		} else if (strcmp(httpBuf.function, "gotoxy") == 0) {
			ESP_LOGI(pcTaskGetName(0),"gotoxy col=%d line=%d", httpBuf.col, httpBuf.line);
			hd44780_gotoxy(&lcd, httpBuf.col, httpBuf.line);
		} else if (strcmp(httpBuf.function, "putc") == 0) {
			ESP_LOGI(pcTaskGetName(0),"putc ch=[%c]", httpBuf.ch);
			hd44780_putc(&lcd, httpBuf.ch);
		} else if (strcmp(httpBuf.function, "puts") == 0) {
			ESP_LOGI(pcTaskGetName(0),"puts str=[%s]", httpBuf.str);
			hd44780_puts(&lcd, httpBuf.str);
		} else if (strcmp(httpBuf.function, "backlight") == 0) {
			ESP_LOGI(pcTaskGetName(0),"backlight backlight=%d", httpBuf.backlight);
			hd44780_switch_backlight(&lcd, httpBuf.backlight);
		}
	}

	/* Never reach here */
	vTaskDelete( NULL );
}

