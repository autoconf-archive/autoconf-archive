# ===========================================================================
#         http://autoconf-archive.cryp.to/ac_define_versionlevel.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Superseded by AC_SET_VERSIONLEVEL.
#
# SYNOPSIS
#
#   AC_DEFINE_VERSIONLEVEL(VARNAME [,VERSION [, DESCRIPTION]])
#
# DESCRIPTION
#
#   if the VERSION is ommitted, shellvar $VERSION is used as defined by
#   AM_INIT_AUTOMAKE's second argument.
#
#   The versionlevel is the numeric representation of the given version
#   string, thereby assuming the inputversion is a string with (maximal)
#   three decimal numbers seperated by "."-dots. A "-patch" adds a percent.
#
#   typical usage: AM_INIT_AUTOMAKE(mypkg,4.12.3)
#   AC_DEFINE_VERSIONLEVEL(MYPKG_VERSION)
#
#   the config.h created from autoheader's config.h.in will contain... /*
#   mypkg versionlevel */ #define MYPKG_VERSION 4120003
#
#   the MYKG_VERSION will be defined as both a shell-variable and AC_DEFINE
#
#   examples:
#
#          3.0-beta1     3000001
#          3.1           3010000
#          3.11          3110000
#          3.11-dirpatch 3111000
#          3.11-patch6   3110006
#          2.2.18        2020018
#          2.0.112       2000112
#          2.4.2         2040002
#          2.4.2-pre     2040003
#          2.4.2-pre5    2040003
#          5.0-build125  5000125
#          5.0           5000000
#          0.30.17       30017
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

AC_DEFUN([AC_DEFINE_VERSIONLEVEL],
[
ac_versionlevel_strdf=`echo ifelse($2, , $VERSION, $2) | sed -e 's:[[A-Z-]]*:.:' -e 's:[[^0-9.]]::g' -e 's:^[[.]]*::'`
AC_MSG_CHECKING(versionlevel $ac_versionlevel_strdf)
case $ac_versionlevel_strdf in
 *.*.*.|*.*.*.*) :
 ac_versionlevel_major=`echo $ac_versionlevel_strdf`
 ac_versionlevel_minor=`echo $ac_versionlevel_major | sed -e 's/[[^.]]*[[.]]//'`
 ac_versionlevel_patch=`echo $ac_versionlevel_minor | sed -e 's/[[^.]]*[[.]]//'`
 ac_versionlevel_major=`echo $ac_versionlevel_major | sed -e 's/[[.]].*//'`
 ac_versionlevel_minor=`echo $ac_versionlevel_minor | sed -e 's/[[.]].*//'`
 ac_versionlevel_patch=`echo $ac_versionlevel_patch | sed -e 's/[[.]].*//'`
 $1=`expr $ac_versionlevel_major '*' 1000000 \
        + $ac_versionlevel_minor '*'   10000 \
        + $ac_versionlevel_patch \
	+ 1` ;;
 *.*.*) :
 ac_versionlevel_major=`echo $ac_versionlevel_strdf`
 ac_versionlevel_minor=`echo $ac_versionlevel_major | sed -e 's/[[^.]]*[[.]]//'`
 ac_versionlevel_patch=`echo $ac_versionlevel_minor | sed -e 's/[[^.]]*[[.]]//'`
 ac_versionlevel_major=`echo $ac_versionlevel_major | sed -e 's/[[.]].*//'`
 ac_versionlevel_minor=`echo $ac_versionlevel_minor | sed -e 's/[[.]].*//'`
 ac_versionlevel_patch=`echo $ac_versionlevel_patch | sed -e 's/[[.]].*//'`
 $1=`expr $ac_versionlevel_major '*' 1000000 \
        + $ac_versionlevel_minor '*'   10000 \
        + $ac_versionlevel_patch`               ;;
 *.*.) :
 ac_versionlevel_major=`echo $ac_versionlevel_strdf`
 ac_versionlevel_minor=`echo $ac_versionlevel_major | sed -e 's/[[^.]]*[[.]]//'`
 ac_versionlevel_major=`echo $ac_versionlevel_major | sed -e 's/[[.]].*//'`
 ac_versionlevel_minor=`echo $ac_versionlevel_minor | sed -e 's/[[.]].*//'`
 ac_versionlevel_patch=0
 $1=`expr $ac_versionlevel_major '*' 1000000 \
        + $ac_versionlevel_minor '*'   10000 \
	+ 1000 \
        + $ac_versionlevel_patch`               ;;
 *.*) :
 ac_versionlevel_major=`echo $ac_versionlevel_strdf`
 ac_versionlevel_minor=`echo $ac_versionlevel_major | sed -e 's/[[^.]]*[[.]]//'`
 ac_versionlevel_major=`echo $ac_versionlevel_major | sed -e 's/[[.]].*//'`
 ac_versionlevel_minor=`echo $ac_versionlevel_minor | sed -e 's/[[.]].*//'`
 ac_versionlevel_patch=0
 $1=`expr $ac_versionlevel_major '*' 1000000 \
        + $ac_versionlevel_minor '*'   10000 \
        + $ac_versionlevel_patch`               ;;
 *.) :
 ac_versionlevel_major=0
 ac_versionlevel_minor=`echo $ac_versionlevel_strdf`
 ac_versionlevel_minor=`echo $ac_versionlevel_minor | sed -e 's/[[.]].*//'`
 ac_versionlevel_patch=0
 $1=`expr $ac_versionlevel_major '*' 1000000 \
        + $ac_versionlevel_minor '*'   10000 \
	+ 1000 \
        + $ac_versionlevel_patch`               ;;
 *) :
 ac_versionlevel_major=0
 ac_versionlevel_minor=`echo $ac_versionlevel_strdf`
 ac_versionlevel_minor=`echo $ac_versionlevel_minor | sed -e 's/[[.]].*//'`
 ac_versionlevel_patch=0
 $1=`expr $ac_versionlevel_major '*' 1000000 \
        + $ac_versionlevel_minor '*'   10000 \
        + $ac_versionlevel_patch`               ;;
esac
AC_MSG_RESULT($[$1])
AC_DEFINE_UNQUOTED( $1, $[$1], ifelse( $3, , $PACKAGE versionlevel, $3))
])
