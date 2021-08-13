all: k.h
	$(CC) qKeccak.c -D KXVER=3 -Wall -fno-strict-aliasing -Wno-parentheses -g -O2 -shared -fPIC -o qKeccak.so -lgmp

clean:
	rm -f qKeccak.so
