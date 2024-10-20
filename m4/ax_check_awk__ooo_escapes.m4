# ============================================================================
# https://www.gnu.org/software/autoconf-archive/ax_check_awk__ooo_escapes.html
# ============================================================================
#
# SYNOPSIS
#
#   AX_CHECK_AWK__OOO_ESCAPES([ACTION-IF-SUCCESS],[ACTION-IF-FAILURE])
#
# DESCRIPTION
#
#   Check if AWK supports \ooo escape codes - backslash and 3 octal
#   digits, like "\101" to mean "A". If successful execute
#   ACTION-IF-SUCCESS otherwise ACTION-IF-FAILURE.
#
#   The octal escape in AWK was introduced since V7 addenda on 1980,
#   thus the awk on the original V7, V32 and their descendants forked
#   before V7 addenda (e.g. 2.9BSD, 3BSD) did not support it.
#
# LICENSE
#
#   Copyright (c) 2024 suzuki toshiya <mpsuzuki@hiroshima-u.acjp>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 1

dnl #########################################################################
AC_DEFUN([AX_CHECK_AWK__OOO_ESCAPES], [
  AC_MSG_CHECKING([${AWK} supports three octal escape])
  if test `echo | "${AWK}" '{if ("\101" == "A"){print "yes";}else{print "no";}}'` = "yes"
  then
    AC_MSG_RESULT([yes])
    $1
  else
    AC_MSG_RESULT([no])
    $2
  fi
]) dnl AX_CHECK_AWK__OOO_ESCAPES
