##### http://autoconf-archive.cryp.to/ac_define_path_style.html
#
# SYNOPSIS
#
#   AC_DEFINE_PATH_STYLE ([defvar-name])
#
# DESCRIPTION
#
#   _AC_DEFINE(PATH_STYLE) describing the filesys interface. The value
#   is numeric, where the basetype is encoded as 16 = dos/win, 32 =
#   unix, 64 = url/www, 0 = other
#
#   note that there could be a combination of the values that should
#   lead you to accept multiple forms of PATH_SEP and DIR_SEP
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

AC_DEFUN([AC_DEFINE_PATH_STYLE], [
AC_CACHE_CHECK([for path style], ac_cv_path_style,
[
  if test -z "$ac_cv_path_style"; then
    case "$target_os" in
      *djgpp | *mingw32* | *emx*) ac_cv_path_style="dos" ;;
      *) ac_cv_path_style="unix" ;;    # it is just the default ;-)
    esac
    if test "$ac_cv_path_style" = "unix" ; then
      _exec_prefix=`eval "echo $exec_prefix"`
      _exec_prefix=`eval "echo $_exec_prefix"`
      case "$_exec_prefix" in
        *:*) ac_cv_path_style="url" ;;
        *\\) ac_cv_path_style="dos" ;;
      esac
    fi
  fi
])
case "$ac_cv_path_style" in
  *dos*)  ac_define_path_style=16 ;;
  *unix*) ac_define_path_style=32 ;;
  *url*)  ac_define_path_style=64 ;;
  *mac*)  ac_define_path_style=128 ;;
  *) ac_define_path_style=1
esac
AC_DEFINE_UNQUOTED(PATH_STYLE,$ac_define_path_style,dnl
   [path style 16=dos 32=unix 64=url 128=mac])dnl
])
