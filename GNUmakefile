# GNUmakefile for PyQwt
#
# There are at least two options to log the output of make:
#
# (1) Invoke make and tie stderr to stdout and redirect stdout to log.txt:
#       make all 2&>1 >log.txt
#     However, you do not see what is going on.
#
# (2) Use script to capture all screen output of make to log.txt:
#       script -c 'make all' log.txt
#     The script command appeared in 3.0BSD and is part of util-linux.

# To compile and link the Qwt sources statically into Pyqwt.
QWT := ../qwt-4.2.0

JOBS := 1
UNAME := $(shell uname)

ifeq ($(UNAME),Linux)
JOBS := $(shell getconf _NPROCESSORS_ONLN)
endif

ifeq ($(UNAME),Darwin)
JOBS := $(shell sysctl -n hw.ncpu)
endif

.PHONY: dist

all:
	cd configure \
	&& python configure.py -Q $(QWT) -j $(JOBS) \
	&& $(MAKE) -j $(JOBS)

all-trace:
	cd configure \
	&& python configure.py --trace -Q $(QWT) -j $(JOBS) \
	&& $(MAKE) -j $(JOBS)

symlinks:
	ln -sf ../pyqwt5/support
	(cd sip/qwt4qt3; ln -sf ../../../pyqwt5/sip/qwt5qt3/common)

# Installation
install: all
	make -C configure install

install-trace: all-trace
	make -C configure install

# build a distribution tarball
dist: distclean all
	python setup.py sdist --formats=gztar

clean:
	find . -name '*~' | xargs rm -f

distclean: clean
	find . -name '*.pyc' | xargs rm -f
	rm -rf configure/*qt3

# EOF
