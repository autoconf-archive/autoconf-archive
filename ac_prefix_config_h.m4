# ===========================================================================
#           http://autoconf-archive.cryp.to/ac_prefix_config_h.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Use AX_PREFIX_CONFIG_H.
#
# SYNOPSIS
#
#   AC_PREFIX_CONFIG_H [(PREFIX [,ORIG-HEADER [,OUTPUT-HEADER]])]
#
# DESCRIPTION
#
#   takes the usual config.h generated header file; looks for each of the
#   generated "#define SOMEDEF" lines, and prefixes the defined name (ie.
#   makes it "#define PREFIX_SOMEDEF". The result is written to the output
#   config.header file. The PREFIX is converted to uppercase for the
#   conversions. If PREFIX is absent, $PACKAGE will be assumed. If the
#   ORIG-HEADER is absent, "config.h" will be assumed. If the OUTPUT-HEADER
#   is absent, "PREFIX-config.h" will be assumed.
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
#     AC_PREFIX_CONFIG_H                 # creates "testpkg-config.h"
#           and the resulting "testpkg-config.h" contains lines like
#     #define TESTPKG_VERSION "0.1.1"
#     #define TESTPKG_NEED_MEMORY_H 1
#     #define TESTPKG_const const
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

AC_DEFUN([AC_PREFIX_CONFIG_H],
[changequote(<<, >>)dnl
ac_prefix_conf_PKG=`echo ifelse($1, , $PACKAGE, $1)`
ac_prefix_conf_PRE=`echo $ac_prefix_conf_PKG | tr 'abcdefghijklmnopqrstuvwxyz-' 'ABCDEFGHIJKLMNOPQRSTUVWXYZ_'`
ac_prefix_conf_PRE=`echo $ac_prefix_conf_PRE | sed -e '/^[0-9]/s/^/_/'`
ac_prefix_conf_INP=`echo ifelse($2, , config.h, $2)`
ac_prefix_conf_OUT=`echo ifelse($3, , $ac_prefix_conf_PKG-$ac_prefix_conf_INP, $3)`
ac_prefix_conf_DEF=`echo _$ac_prefix_conf_OUT | tr 'abcdefghijklmnopqrstuvwxyz./,-' 'ABCDEFGHIJKLMNOPQRSTUVWXYZ____'`
changequote([, ])dnl
if test -z "$ac_prefix_conf_PKG" ; then
   AC_MSG_ERROR([no prefix for _PREFIX_CONFIG_H])
else
  AC_MSG_RESULT(creating $ac_prefix_conf_OUT - prefix $ac_prefix_conf_PRE for $ac_prefix_conf_INP defines)
  if test -f $ac_prefix_conf_INP ; then
    echo '#ifndef '$ac_prefix_conf_DEF >$ac_prefix_conf_OUT
    echo '#define '$ac_prefix_conf_DEF' 1' >>$ac_prefix_conf_OUT
    echo ' ' >>$ac_prefix_conf_OUT
    echo /'*' $ac_prefix_conf_OUT. Generated automatically at end of configure. '*'/ >>$ac_prefix_conf_OUT

    echo 's/#undef  */#undef '$ac_prefix_conf_PRE'_/' >conftest.sed
    echo 's/#define  *\([A-Za-z0-9_]*\)\(.*\)/#ifndef '$ac_prefix_conf_PRE"_\\1 \\" >>conftest.sed
    echo '#define '$ac_prefix_conf_PRE"_\\1 \\2 \\" >>conftest.sed
    echo '#endif/' >>conftest.sed
    sed -f conftest.sed $ac_prefix_conf_INP >>$ac_prefix_conf_OUT
    echo ' ' >>$ac_prefix_conf_OUT
    echo '/*' $ac_prefix_conf_DEF '*/' >>$ac_prefix_conf_OUT
    echo '#endif' >>$ac_prefix_conf_OUT
  else
    AC_MSG_ERROR([input file $ac_prefix_conf_IN does not exist, dnl
    skip generating $ac_prefix_conf_OUT])
  fi
  rm -f conftest.*
fi])
