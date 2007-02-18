##### http://autoconf-archive.cryp.to/patch_libtool_on_darwin_pass_all.html
#
# OBSOLETE MACRO
#
#   The problem is fixed in modern libtool versions.
#
# SYNOPSIS
#
#   PATCH_LIBTOOL_ON_DARWIN_PASS_ALL
#
# DESCRIPTION
#
#   libtool 1.4.x on darwin uses a lib_check with a file_magic that
#   tests for "Mach-O dynamically linked shared library". However, this
#   is the file_magic for ".dylib" sharedlibraries but not for ".so"
#   sharedlibraries. They have another "file -L" result of "Mach-O
#   bundle ppc", which has an annoying result: when a a module (a .so)
#   is dependent on another module (another .so) then libtool will
#   error out and say that the import-module was not found where in
#   fact it is available. It does not even try to call the real linker.
#
#   Later libtool generations have changed the processing, the import
#   file_check has been changed from "file_magic" to "pass_all". This
#   ac-macro does a similar thing: it checks for the darwin host, it
#   checks for the check_method, and when it was not "pass_all" then we
#   set it to "deplibs_check_method=pass_all"
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

AC_DEFUN([PATCH_LIBTOOL_ON_DARWIN_PASS_ALL],
[# libtool-1.4 specific, on darwin set deplibs_check_method=pass_all
case "$host_os" in
  darwin*)
    if grep "^deplibs_check_method=.*file_magic" libtool >/dev/null ; then
AC_MSG_RESULT(patching libtool to set deplibs_check_method=pass_all)
      test -f libtool.old || (mv libtool libtool.old && cp libtool.old libtool)
      sed -e '/^deplibs_check_method=/s/=.*/="pass_all"/' libtool >libtool.new
      (test -s libtool.new || rm libtool.new) 2>/dev/null
      test -f libtool.new && mv libtool.new libtool # not 2>/dev/null !!
      test -f libtool     || mv libtool.old libtool
    fi
  ;;
esac
])
