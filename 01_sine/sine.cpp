#include <stdint.h>

__asm (
	".org 0\n"
	"_entry_: jmp main\n"
	".asciz \"lowlevel_avr\"\n"
	".align 4\n"
);

#define _PORT_(addr) (*(volatile uint8_t*)(addr))
#define _DDRB_ _PORT_(0x24)
#define _PORTB_ _PORT_(0x25)

#define PI_F 3.14159274f
const int TBL_SIZE = 0x100;

static constexpr float sine_f(const float x) {
	float x2 = x * x;
	float x3 = x2 * x;
	float x5 = x3 * x2;
	float x7 = x5 * x2;
	float x9 = x7 * x2;
	return x - x3/6.0f + x5/120.0f - x7/5040.0f + x9/362880.0f;
}

static constexpr uint8_t v8(const int i) {
	float x = float((PI_F/2.0)/double(TBL_SIZE-1) * double(i));
	return uint8_t(sine_f(x) * 0xFF);
}

static uint8_t s_tbl[TBL_SIZE];

__attribute__((noinline)) static void kiloloops(const int n) {
	for (int i = 0; i < n; ++i) {
		for (int j = 0; j < 1000; ++j) {
			__asm volatile ("");
		}
	}
}

template<int N> void tbl_loop() {
	s_tbl[N - 1] = v8(N-1);
	tbl_loop<N-1>();
}
template<> void tbl_loop<0>() {}

void main() {
	tbl_loop<TBL_SIZE>();
	int sig = 1;
	int idx = 0;
	int add = 1;
	_DDRB_ |= 1 << 5; // OUTPUT
	while (1) {
		if (sig) {
			_PORTB_ |= 1 << 5; // HIGH
		} else {
			_PORTB_ &= ~(1 << 5); // LOW
		}
		int val = s_tbl[idx & (TBL_SIZE-1)];
		kiloloops((val + 1) * (sig ? 10 : 2));
		if (idx >= 0xFF) {
			add = -1;
		} else if (idx <= 0) {
			add = 1;
		}
		idx += add;
		sig ^= 1;
	} // loop
}

