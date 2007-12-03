##### http://autoconf-archive.cryp.to/ax_missing_prog.html
#
# SYNOPSIS
#
#   AX_MISSING_PROG(VARIABLE,PROGRAM,[MESSAGE])
#
# DESCRIPTION
#
#   Simple wrapper to the AM_MISSING_PROG which displays a MESSAGE
#   whenever provided. A typical use is the following:
#
#     AC_PROG_AWK
#     AS_IF([test -z "$AWK"],[
#       AX_MISSING_PROG(AWK,[awk],[grep seems missing ...])
#     ])
#
#   If you need to use AC_PATH_PROG, use AX_PATH_MISSING instead.
#
# LAST MODIFICATION
#
#   2007-11-28
#
# COPYLEFT
#
#   Copyright (c) 2007 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

AC_DEFUN([AX_MISSING_PROG],[dnl
  AS_IF([ test ! -z "$3" ],[
    AC_MSG_WARN([$3])
  ])
  AM_MISSING_PROG([$1],[$2])
])
