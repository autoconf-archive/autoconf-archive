# ===========================================================================
#       http://autoconf-archive.cryp.to/ac_create_prefix_config_h.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Use AX_PREFIX_CONFIG_H.
#
# SYNOPSIS
#
#   AC_CREATE_PREFIX_CONFIG_H [(OUTPUT-HEADER [,PREFIX [,ORIG-HEADER]])]
#
# DESCRIPTION
#
#   * this is a new variant from ac_prefix_config_ this one will use a
#   lowercase-prefix if the config-define was starting with a
#   lowercase-char, e.g.
#
#     #define const or #define restrict or #define off_t
#
#   (and this one can live in another directory, e.g. testpkg/config.h
#   therefore I decided to move the output-header to be the first arg)
#
#   takes the usual config.h generated header file; looks for each of the
#   generated "#define SOMEDEF" lines, and prefixes the defined name (ie.
#   makes it "#define PREFIX_SOMEDEF". The result is written to the output
#   config.header file. The PREFIX is converted to uppercase for the
#   conversions.
#
#    - default OUTPUT-HEADER = $PACKAGE-config.h
#    - default PREFIX = $PACKAGE
#    - default ORIG-HEADER, derived from OUTPUT-HEADER
#
#           if OUTPUT-HEADER has a "/", use the basename
#           if OUTPUT-HEADER has a "-", use the section after it.
#           otherwise, just config.h
#
#   In most cases, the configure.in will contain a line saying
#
#           AC_CONFIG_HEADER(config.h)
#
#   somewhere *before* AC_OUTPUT and a simple line saying
#
#          AC_PREFIX_CONFIG_HEADER
#
#   somewhere *after* AC_OUTPUT.
#
#   example:
#
#     AC_INIT(config.h.in)        # config.h.in as created by "autoheader"
#     AM_INIT_AUTOMAKE(testpkg, 0.1.1)   # "#undef VERSION" and "PACKAGE"
#     AM_CONFIG_HEADER(config.h)         #                in config.h.in
#     AC_MEMORY_H                        # "#undef NEED_MEMORY_H"
#     AC_C_CONST_H                       # "#undef const"
#     AC_OUTPUT(Makefile)                # creates the "config.h" now
#     AC_CREATE_PREFIX_CONFIG_H          # creates "testpkg-config.h"
#           and the resulting "testpkg-config.h" contains lines like
#     #ifndef TESTPKG_VERSION
#     #define TESTPKG_VERSION "0.1.1"
#     #endif
#     #ifndef TESTPKG_NEED_MEMORY_H
#     #define TESTPKG_NEED_MEMORY_H 1
#     #endif
#     #ifndef _testpkg_const
#     #define _testpkg_const const
#     #endif
#
#     and this "testpkg-config.h" can be installed along with other
#     header-files, which is most convenient when creating a shared
#     library (that has some headers) where some functionality is
#     dependent on the OS-features detected at compile-time. No
#     need to invent some "testpkg-confdefs.h.in" manually. :-)
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 2 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Macro Archive. When you make and
#   distribute a modified version of the Autoconf Macro, you may extend this
#   special exception to the GPL to apply to your modified version as well.

AC_DEFUN([AC_CREATE_PREFIX_CONFIG_H],
[changequote({, })dnl
ac_prefix_conf_OUT=`echo ifelse($1, , $PACKAGE-config.h, $1)`
ac_prefix_conf_DEF=`echo _$ac_prefix_conf_OUT | sed -e 'y:abcdefghijklmnopqrstuvwxyz./,-:ABCDEFGHIJKLMNOPQRSTUVWXYZ____:'`
ac_prefix_conf_PKG=`echo ifelse($2, , $PACKAGE, $2)`
ac_prefix_conf_LOW=`echo _$ac_prefix_conf_PKG | sed -e 'y:ABCDEFGHIJKLMNOPQRSTUVWXYZ-:abcdefghijklmnopqrstuvwxyz_:'`
ac_prefix_conf_UPP=`echo $ac_prefix_conf_PKG | sed -e 'y:abcdefghijklmnopqrstuvwxyz-:ABCDEFGHIJKLMNOPQRSTUVWXYZ_:'  -e '/^[0-9]/s/^/_/'`
ac_prefix_conf_INP=`echo ifelse($3, , _, $3)`
if test "$ac_prefix_conf_INP" = "_"; then
   case $ac_prefix_conf_OUT in
      */*) ac_prefix_conf_INP=`basename $ac_prefix_conf_OUT`
      ;;
      *-*) ac_prefix_conf_INP=`echo $ac_prefix_conf_OUT | sed -e 's/[a-zA-Z0-9_]*-//'`
      ;;
      *) ac_prefix_conf_INP=config.h
      ;;
   esac
fi
changequote([, ])dnl
if test -z "$ac_prefix_conf_PKG" ; then
   AC_MSG_ERROR([no prefix for _PREFIX_PKG_CONFIG_H])
else
  AC_MSG_RESULT(creating $ac_prefix_conf_OUT - prefix $ac_prefix_conf_UPP for $ac_prefix_conf_INP defines)
  if test -f $ac_prefix_conf_INP ; then
    AC_ECHO_MKFILE([/* automatically generated */], $ac_prefix_conf_OUT)
changequote({, })dnl
    echo '#ifndef '$ac_prefix_conf_DEF >>$ac_prefix_conf_OUT
    echo '#define '$ac_prefix_conf_DEF' 1' >>$ac_prefix_conf_OUT
    echo ' ' >>$ac_prefix_conf_OUT
    echo /'*' $ac_prefix_conf_OUT. Generated automatically at end of configure. '*'/ >>$ac_prefix_conf_OUT

    echo 's/#undef  *\([A-Z_]\)/#undef '$ac_prefix_conf_UPP'_\1/' >conftest.sed
    echo 's/#undef  *\([a-z]\)/#undef '$ac_prefix_conf_LOW'_\1/' >>conftest.sed
    echo 's/#define  *\([A-Z_][A-Za-z0-9_]*\)\(.*\)/#ifndef '$ac_prefix_conf_UPP"_\\1 \\" >>conftest.sed
    echo '#define '$ac_prefix_conf_UPP"_\\1 \\2 \\" >>conftest.sed
    echo '#endif/' >>conftest.sed
    echo 's/#define  *\([a-z][A-Za-z0-9_]*\)\(.*\)/#ifndef '$ac_prefix_conf_LOW"_\\1 \\" >>conftest.sed
    echo '#define '$ac_prefix_conf_LOW"_\\1 \\2 \\" >>conftest.sed
    echo '#endif/' >>conftest.sed
    sed -f conftest.sed $ac_prefix_conf_INP >>$ac_prefix_conf_OUT
    echo ' ' >>$ac_prefix_conf_OUT
    echo '/*' $ac_prefix_conf_DEF '*/' >>$ac_prefix_conf_OUT
    echo '#endif' >>$ac_prefix_conf_OUT
changequote([, ])dnl
  else
    AC_MSG_ERROR([input file $ac_prefix_conf_IN does not exist, dnl
    skip generating $ac_prefix_conf_OUT])
  fi
  rm -f conftest.*
fi])
