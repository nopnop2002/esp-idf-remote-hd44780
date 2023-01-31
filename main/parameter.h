typedef struct {
	char function[32];
	bool lcd;
	bool cursor;
	bool blink;
	uint8_t col;
	uint8_t line;
	char ch;
	char str[64];
	bool backlight;
} PARAMETER_t;

