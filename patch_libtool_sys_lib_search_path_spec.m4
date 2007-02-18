##### http://autoconf-archive.cryp.to/patch_libtool_sys_lib_search_path_spec.html
#
# OBSOLETE MACRO
#
#   The problem is fixed in modern libtool versions.
#
# SYNOPSIS
#
#   PATCH_LIBTOOL_SYS_LIB_SEARCH_PATH_SPEC
#
# DESCRIPTION
#
#   Cross-compiling to win32 from a unix system reveals a bug - the
#   path-separator has been set to ";" depending on the target system.
#   However, the crossgcc search_path_spec works in a unix-environment
#   with unix-style directories and unix-stylish path_separator. The
#   result: the search_path_spec is a single word still containing the
#   ":" separators.
#
#   This macro fixes the situation: when we see the libtool PATH_SEP to
#   be ":" and search_path_spec to contain ":" characters, then these
#   are replaced with spaces to let the resulting string work as a
#   for-loop argument in libtool scripts that resolve -no-undefined
#   libraries.
#
#   Later libtool generations have fixed the situation with using
#   $PATH_SEPARATOR in the first place as the original path delimiter
#   that will be scanned for and replaced into spaces.
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

AC_DEFUN([PATCH_LIBTOOL_SYS_LIB_SEARCH_PATH_SPEC],
[# patch libtool to fix sys_lib_search_path (e.g. crosscompiling a win32 dll)
if test "_$PATH_SEPARATOR" = "_:" ; then
  if grep "^sys_lib_search_path_spec.*:" libtool >/dev/null ; then
AC_MSG_RESULT(patching libtool to fix sys_lib_search_path_spec)
    test -f libtool.old || (mv libtool libtool.old && cp libtool.old libtool)
    sed -e "/^sys_lib_search_path_spec/s/:/ /g" libtool >libtool.new
    (test -s libtool.new || rm libtool.new) 2>/dev/null
    test -f libtool.new && mv libtool.new libtool # not 2>/dev/null !!
    test -f libtool     || mv libtool.old libtool
  fi
fi
])
