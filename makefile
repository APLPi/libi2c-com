CC=gcc
CFLAGS=-c -Wall -Werror -fpic
LDFLAGS=-shared
LIBRARY=libi2c-com.so
VERSION=$(shell ./scripts/get_version)
prefix=/usr/lib
ifndef _COMMVERSION
	_COMMVERSION:= $(shell git rev-list HEAD --count)
	export _COMMVERSION
endif
ifndef _ARCH
	_ARCH:= $(shell ./scripts/print_arch)
	export _ARCH
endif

all: libi2c-com.o
	$(CC) $(LDFLAGS) libi2c-com.o -o $(LIBRARY).$(VERSION)
 
libi2c-com.o: libi2c-com.c
	$(CC) $(CFLAGS) libi2c-com.c -o libi2c-com.o
    
install:
	install -m 0644 libi2c-com.so $(prefix)
	ln -s 


uninstall:
	rm $(prefix)/libi2c-com.so

deb: all
	mkdir -p package/usr/lib
	cp -R DEBIAN package/
	sed -i "s/#ARCH#/$(_ARCH)/" package/DEBIAN/control
	sed -i "s/#COMMVERSION#/$(_COMMVERSION)/" package/DEBIAN/control
	install -m 0644 $(LIBRARY).$(VERSION) package/usr/lib
	ln -s $(LIBRARY).$(VERSION) package/usr/lib/$(LIBRARY)
	dpkg-deb -b package libi2c-com_$(VERSION)_$(_ARCH).deb
	
clean:
	rm -Rf *o *so* *.deb
	rm -Rf package
