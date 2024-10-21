# ============================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_check_awk_add_cr_eol.html
# ============================================================================
#
# SYNOPSIS
#
#   AX_CHECK_AWK_ADD_CR_EOL([ACTION-IF-SUCCESS],[ACTION-IF-FAILURE])
#
# DESCRIPTION
#
#   Check if AWK adds the CR of CRLF at the end of line.
#   If CR is added, execute ACTION-IF-SUCCESS otherwise
#   ACTION-IF-FAILURE. On most systems (both of Unix-like
#   and MSYS or Cygwin-like systems), CR is not added.
#   The native awk running on MS-DOS adds CR.
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
AC_DEFUN([AX_CHECK_AWK_ADD_CR_EOL], [
  AC_REQUIRE([AC_PROG_AWK])

  AC_MSG_CHECKING([whether ${AWK} adds CR at the end of line])
  ax_try_awk_add_cr_eol=`echo | "$AWK" '{print "a"}' | tr '\r\n' 'bc'`
  if test "${ax_try_awk_add_cr_eol}" = "abc"
  then
    AC_MSG_RESULT([yes])
    $1
  else
    if test "${ax_try_awk_add_cr_eol}" = "ac"
    then
      AC_MSG_RESULT([no])
    else
      AC_MSG_RESULT([no, $AWK may use strange ORS])
    fi
    $2
  fi []dnl
]) dnl AX_CHECK_AWK_ADD_CR_EOL
