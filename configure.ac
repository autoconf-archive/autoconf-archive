dnl Configure the GNU Autoconf Archive.
dnl
dnl This file is free software; as a special exception the author gives
dnl unlimited permission to copy and/or distribute it, with or without
dnl modifications, as long as this notice is preserved.
dnl
dnl This program is distributed in the hope that it will be useful, but
dnl WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
dnl implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

AC_INIT([GNU Autoconf Archive], m4_esyscmd([build-aux/git-version-gen .tarball-version]),
	[autoconf-archive-maintainers@gnu.org], [autoconf-archive],
	[https://www.gnu.org/software/autoconf-archive/])
AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([1.11 -Wall gnu no-dist-gzip dist-xz])
AC_PREREQ([2.65])
AC_CONFIG_SRCDIR([doc/autoconf-archive.texi])
AC_MSG_NOTICE([$PACKAGE_STRING])

AC_PROG_SED

M4FILES="m4_esyscmd([echo -n m4/*.m4])"
AC_SUBST([M4FILES])

TEXIFILES="m4_esyscmd([cd m4 && echo -n *.m4 | sed -e 's/\.m4/.texi/g'])"
AC_SUBST([TEXIFILES])

AC_CONFIG_FILES([Makefile doc/Makefile])
AC_OUTPUT

dnl Responsibility shifts to the user after this point.
