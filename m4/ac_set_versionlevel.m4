# ===========================================================================
#          http://autoconf-archive.cryp.to/ac_set_versionlevel.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_SET_VERSIONLEVEL(VARNAME [,VERSION])
#
# DESCRIPTION
#
#   If the VERSION is ommitted, shellvar $VERSION is used as defined by
#   AM_INIT_AUTOMAKE's second argument.
#
#   The versionlevel is the numeric representation of the given version
#   string, thereby assuming the inputversion is a string with (maximal)
#   three decimal numbers seperated by "."-dots. A "-patch" adds a percent.
#
#   Typical usage:
#
#    AM_INIT_AUTOMAKE(mypkg,4.12.3)
#    AC_SET_VERSIONLEVEL(MYPKG_VERSION)
#    AC_DEFINE_UNQUOTED(MYPKG_VERSION, $MYPKG_VERSION, [package version])
#
#   The version code has three digits per part which I feel is the most
#   natural encoding - it makes it easier to be printf'd anyway.
#
#   Examples:
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

AC_DEFUN([AC_SET_VERSIONLEVEL],
[dnl
m4_pushdef(LVL, $1_LEVEL)
m4_pushdef(MJR, $1_MAJOR)
m4_pushdef(MNR, $1_MINOR)
m4_pushdef(MCR, $1_MICRO)
LVL=`echo ifelse($2, , $VERSION, $2) | sed -e 's:[[A-Z-]]*:.:g' -e 's:[[^0-9.]]::g' -e 's:[[.]]*:.:g' -e 's:^[[.]]*::'`
AC_MSG_CHECKING( $1 versionlevel $LVL)
case $LVL in
 *.*.*.|*.*.*.*|*.*.*) :
 MJR=`echo $LVL`
 MNR=`echo $MJR | sed -e 's/[[^.]]*[[.]]//'`
 MCR=`echo $MNR | sed -e 's/[[^.]]*[[.]]//'`
 MJR=`echo $MJR | sed -e 's/[[.]].*//'`
 MNR=`echo $MNR | sed -e 's/[[.]].*//'`
 MCR=`echo $MCR | sed -e 's/[[.]].*//'`
 ;;
 *.*.|*.*) :
 MJR=`echo $LVL`
 MNR=`echo $MJR | sed -e 's/[[^.]]*[[.]]//'`
 MJR=`echo $MJR | sed -e 's/[[.]].*//'`
 MNR=`echo $MNR | sed -e 's/[[.]].*//'`
 MCR=0
 ;;
 *.) :
 MJR=0
 MNR=`echo $LVL`
 MNR=`echo $MNR | sed -e 's/[[.]].*//'`
 MCR=0
 ;;
esac
# we trust sed greedy-match backtracking to extract the last three digits from each part, forming a nine-digit
$1=`echo 000$MJR.000$MNR.000$MCR | sed -e 's:\\(...\\)[[.]][[^.]]*\\((...\\))[[.]][[^.*]]\\((...\\)):\\1\\2\\3 -e 's:^0*::''
AC_MSG_RESULT($[$1] ($MJR,$MNR,$MCR)
dnl AC_DEFINE_UNQUOTED( $1, $[$1], ifelse( $3, , $PACKAGE versionlevel, $3))
m4_popdef(MCR)
m4_popdef(MNR)
m4_popdef(MJR)
m4_popdef(LVL)
])
