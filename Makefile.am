# Build and install the GNU Autoconf Archive.
#
# Copyright (c) 2015 Autoconf Archive Maintainers <autoconf-archive-maintainers@gnu.org>
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <https://www.gnu.org/licenses/>.

SUBDIRS                 = doc

dist_pkgdata_DATA       = AUTHORS COPYING COPYING.EXCEPTION README
aclocaldir              = $(datadir)/aclocal
dist_aclocal_DATA       = $(M4FILES)
EXTRA_DIST              = build-aux/git-version-gen build-aux/gitlog-to-changelog

clean-local:
	@rm -rf $(srcdir)/stage $(srcdir)/macro.pyc __pycache__
	@rm -f $(DIST_ARCHIVES)

maintainer-clean-local:
	@rm -rf $(srcdir)/build-aux
	@rm -f configure Makefile.in aclocal.m4 AUTHORS ChangeLog
	@rm -f INSTALL config.log config.status configure maint.mk
	@rm -f autoconf-archive-*.*.*.tar.* GNUmakefile README

dist-hook:
	echo $(VERSION) > $(distdir)/.tarball-version
	if test -d .git; then												\
	  echo > $(distdir)/cl-t '# Copyright (c) 2014 Autoconf Archive Maintainers <autoconf-archive-maintainers@gnu.org>'; \
	  echo >>$(distdir)/cl-t '#';											\
	  echo >>$(distdir)/cl-t '# Copying and distribution of this file, with or without modification, are';		\
	  echo >>$(distdir)/cl-t '# permitted in any medium without royalty provided the copyright notice and';		\
	  echo >>$(distdir)/cl-t '# this notice are preserved. This file is offered as-is, without any warranty.';	\
	  echo >>$(distdir)/cl-t '';											\
	  $(top_srcdir)/build-aux/gitlog-to-changelog >>$(distdir)/cl-t -- master $(top_srcdir)/m4;			\
	  rm -f $(distdir)/ChangeLog;											\
	  mv $(distdir)/cl-t $(distdir)/ChangeLog;									\
	  $(top_srcdir)/gen-authors.sh >$(distdir)/au-t;								\
	  rm -f $(distdir)/AUTHORS;											\
	  mv $(distdir)/au-t $(distdir)/AUTHORS;									\
	fi
