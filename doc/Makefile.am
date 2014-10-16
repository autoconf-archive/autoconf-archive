# Build and install the GNU Autoconf Archive documentation.
#
# Copyright (c) 2013 Autoconf Archive Maintainers <autoconf-archive-maintainers@gnu.org>
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
# this program. If not, see <http://www.gnu.org/licenses/>.

CHAPTERS        = introduction.texi downloads.texi contribute.texi fdl-1.3.texi
info_TEXINFOS   = autoconf-archive.texi
EXTRA_DIST      = $(TEXIFILES) $(CHAPTERS) all-macros.texi

##FIXME: the Makefile rule for all-macros.texi is actually kept in the
## ../cfg.mk file, where it is called by the maintainer-all rule.
## This Makefile is unaware of that though, and can fail with the following
## message if `make maintainer-all` is not run before `make`:
## Updating ./version.texi
## make[1]: *** No rule to make target `all-macros.texi', needed by `autoconf-archive.info'.  Stop.
## Not sure where this should be fixed...
autoconf-archive.info:  autoconf-archive.texi all-macros.texi $(TEXIFILES) $(CHAPTERS)

maintainer-clean-local:
	@rm -f ax_*.texi all-macros.texi fdl-1.3.texi Makefile.in
	@rm -f *.aux *.cp *.fn *.ky *.log *.pg *.toc *.tp *.vr
	@rm -rf manual gendocs_template
