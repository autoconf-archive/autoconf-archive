# ===========================================================================
#          http://autoconf-archive.cryp.to/ax_trilinos_teuchos.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_TRILINOS_TEUCHOS([, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   Test for the Trilinos Teuchos
#   (http://trilinos.sandia.gov/packages/teuchos) library. On success,
#   defines HAVE_LIBTEUCHOS due to AC_CHECK_LIB invocation.
#
# LAST MODIFICATION
#
#   2008-08-06
#
# COPYLEFT
#
#   Copyright (c) 2008 Rhys Ulerich <rhys.ulerich@gmail.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AX_TRILINOS_TEUCHOS],[
    AC_REQUIRE([AX_TRILINOS_BASE])
    ax_trilinos_teuchos=yes
    AC_CHECK_HEADER([Teuchos_Version.hpp],,[ax_trilinos_teuchos=no])
    AC_CHECK_LIB(   [teuchos],[main],     ,[ax_trilinos_teuchos=no])
    if test "$ax_trilinos_teuchos" = yes; then
        dnl NOP required
        :
        ifelse([$1], , , [$1])
    else
        dnl NOP required
        :
        ifelse([$2], , , [$2])
    fi
])
