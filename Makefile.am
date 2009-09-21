# Build and install the Autoconf Archive.
#
# Copyright (c) 2009 by Peter Simons <simons@cryp.to>
# Licensed under the terms of the GNU General Public License.

dist_pkgdata_DATA       = AUTHORS COPYING README
aclocaldir              = $(datadir)/aclocal
dist_aclocal_DATA       = $(M4SOURCE)
info_TEXINFOS           = autoconf-archive.texi
MAKEINFOFLAGS		= -I $(srcdir)/doc
am__TEXINFO_TEX_DIR     = $(srcdir)/build-aux$(PATH_SEPARATOR)$(srcdir)/doc
EXTRA_DIST              = build-aux/git-version-gen build-aux/gitlog-to-changelog $(TEXIFILE)

autoconf-archive.info:  $(TEXIFILE)

# maintainer rules

clean-local:
	@rm -rf $(srcdir)/stage $(srcdir)/macro.pyc
	@rm -f $(DIST_ARCHIVES)

maintainer-clean-local:
	@rm -rf $(srcdir)/build-aux
	@rm -rf doc
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
	fi
