# $Id: makefile 4064 2008-10-14 00:59:29Z rares $
#
# Copyright (C) 2008 by The Regents of the University of California
#
# Redistribution of this file is permitted under the terms of the BSD
# license
#
# Date: 05/15/2008
#
# Author: Rares Vernica <rares (at) ics.uci.edu>
#

CC=gcc
CFLAGS=-Wall -O3 -I/usr/include/mysql
LDFLAGS=-L. -ledrec

all: libed.so libedth.so libedrec.so

libed.so: ed.c
	${CC} ${CFLAGS} -fPIC -shared -o $@ $?

libedth.so: edth.c
	${CC} ${CFLAGS} -fPIC -shared -o $@ $?

libedrec.so: edrec.c
	${CC} ${CFLAGS} -fPIC -shared -o $@ $?

.PHONY: test
test:
	cat ed.sql edth.sql edrec.sql | mysql --user=root --database=mysql --password=theend06

.PHONY: clean
clean:
	-rm unittest *.so *.o *~

unittest: unittest.o libedrec.so

unittest.o: edrec.h
