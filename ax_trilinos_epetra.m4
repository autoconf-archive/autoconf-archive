# ===========================================================================
#           http://autoconf-archive.cryp.to/ax_trilinos_epetra.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_TRILINOS_EPETRA([, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   Test for the Trilinos Epetra
#   (http://trilinos.sandia.gov/packages/epetra) library. On success,
#   defines HAVE_LIBEPETRA due to AC_CHECK_LIB invocation.
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

AC_DEFUN([AX_TRILINOS_EPETRA],[
    AC_REQUIRE([AX_TRILINOS_BASE])
    ax_trilinos_epetra=yes
    AC_CHECK_HEADER([Epetra_Version.h],,[ax_trilinos_epetra=no])
    AC_CHECK_LIB(   [epetra],[main],   ,[ax_trilinos_epetra=no])
    if test "$ax_trilinos_epetra" = yes; then
        dnl NOP required
        :
		ifelse([$1], , , [$1])
    else
        dnl NOP required
        :
		ifelse([$2], , , [$2])
    fi
])
