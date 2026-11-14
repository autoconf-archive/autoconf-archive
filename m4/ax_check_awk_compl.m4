# ===========================================================================
#    https://www.gnu.org/software/autoconf-archive/ax_check_awk_compl.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   The actions are passed to AX_TRY_AWK_ANYOUT in the wrong positions, so
#   ACTION-IF-SUCCESS runs when awk lacks compl() and never when it has it,
#   and ACTION-IF-FAILURE is ignored.
#
# SYNOPSIS
#
#   AX_CHECK_AWK_COMPL([ACTION-IF-SUCCESS],[ACTION-IF-FAILURE])
#
# DESCRIPTION
#
#   Check if AWK supports compl() function. If successful execute
#   ACTION-IF-SUCCESS otherwise ACTION-IF-FAILURE.
#
#   This work is heavily based upon testawk.sh script by Heiner Steven. You
#   should find his script (and related works) at
#   <http://www.shelldorado.com/articles/awkcompat.html>. Thanks to
#   Alessandro Massignan for his suggestions and extensive nawk tests on
#   FreeBSD.
#
# BUGS
#
#   An extra empty argument is passed to AX_TRY_AWK_ANYOUT. The success
#   action is consequently empty, the failure action is the caller's success
#   action, and the caller's failure action is ignored. [Rating: broken]
#
# LICENSE
#
#   Copyright (c) 2009 Francesco Salvestrini <salvestrini@users.sourceforge.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 11

AC_DEFUN([AX_CHECK_AWK_COMPL], [
  m4_warn([obsolete], [$0 is obsolete: it runs ACTION-IF-SUCCESS when the test fails])
  AX_TRY_AWK_ANYOUT([compl()],
    [],[ print compl(10) ],[],
    [$1],[$2])
])
