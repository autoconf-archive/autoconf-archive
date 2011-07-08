# ===========================================================================
#  http://www.gnu.org/software/autoconf-archive/ax_check_compiler_flags.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Deprecated in favor of AX_CHECK_COMPILE_FLAG.
#
# SYNOPSIS
#
#   AX_CHECK_COMPILER_FLAGS(FLAGS, [ACTION-SUCCESS], [ACTION-FAILURE])
#
# DESCRIPTION
#
#   Check whether the given compiler FLAGS work with the current language's
#   compiler, or whether they give an error. (Warnings, however, are
#   ignored.)
#
#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
#   success/failure.
#
#   This macro is obsolete, use AX_CHECK_COMPILE_FLAG.  The only difference
#   is that AX_CHECK_COMPILE_FLAG checks for a FLAG in addition to the
#   standard CFLAGS, while this macro uses FLAGS instead of CFLAGS.  Run
#   autoupdate with this new macro definition to change configure.ac to
#   using AX_CHECK_COMPILE_FLAG directly.
#
# LICENSE
#
#   Copyright (c) 2009 Steven G. Johnson <stevenj@alum.mit.edu>
#   Copyright (c) 2009 Matteo Frigo
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
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
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 13

AU_DEFUN([AX_CHECK_COMPILER_FLAGS],
[AC_PREREQ(2.59) dnl for _AC_LANG_PREFIX
# AX_CHECK_COMPILER_FLAGS start
ax_save_FLAGS=$[]_AC_LANG_PREFIX[]FLAGS
_AC_LANG_PREFIX[]FLAGS=
AX_CHECK_COMPILE_FLAG([$1], [ax_check_compiler_flags=yes], [ax_check_compiler_flags=no])
_AC_LANG_PREFIX[]FLAGS=$ax_save_FLAGS
AS_IF([test "x$ax_check_compiler_flags" == "xyes"],
  [m4_default([$2], :)],
  [m4_default([$3], :)])
# AX_CHECK_COMPILER_FLAGS end
],[You might want to replace AX_CHECK_COMPILER_FLAGS from start to end with AX_CHECK_COMPILE_FLAG([$1], [$2], [$3])])dnl AX_CHECK_COMPILER_FLAGS
