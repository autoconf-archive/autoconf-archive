##### http://autoconf-archive.cryp.to/ac_check_java_home.html
#
# SYNOPSIS
#
#   AC_CHECK_JAVA_HOME
#
# DESCRIPTION
#
#   Check for Sun Java (JDK / JRE) installation, where the 'java' VM is
#   in. If found, set environment variable JAVA_HOME = Java
#   installation home, else left JAVA_HOME untouch, which in most case
#   means JAVA_HOME is empty.
#
# LAST MODIFICATION
#
#   2002-10-10
#
# COPYLEFT
#
#   Copyright (c) 2002 Gleen Salmon <gleensalmon@yahoo.com>
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
#   02111-1307, USA.
#
#   As a special exception, the respective Autoconf Macro's copyright
#   owner gives unlimited permission to copy, distribute and modify the
#   configure scripts that are the output of Autoconf when processing
#   the Macro. You need not follow the terms of the GNU General Public
#   License when using or distributing such scripts, even though
#   portions of the text of the Macro appear in them. The GNU General
#   Public License (GPL) does govern all other use of the material that
#   constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the
#   Autoconf Macro released by the Autoconf Macro Archive. When you
#   make and distribute a modified version of the Autoconf Macro, you
#   may extend this special exception to the GPL to apply to your
#   modified version as well.

AC_DEFUN([AC_CHECK_JAVA_HOME],[
AC_REQUIRE([AC_EXEEXT])dnl
TRY_JAVA_HOME=`ls -dr /usr/java/* 2> /dev/null | head -n 1`
if test x$TRY_JAVA_HOME != x; then
	PATH=$PATH:$TRY_JAVA_HOME/bin
fi
AC_PATH_PROG(JAVA_PATH_NAME, java$EXEEXT)
if test x$JAVA_PATH_NAME != x; then
	JAVA_HOME=`echo $JAVA_PATH_NAME | sed "s/\(.*\)[[/]]bin[[/]]java$EXEEXT$/\1/"`
fi;dnl
])
