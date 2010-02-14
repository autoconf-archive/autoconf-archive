# Build and install the Autoconf Archive Documentation.
#
# Copyright (c) 2010 by the Autoconf Archive Maintainers
# Licensed under the terms of the GNU General Public License.

CHAPTERS                = introduction.texi downloads.texi contribute.texi
info_TEXINFOS           = autoconf-archive.texi
EXTRA_DIST              = $(TEXIFILES) $(CHAPTERS) all-macros.texi

autoconf-archive.info:  autoconf-archive.texi all-macros.texi $(TEXIFILES) $(CHAPTERS)

maintainer-clean-local:
	@rm -f ax_*.texi all-macros.texi Makefile.in
	@rm -rf manual gendocs_template
