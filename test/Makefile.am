## Automake Makefile for testing the Autoconf Archive

EXTRA_DIST = atlocal.in

check-local: atconfig atlocal configure
	if test -x ./configure; then \
	  if test "x$${GITHUB_ACTIONS}" = "xtrue" || test "x$${TRAVIS}" = "xtrue"; then \
	    stat ./configure && du ./configure && cat ./configure; \
	  else \
	    ./configure 2>&1; \
	  fi; \
	else \
	  echo "No usable configure script found; one should exist!" >&2; \
	  exit 1; \
	fi
installcheck-local: atconfig atlocal

CLEANFILES = .DS_Store configure

DISTCLEANFILES = acinclude.m4 atconfig config.log config.status configure~

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
	if test -n "$(top_srcdir)" && test -d $(top_srcdir)/m4; then \
	  $(ACLOCAL) -I $(top_srcdir)/m4; \
	elif test -n "$(top_builddir)" && test -d $(top_builddir)/m4; then \
	  $(ACLOCAL) -I $(top_builddir)/m4; \
	else \
	  $(ACLOCAL); \
	fi; \
	$(AUTOCONF) -f -Wall -Werror
configure.ac: configure.ac.in @MAINT@ $(top_srcdir)/configure
acinclude.m4: @MAINT@ $(top_builddir)/config.status $(top_srcdir)/aclocal.m4

##FIXME: really everything in ../m4 should be dependencies...
