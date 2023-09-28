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

AC_INIT([GNU Autoconf Archive],[m4_esyscmd([build-aux/git-version-gen .tarball-version])],
	[autoconf-archive-maintainers@gnu.org], [autoconf-archive],
	[https://www.gnu.org/software/autoconf-archive/])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_TESTDIR([test])
AM_INIT_AUTOMAKE([1.11 -Wall gnu no-dist-gzip dist-xz dist-lzip])
AC_REQUIRE_AUX_FILE([mdate-sh])
AM_MAINTAINER_MODE([enable])
AC_PREREQ([2.65])
AC_CONFIG_SRCDIR([doc/autoconf-archive.texi])
AC_MSG_NOTICE([$PACKAGE_STRING])

dnl# keep the macros used by this script separate from the ones we ship:
AC_CONFIG_MACRO_DIR([build-aux]) dnl# (this is where gnulib-tool puts them)

AC_PROG_CC dnl# autoscan says "wanted by: build-aux/dummy.c"
gl_EARLY dnl# gnulib-tool says to put this right after the previous one.
AC_PROG_LN_S dnl# autoscan says "wanted by: build-aux/gendocs.sh:341"
AC_PROG_SED
AC_PATH_PROG([CONFIGURED_TEXI2DVI],[texi2dvi],[texi2dvi])dnl

gl_INIT dnl# gnulib-tool says not to forget to invoke this.

dnl# `echo -n` is non-portable, but luckily autoconf gives us a way to deal
dnl# with that. We have to get rid of the outer m4 system command wrapper
dnl# to be able to do this though. Also have to use escaped quotation marks
dnl# to ensure that a space follows each file name, which keeps them
dnl# separated. This has to be done in a loop because otherwise the
dnl# globbing character ('*') gets output as a literal.
dnl# Also the variable has to be exported so that config.status can use it.
export M4FILES="`for m4file in ${srcdir}/m4/*.m4; do AS_ECHO_N([\"${m4file} \"]); done`"
AC_SUBST([M4FILES])dnl

export TEXIFILES="`cd ${srcdir}/m4 && for m4file in *.m4; do AS_ECHO_N([\"${m4file} \"]); done | sed -e 's/\.m4/.texi/g'`"
AC_SUBST([TEXIFILES])dnl

dnl# Just in case the above got screwed up and the filenames still
dnl# run together, check this:
AC_SYS_LONG_FILE_NAMES

dnl# gnulib-comp.m4 does something similar with GNUMakefile:
# Autoconf 2.61a.99 and earlier do NOT support linking a file only
# in VPATH builds.  But since cfg.mk is for maintainer use
# only, it does not matter if we skip the link with older autoconf.
# Automake 1.10.1 and earlier try to remove cfg.mk in non-VPATH
# builds, so use a shell variable to bypass this.
export cfg_mk=cfg.mk
m4_if(m4_version_compare([2.61a.100],
        m4_defn([m4_PACKAGE_VERSION])),[1],[],
      [AC_CONFIG_LINKS([${cfg_mk}:${cfg_mk}],[],
        [cfg_mk=${cfg_mk}])])dnl
AC_SUBST([cfg_mk])dnl

M4FILES="m4_esyscmd_s([echo m4/*.m4])"
AC_SUBST([M4FILES])dnl

TEXIFILES="m4_esyscmd_s([cd m4 && echo *.m4 | ${SED} -e 's/\.m4/.texi/g'])"
AC_SUBST([TEXIFILES])dnl

dnl# double-m4-quote this, to allow echo-ing stuff that would normally also
dnl# be interpreted as m4:
AC_CONFIG_COMMANDS([test/acinclude.m4],[[
  ## N.B.: we have to cheat and use the ac_... version because
  ## abs_top_builddir is not yet set, sigh.
  if test -e ${ac_abs_top_builddir}/test/acinclude.m4; then
    rm -f ${ac_abs_top_builddir}/test/acinclude.m4 || true
  fi
  touch ${ac_abs_top_builddir}/test/acinclude.m4
  for m4file in ${M4FILES}; do
    ## still need to use quadrigraphs though, because aclocal is stupid and
    ## ignores the m4-quotation:
    echo "m4@&t@_@&t@in@&t@clude@{:@@<:@${ac_abs_top_srcdir}/${m4file}@:>@@:}@d@&t@n@&t@l" >> ${ac_abs_top_builddir}/test/acinclude.m4
  done
]])dnl

dnl# Output:
AC_CONFIG_FILES([Makefile doc/Makefile])
AC_CONFIG_FILES([test/atlocal test/configure.ac test/Makefile])
AC_CONFIG_FILES([build-aux/Makefile]) dnl# gnulib-tool says to do this.
AC_OUTPUT

dnl Responsibility shifts to the user after this point.
