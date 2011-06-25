# ===========================================================================
#   http://www.gnu.org/software/autoconf-archive/ax_cflags_gcc_option.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Deprecated in favor of AX_CHECK_COMPILE_FLAG.
#
# SYNOPSIS
#
#   AX_CFLAGS_GCC_OPTION (optionflag [,[shellvar][,[A][,[NA]]])
#
# DESCRIPTION
#
#   AX_CFLAGS_GCC_OPTION(-fomit-frame-pointer) would show a message like
#   "checking CFLAGS for gcc -fomit-frame-pointer ... yes" and add the
#   optionflag to CFLAGS if it is understood. You can override the
#   shellvar-default of CFLAGS of course. The order of arguments stems from
#   the explicit macros like AX_CFLAGS_WARN_ALL.
#
#   The cousin AX_CXXFLAGS_GCC_OPTION would check for an option to add to
#   CXXFLAGS - and it uses the autoconf setup for C++ instead of C (since it
#   is possible to use different compilers for C and C++).
#
#   The macro is a lot simpler than any special AX_CFLAGS_* macro (or
#   ax_cxx_rtti.m4 macro) but allows to check for arbitrary options.
#   However, if you use this macro in a few places, it would be great if you
#   would make up a new function-macro and submit it to the ac-archive.
#
#     - $1 option-to-check-for : required ("-option" as non-value)
#     - $2 shell-variable-to-add-to : CFLAGS (or CXXFLAGS in the other case)
#     - $3 action-if-found : add value to shellvariable
#     - $4 action-if-not-found : nothing
#
#   Note: in earlier versions, $1-$2 were swapped. We try to detect the
#   situation and accept a $2=~/-/ as being the old option-to-check-for.
#
#   There are other variants that emerged from the original macro variant
#   which did just test an option to be possibly added. However, some
#   compilers accept an option silently, or possibly for just another option
#   that was not intended. Therefore, we have to do a generic test for a
#   compiler family. For gcc we check "-pedantic" being accepted which is
#   also understood by compilers who just want to be compatible with gcc
#   even when not being made from gcc sources.
#
#   See also: AX_CFLAGS_SUN_OPTION, AX_CFLAGS_HPUX_OPTION,
#   AX_CFLAGS_AIX_OPTION, and AX_CFLAGS_IRIX_OPTION.
#
# LICENSE
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 3 of the License, or (at your
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

#serial 19

AC_DEFUN([AX_FLAGS_GCC_OPTION_PRIVATE], [dnl
AX_CHECK_COMPILE_FLAG([$1], [flag_ok="yes"], [flag_ok="no"], [-pedantic -Werror])
AS_IF([test "x$flag_ok" == "xno"],
  [AX_CHECK_COMPILE_FLAG([$1], [flag_ok="no, obsolete"], [flag_ok="no"], [-pedantic])])
AS_CASE([".$flag_ok"],
  [.ok|.ok,*], [$3],
  [.|.no|.no,*], [$4],
  [m4_default($3,[AX_APPEND_FLAG([$1],[$2])])])
])

AC_DEFUN([AX_CFLAGS_GCC_OPTION],[
  AC_LANG_PUSH([C])
  AX_FLAGS_GCC_OPTION_PRIVATE(ifelse(m4_bregexp([$2],[-]),-1,[[$1],[$2]],[[$2],[$1]]),[$3],[$4])
  AC_LANG_POP
])

AC_DEFUN([AX_CXXFLAGS_GCC_OPTION],[
  AC_LANG_PUSH([C++])
  AX_FLAGS_GCC_OPTION_PRIVATE(ifelse(m4_bregexp([$2],[-]),-1,[[$1],[$2]],[[$2],[$1]]),[$3],[$4])
  AC_LANG_POP
])
