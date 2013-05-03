CC=gcc
CFLAGS=-c -Wall -Werror -fpic
LDFLAGS=-shared
LIBRARY=libi2c-com.so
prefix=/usr/lib
ifndef _ARCH
	_ARCH:= $(shell ./scripts/print_arch)
	export _ARCH
endif

all: libi2c-com.o
	$(CC) $(LDFLAGS) libi2c-com.o -o $(LIBRARY)
 
libi2c-com.o: libi2c-com.c
	$(CC) $(CFLAGS) libi2c-com.c -o libi2c-com.o
    
install:
	install -m 0644 libi2c-com.so $(prefix)

uninstall:
	rm $(prefix)/libi2c-com.so

deb: all
	mkdir -p package/usr/lib
	cp -R DEBIAN package/
	sed -i "s/#ARCH#/$(_ARCH)/" package/DEBIAN/control
	install -m 0644 libi2c-com.so package/usr/lib
	dpkg-deb -b package libi2c-com_0.1-1_$(_ARCH).deb &> dpkgbuild.log
	
clean:
	rm -rf *o *so *.deb
	rm -Rf package
	
	

