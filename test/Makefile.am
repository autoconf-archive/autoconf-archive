## Automake Makefile for testing the Autoconf Archive

EXTRA_DIST = atlocal.in

check-local: atconfig atlocal configure
	./configure
installcheck-local: atconfig atlocal

CLEANFILES = .DS_Store

DISTCLEANFILES = acinclude.m4 atconfig config.log config.status configure

distclean-local:
	@rm -rf autom4te.cache || rmdir autom4te.cache

AUTOM4TE = $(SHELL) $(top_srcdir)/build-aux/missing --run autom4te
AUTOTEST = $(AUTOM4TE) --language=autotest

nodist_check_SCRIPTS = configure

BUILT_SOURCES = atconfig acinclude.m4 configure.ac

maintainer-clean-local:
	@rm -rf autom4te.cache || rmdir autom4te.cache
	@rm -f configure Makefile.in aclocal.m4
	@rm -f config.log config.status

configure: acinclude.m4 configure.ac @MAINT@ Makefile
	$(AUTOCONF) -f -Wall -Werror
configure.ac: configure.ac.in @MAINT@ $(top_srcdir)/configure
acinclude.m4: @MAINT@ $(top_srcdir)/config.status $(top_srcdir)/aclocal.m4

##FIXME: really everything in ../m4 should be dependencies...
