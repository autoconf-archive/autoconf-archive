# ============================================================================
# https://www.gnu.org/software/autoconf-archive/ax_check_awk_keep_cr_eol.html
# ============================================================================
#
# SYNOPSIS
#
#   AX_CHECK_AWK_KEEP_CR_EOL([ACTION-IF-SUCCESS],[ACTION-IF-FAILURE])
#
# DESCRIPTION
#
#   Check if AWK keeps the CR of CRLF at the end of line.
#   If CR is kept, execute ACTION-IF-SUCCESS otherwise
#   ACTION-IF-FAILURE. On most Unix-like systems, CR is
#   kept. The environment like MSYS, CR is removed. It
#   does not mean that RS is set to CRLF. In some cases,
#   RS is LF, but CR is removed.
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
AC_DEFUN([AX_CHECK_AWK_KEEP_CR_EOL], [
  AC_REQUIRE([AC_PROG_AWK])

  AC_MSG_CHECKING([whether ${AWK} keeps CR at the end of line])
  ax_try_awk_keep_cr_eol=`echo 'ab' | tr 'ab' '\015\012' | "$AWK" '{if(NR==1){print length(@S|@0)}else{next}}'`
  if test "${ax_try_awk_keep_cr_eol}" -eq 1
  then
    AC_MSG_RESULT([yes])
    $1
  else
    if test "${ax_try_awk_keep_cr_eol}" -eq 0
    then
      AC_MSG_RESULT([no])
    else
      AC_MSG_RESULT([no, $AWK may use strange RS])
    fi
    $2
  fi []dnl
]) dnl AX_CHECK_AWK_KEEP_CR_EOL
