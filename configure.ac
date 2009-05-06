dnl configure the Autoconf Archive

AC_INIT([autoconf-archive], [2009-04-29], [simons@cryp.to])
AM_INIT_AUTOMAKE([-Wall gnu no-dist-gzip dist-bzip2])
AC_CONFIG_SRCDIR([html/autoconf-archive.css])

AC_COPYRIGHT([dnl
Copyright (c) 2009 by Peter Simons <simons@cryp.to>

This compilation is free software: you can redistribute it and/or
modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This compilation is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
General Public License for more details.])

AC_MSG_CHECKING([for available Autoconf macros])
M4SOURCE=""
for n in ${srcdir}/m4/*.m4 ; do
  M4SOURCE="${M4SOURCE} ${n}"
done
AC_SUBST([M4SOURCE])
AC_MSG_RESULT([done])

AC_MSG_CHECKING([for available documentation])
HTMLDOC=""
for n in ${srcdir}/html/*.html ${srcdir}/html/*.css ; do
  HTMLDOC="${HTMLDOC} ${n}"
done
AC_SUBST([HTMLDOC])
AC_MSG_RESULT([done])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
