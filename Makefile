cc      = cc
CFLAGS  = -Wall -fPIC -O3
LDFLAGS = 

NAME    = libweyl
VERSION = 01

TSTDIR := ./tests
INCDIR := /usr/local/include
LIBDIR := /usr/local/lib

UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Linux)
$(NAME).$(VERSION).so:
	$(CC) -c $(CFLAGS) -shared -o $(NAME).so weyl.c  $(LDFLAGS)
endif
ifeq ($(UNAME_S),Darwin)
$(NAME).$(VERSION).dylib:
	$(CC) -c $(CFLAGS) -dynamiclib -o $(NAME).dylib weyl.c  $(LDFLAGS)
endif

.PHONY: install
install: 
	cp weyl.h $(INCDIR)
ifeq ($(UNAME_S),Linux)
	cp $(NAME).so $(LIBDIR)
endif
ifeq ($(UNAME_S),Darwin)
	cp $(NAME).dylib $(LIBDIR)
	ln -s $(LIBDIR)/$(NAME).dylib $(LIBDIR)/$(NAME).dylib
endif

uninstall:
	rm -f $(INCDIR)/weyl.h
ifeq ($(UNAME_S),Linux)
	rm -f $(LIBDIR)/$(NAME).so
	rm -f $(LIBDIR)/$(VERSION).so
endif
ifeq ($(UNAME_S),Darwin)
	rm -f $(LIBDIR)/$(NAME).dylib
	rm -f $(LIBDIR)/$(NAME).dylib
endif

.PHONY:
test: clean
	$(CC) -o $(TSTDIR)/$(TSTDIR) $(TSTDIR)/$(TSTDIR).c weyl.c $(TSTDIR)/unity/unity.c $(CFLAGS)
	$(TSTDIR)/$(TSTDIR)
	rm -f $(TSTDIR)/$(TSTDIR)

.PHONY: clean
clean:
	rm -f $(TSTDIR)/$(TSTDIR)
	rm -f $(NAME).dylib
