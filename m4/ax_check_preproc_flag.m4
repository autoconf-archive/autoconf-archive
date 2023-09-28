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
#   preprocessor or gives an error.  (Warnings, however, are ignored)
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

#serial 10

AC_DEFUN([AX_CHECK_PREPROC_FLAG],
[AC_PREREQ([2.64])dnl for _AC_LANG_PREFIX and AS_VAR_IF
AS_VAR_PUSHDEF([CACHEVAR],[ax_cv_check_[]_AC_LANG_ABBREV[]cppflags_$4_$1])dnl
AC_CACHE_CHECK([whether _AC_LANG preprocessor accepts $1], CACHEVAR, [
  ax_check_save_flags=$CPPFLAGS
  CPPFLAGS="$CPPFLAGS $4 $1"
  AC_PREPROC_IFELSE([m4_default([$5],[AC_LANG_PROGRAM()])],
    [AS_VAR_SET(CACHEVAR,[yes])],
    [AS_VAR_SET(CACHEVAR,[no])])
  CPPFLAGS=$ax_check_save_flags])
AS_VAR_IF(CACHEVAR,yes,
  [m4_default([$2], :)],
  [m4_default([$3], :)])
AS_VAR_POPDEF([CACHEVAR])dnl
])dnl AX_CHECK_PREPROC_FLAGS
