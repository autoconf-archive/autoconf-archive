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
# this program. If not, see <https://www.gnu.org/licenses/>.

CHAPTERS        = introduction.texi downloads.texi contribute.texi fdl-1.3.texi
info_TEXINFOS   = autoconf-archive.texi
EXTRA_DIST      = $(TEXIFILES) $(CHAPTERS) all-macros.texi

autoconf-archive.info:  autoconf-archive.texi all-macros.texi $(TEXIFILES) $(CHAPTERS)

maintainer-clean-local:
	@rm -f ax_*.texi all-macros.texi fdl-1.3.texi Makefile.in
	@rm -f *.aux *.cp *.fn *.ky *.log *.pg *.toc *.tp *.vr
	@rm -rf manual gendocs_template gendocs_template_min
