# ===========================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_check_preproc_flag.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_PREPROC_FLAG(FLAG, [ACTION-SUCCESS], [ACTION-FAILURE], [EXTRA-FLAGS], [INPUT])
#
# DESCRIPTION
#
#   Check whether the given FLAG works with the current language's
#   preprocessor or gives an error.  Most warnings are ignored.  But the
#   check fails if a diagnostic names FLAG in quotes, for example "unknown
#   warning option '-Wfoo'", or as "FLAG: ...", for example "-Wl,-z,now:
#   'linker' input unused".  Compilers use these forms when they do not know
#   a flag, or when a flag is not valid for the language.  This is done
#   only with GNU compilers.
#
#   ACTION-SUCCESS/ACTION-FAILURE are shell commands to execute on
#   success/failure.
#
#   If EXTRA-FLAGS is defined, it is added to the preprocessor's default
#   flags when the check is done.  The check is thus made with the flags:
#   "CPPFLAGS EXTRA-FLAGS FLAG".  This can for example be used to force the
#   preprocessor to issue an error when a bad flag is given.
#
#   INPUT gives an alternative input source to AC_PREPROC_IFELSE.
#
#   NOTE: Implementation based on AX_CFLAGS_GCC_OPTION. Please keep this
#   macro in sync with AX_CHECK_{COMPILE,LINK}_FLAG.
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

#serial 7

AC_DEFUN([AX_CHECK_PREPROC_FLAG],
[AC_PREREQ(2.64)dnl for _AC_LANG_PREFIX and AS_VAR_IF
AS_VAR_PUSHDEF([CACHEVAR],[ax_cv_check_[]_AC_LANG_ABBREV[]cppflags_$4_$1])dnl
AC_CACHE_CHECK([whether the _AC_LANG preprocessor accepts $1], CACHEVAR, [
  ax_check_save_flags=$CPPFLAGS
  CPPFLAGS="$CPPFLAGS $4 $1"
  AC_PREPROC_IFELSE([m4_default([$5],[AC_LANG_PROGRAM()])],
    [AS_VAR_SET(CACHEVAR,[yes])
     dnl Do not use -Werror: it also rejects a good flag when the flag
     dnl causes a warning about the test program (-Wunused-macros).
     dnl Look for the flag in quotes in the diagnostics instead.
     AS_IF([test x"m4_case(_AC_LANG,
                            [C], [$GCC],
                            [C++], [$GXX],
                            [Fortran], [$GFC],
                            [Fortran 77], [$G77],
                            [Objective C], [$GOBJC],
                            [Objective C++], [$GOBJCXX],
                            [no])" = xyes],
       [ax_check_err=`cat conftest.err 2>/dev/null`],
       [ax_check_err=])
     for ax_check_flag in $1; do
       case $ax_check_err in
         *"'$ax_check_flag'"* | *" $ax_check_flag: "*)
           AS_VAR_SET(CACHEVAR,[no]) ;;
       esac
     done],
    [AS_VAR_SET(CACHEVAR,[no])])
  CPPFLAGS=$ax_check_save_flags])
AS_VAR_IF(CACHEVAR,yes,
  [m4_default([$2], :)],
  [m4_default([$3], :)])
AS_VAR_POPDEF([CACHEVAR])dnl
])dnl AX_CHECK_PREPROC_FLAGS
