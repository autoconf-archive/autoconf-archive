# Build and install the Autoconf Archive.
#
# Copyright (c) 2009 by Peter Simons <simons@cryp.to>
# Licensed under the terms of the GNU General Public License.

SUBDIRS                 = doc

dist_pkgdata_DATA       = AUTHORS COPYING README
aclocaldir              = $(datadir)/aclocal
dist_aclocal_DATA       = $(M4SOURCE)
EXTRA_DIST              = build-aux/git-version-gen build-aux/gitlog-to-changelog

# maintainer rules

clean-local:
	@rm -rf $(srcdir)/stage $(srcdir)/macro.pyc
	@rm -f $(DIST_ARCHIVES)

maintainer-clean-local:
	@rm -rf $(srcdir)/build-aux
	@rm -f configure Makefile.in aclocal.m4 AUTHORS ChangeLog
	@rm -f INSTALL config.log config.status configure maint.mk
	@rm -f autoconf-archive-*.*.*.tar.* GNUmakefile

dist-hook:
	echo $(VERSION) > $(distdir)/.tarball-version
	if test -d .git; then						\
	  $(top_srcdir)/build-aux/gitlog-to-changelog			\
	    >$(distdir)/cl-t -- master $(top_srcdir)/m4;		\
	  rm -f $(distdir)/ChangeLog;					\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;			\
	  $(top_srcdir)/git-authors-gen.pl >$(distdir)/au-t;		\
	  rm -f $(distdir)/AUTHORS;					\
	  mv $(distdir)/au-t $(distdir)/AUTHORS;			\
	fi
