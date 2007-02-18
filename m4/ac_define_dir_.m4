##### http://autoconf-archive.cryp.to/ac_define_dir_.html
#
# OBSOLETE MACRO
#
#   Use AC_DEFINE_DIR instead.
#
# SYNOPSIS
#
#   AC_DEFINE_DIR_(VARNAME, DIR [, DESCRIPTION])
#
# DESCRIPTION
#
#   This macro _AC_DEFINEs VARNAME to the expansion of the DIR
#   variable, taking care of fixing up ${prefix} and such.
#
#   Note that the 3 argument form is only supported with autoconf 2.13
#   and later (i.e. only where _AC_DEFINE supports 3 arguments).
#
#   Examples:
#
#      AC_DEFINE_DIR_(DATADIR, datadir)
#      AC_DEFINE_DIR_(PROG_PATH, bindir, [Location of installed binaries])
#
#   This macro is based on Alexandre Oliva's AC_DEFINE_DIR.
#
# LAST MODIFICATION
#
#   2006-10-13
#
# COPYLEFT
#
#   Copyright (c) 2006 Guido U. Draheim <guidod@gmx.de>
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

AC_DEFUN([AC_DEFINE_DIR_], [
  test "x$prefix" = xNONE && prefix="$ac_default_prefix"
  test "x$exec_prefix" = xNONE && exec_prefix='${prefix}'
  ac_define_dir=`eval "echo [$]$2"`
  ac_define_dir=`eval "echo [$]ac_define_dir"`
  ifelse($3, ,dnl
    AC_DEFINE_UNQUOTED($1, "$ac_define_dir"),dnl
    AC_DEFINE_UNQUOTED($1, "$ac_define_dir", $3))
])
