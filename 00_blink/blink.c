#include <stdint.h>

#define _PORT_(addr) (*(volatile uint8_t*)(addr))
#define _DDRB_ _PORT_(0x24)
#define _PORTB_ _PORT_(0x25)

static void kiloloops(const int n) {
	int i, j;
	for (i = 0; i < n; ++i) {
		for (j = 0; j < 1000; ++j) {
			__asm volatile ("");
		}
	}
}

void main() {
	_DDRB_ |= 1 << 5;
	while (1) {
		_PORTB_ |= 1 << 5;
		kiloloops(1000);
		_PORTB_ &= ~(1 << 5);
		kiloloops(1000);
	}
}

