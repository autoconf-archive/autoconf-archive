# ===========================================================================
#      http://autoconf-archive.cryp.to/patch_libtool_to_add_host_cc.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   The problem is fixed in modern libtool versions.
#
# SYNOPSIS
#
#   PATCH_LIBTOOL_TO_ADD_HOST_CC
#
# DESCRIPTION
#
#   The libtool 1.4.x processing (and patched 1.3.5) uses a little "impgen"
#   tool to turn a "*.dll" into an import "*.lib" as it is needed for win32
#   targets. However, this little tool is not shipped by binutils, it is not
#   even a command option of dlltool or dllwrap. It happens to be a C source
#   snippet implanted into the libtool sources - it gets written to ".libs",
#   compiled into a binary on-the-fly, and executed right away on the "dll"
#   file to create the import-lib (dll.a files in gcc-speak).
#
#   This mode works fine for a native build within mingw or cygwin, but it
#   does not work in cross-compile mode since CC is a crosscompiler - it
#   will create an .exe file on a non-win32 system, and as a result an
#   impgen.exe is created on-the-fly that can not be executed on-the-fly.
#   Luckily, the actual libtool snippet uses HOST_CC to compile the sources
#   which has a fallback to CC when the HOST_CC variable was not set.
#
#   this ac-macro is trying to detect a valid HOST_CC which is not a
#   cross-compiler. This is done by looking into the $PATH for a "cc" and
#   the result is patched into libtool a HOST_CC, iow it adds another
#   configured variable at the top of the libtool script.
#
#   In discussions on the libtool mailinglist it occurred that later
#   gcc/binutils generations are able to link with dlls directly, i.e. there
#   is no import-lib needed anymore. The import-table is created within the
#   linker itself (in-memory) and bound to the .exe/.dll currently in the
#   making. The whole stuff of impgen exe and compiling it on-the-fly, well,
#   it is superflouos then.
#
#   Since mingw crosscompilers tend to be quite a fresh development it was
#   agreed to remove the impgen stuff completly from libtool sources. Still
#   however, this macro does not hurt since it does not patch impgen cmds
#   but it just adds HOST_CC which might be useful in other cross-compiling
#   cases as well. Therefore, you can leave it in for maximum compatibility
#   and portability.
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

AC_DEFUN([PATCH_LIBTOOL_TO_ADD_HOST_CC],
[# patch libtool to add HOST_CC sometimes needed in crosscompiling a win32 dll
if grep "HOST_CC" libtool >/dev/null; then
  if test "$build" != "$host" ; then
    if test "_$HOST_CC" = "_" ; then
      HOST_CC="false"
      for i in `echo $PATH | sed 's,:, ,g'` ; do
      test -x $i/cc && HOST_CC=$i/cc
      done
    fi
AC_MSG_RESULT(patching libtool to add HOST_CC=$HOST_CC)
    test -f libtool.old || (mv libtool libtool.old && cp libtool.old libtool)
    sed -e "/BEGIN.*LIBTOOL.*CONFIG/a\\
HOST_CC=$HOST_CC" libtool >libtool.new
    (test -s libtool.new || rm libtool.new) 2>/dev/null
    test -f libtool.new && mv libtool.new libtool # not 2>/dev/null !!
    test -f libtool     || mv libtool.old libtool
  fi
fi
])
