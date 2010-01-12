dnl configure the Autoconf Archive

AC_INIT([autoconf-archive], m4_esyscmd([build-aux/git-version-gen .tarball-version]), [autoconf-archive-maintainers@nongnu.org])
AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([1.11 -Wall gnu dist-bzip2 dist-xz])
AC_CONFIG_SRCDIR([doc/autoconf-archive.texi])
AC_COPYRIGHT([dnl
Compilation Copyright 2010 Autoconf Archive Maintainers

This compilation is free software: you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This compilation is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.])

AC_MSG_NOTICE([Autoconf Archive version $VERSION])

M4FILES="m4_esyscmd([echo -n m4/*.m4])"
AC_SUBST([M4FILES])

TEXIFILES="m4_esyscmd([cd m4 && echo -n *.m4 | sed -e 's/\.m4/.texi/g'])"
AC_SUBST([TEXIFILES])

AC_CONFIG_FILES([Makefile doc/Makefile])
AC_OUTPUT

dnl Responsibility shifts to the user after this point.
