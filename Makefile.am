# Build and install the Autoconf Archive.
#
# Copyright (c) 2009 by Peter Simons <simons@cryp.to>
# Licensed under the terms of the GNU General Public License.

dist_pkgdata_DATA       = AUTHORS COPYING README

aclocaldir              = $(datadir)/aclocal
dist_aclocal_DATA       = $(M4SOURCE)

htmldir                 = $(pkgdatadir)/html
dist_html_DATA          = $(HTMLFILE)

EXTRA_DIST		= build-aux/git-version-gen

# maintainer rules

dist-hook:
	echo $(VERSION) > $(distdir)/.tarball-version

clean-local:
	@rm -rf $(srcdir)/stage $(srcdir)/macro.pyc
	@rm -f $(DIST_ARCHIVES)

maintainer-clean-local:
	@rm -rf $(srcdir)/build-aux
	@rm -f configure Makefile.in aclocal.m4 AUTHORS ChangeLog
	@rm -f INSTALL config.log config.status configure maint.mk
	@rm -f autoconf-archive-*.*.*.tar.* GNUmakefile
