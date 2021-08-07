decode: fix.o libcrak.so libcypher.so
	gcc -m32 fix.o decode.o -L. -Wl,-rpath='$$ORIGIN' -lcrak -lcypher -o decode

fix.o: fix.S
	as -32 $< -o $@

bypass.o: bypass.c
	gcc -m32 -c $< -o $@

libcrak.so: bypass.o fix.o
	gcc -m32 --shared $^ -o $@

.PHONY: clean dist
clean:
	rm -f decode bypass.o fix.o decode.tar.gz libcrak.so

dist:
	tar zcvf decode.tar.gz Makefile fix.S bypass.c decode.o