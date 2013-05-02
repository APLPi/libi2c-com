CC=gcc
CFLAGS=-c -Wall -Werror -fpic
LDFLAGS=-shared
LIBRARY=libi2c-com.so

all: libi2c-com.o
	$(CC) $(LDFLAGS) libi2c-com.o -o $(LIBRARY)
 
libi2c-com.o: libi2c-com.c
	$(CC) $(CFLAGS) libi2c-com.c -o libi2c-com.o
    
clean:
	rm -rf *o *so

