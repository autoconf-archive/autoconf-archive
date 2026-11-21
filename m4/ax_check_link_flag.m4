# ===========================================================================
#    https://www.gnu.org/software/autoconf-archive/ax_check_link_flag.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_LINK_FLAG(FLAG, [ACTION-SUCCESS], [ACTION-FAILURE], [EXTRA-FLAGS], [INPUT])
#
# DESCRIPTION
#
#   Check whether the given FLAG works with the linker or gives an error.
#   Most warnings are ignored.  But the check fails if a diagnostic names
#   FLAG in quotes, for example "unknown warning option '-Wfoo'", or as
#   "FLAG: ...", for example "-Wl,-z,now: 'linker' input unused".  Compilers
#   use these forms when they do not know a flag, or when a flag is not
#   valid for the language.  Some compilers, such as MSVC and clang-cl, only
#   give a warning for an unknown flag.
#
#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
#   success/failure.
#
#   If EXTRA-FLAGS is defined, it is added to the linker's default flags
#   when the check is done.  The check is thus made with the flags: "LDFLAGS
#   EXTRA-FLAGS FLAG".  This can for example be used to force the linker to
#   issue an error when a bad flag is given.
#
#   INPUT gives an alternative input source to AC_LINK_IFELSE.
#
#   NOTE: Implementation based on AX_CFLAGS_GCC_OPTION. Please keep this
#   macro in sync with AX_CHECK_{PREPROC,COMPILE}_FLAG.
#
# LICENSE
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#   Copyright (c) 2011 Maarten Bosmans <mkbosmans@gmail.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 11

AC_DEFUN([AX_CHECK_LINK_FLAG],
[AC_PREREQ(2.64)dnl for _AC_LANG_PREFIX and AS_VAR_IF
dnl AS_VAR_PUSHDEF changes all special characters to "_".  Encode "/" and
dnl ":" first, thus "-std=c11" and "/std:c11" use different cache variables.
dnl Keep the old name for C: ax_cv_check_ldflags_*.
AS_VAR_PUSHDEF([CACHEVAR],[ax_cv_check_[]m4_if(_AC_LANG_ABBREV, [c], [],
  [_AC_LANG_ABBREV])[]ldflags_[]m4_bpatsubsts([[$4_$1]],
  [/], [_2f_], [:], [_3a_])])dnl
AC_CACHE_CHECK([whether the _AC_LANG linker accepts $1], CACHEVAR, [
  ax_check_save_flags=$LDFLAGS
  LDFLAGS="$LDFLAGS $4 $1"
  AC_LINK_IFELSE([m4_default([$5],[AC_LANG_PROGRAM()])],
    [AS_VAR_SET(CACHEVAR,[yes])
     dnl Do not use -Werror: it also rejects a good flag when the flag
     dnl causes a warning about the test program (-Wunused-macros).
     dnl Look for the flag in quotes in the diagnostics instead.
     ax_check_err=`cat conftest.err 2>/dev/null`
     for ax_check_flag in $1; do
       case $ax_check_err in
         *"'$ax_check_flag'"* | *" $ax_check_flag: "*)
           AS_VAR_SET(CACHEVAR,[no]) ;;
       esac
     done],
    [AS_VAR_SET(CACHEVAR,[no])])
  LDFLAGS=$ax_check_save_flags])
AS_VAR_IF(CACHEVAR,yes,
  [m4_default([$2], :)],
  [m4_default([$3], :)])
AS_VAR_POPDEF([CACHEVAR])dnl
])dnl AX_CHECK_LINK_FLAGS
