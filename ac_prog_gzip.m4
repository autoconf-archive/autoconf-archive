##### http://autoconf-archive.cryp.to/ac_prog_gzip.html
#
# OBSOLETE MACRO
#
#   Replaced by ACLTX_PROG_GZIP.
#
# SYNOPSIS
#
#   AC_PROG_GZIP
#
# DESCRIPTION
#
#   This macro test if gzip is installed. If gzip is installed, it set
#   $gzip to the right value
#
# LAST MODIFICATION
#
#   2006-07-16
#
# COPYLEFT
#
#   Copyright (c) 2006 Mathieu Boretti <boretti@eig.unige.ch>
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

AC_DEFUN([AC_PROG_GZIP],[
AC_CHECK_PROGS(gzip,[gzip],no)
export gzip;
if test $gzip = "no" ;
then
	AC_MSG_ERROR([Unable to find the gzip application]);
fi
AC_SUBST(gzip)
])
