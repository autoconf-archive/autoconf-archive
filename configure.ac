dnl# autoscan output comes with a modeline for emacs:      -*- Autoconf -*-
dnl
dnl Configure the GNU Autoconf Archive.
dnl
dnl This file is free software; as a special exception the author gives
dnl unlimited permission to copy and/or distribute it, with or without
dnl modifications, as long as this notice is preserved.
dnl
dnl This program is distributed in the hope that it will be useful, but
dnl WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
dnl implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

AC_INIT([GNU Autoconf Archive],[m4_esyscmd(build-aux/git-version-gen .tarball-version)],[autoconf-archive-maintainers@gnu.org],[autoconf-archive],[http://www.gnu.org/software/autoconf-archive/])
AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([1.11 -Wall gnu no-dist-gzip dist-xz dist-lzip])
AM_MAINTAINER_MODE
AC_PREREQ([2.68])
AC_CONFIG_SRCDIR([doc/autoconf-archive.texi])
AC_MSG_NOTICE([$PACKAGE_STRING])

dnl# keep the macros used by this script separate from the ones we ship:
AC_CONFIG_MACRO_DIR([build-aux]) dnl# (this is where gnulib-tool puts them)

dnl# gnulib-tool no longer imports the dummy.c file, so we no longer
dnl# require checks for a C compiler.
gl_EARLY dnl# gnulib-tool says to not to forget to invoke this.
AC_PROG_LN_S dnl# autoscan says "wanted by: build-aux/gendocs.sh:341"
AC_PROG_SED

gl_INIT dnl# gnulib-tool says not to forget to invoke this.

dnl# `echo -n` is non-portable, but luckily autoconf gives us a way to deal
dnl# with that. We have to get rid of the outer m4 system command wrapper
dnl# to be able to do this though. Also have to use escaped quotation marks
dnl# to ensure that a space follows each file name, which keeps them
dnl# separated. This has to be done in a loop because otherwise the
dnl# globbing character ('*') gets output as a literal.
M4FILES="`for m4file in ${srcdir}/m4/*.m4; do AS_ECHO_N([\"${m4file} \"]); done`"
AC_SUBST([M4FILES])

TEXIFILES="`cd ${srcdir}/m4 && for m4file in *.m4; do AS_ECHO_N([\"${m4file} \"]); done | sed -e 's/\.m4/.texi/g'`"
AC_SUBST([TEXIFILES])

dnl# Just in case the above got screwed up and the filenames still
dnl# run together, check this:
AC_SYS_LONG_FILE_NAMES

dnl# Output:
AC_CONFIG_FILES([Makefile doc/Makefile])
AC_CONFIG_FILES([build-aux/Makefile]) dnl# gnulib-tool says to do this.
AC_OUTPUT

dnl Responsibility shifts to the user after this point.
