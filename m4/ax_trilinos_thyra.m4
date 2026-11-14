# ===========================================================================
#    https://www.gnu.org/software/autoconf-archive/ax_trilinos_thyra.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   This macro is unusable: it depends on AX_TRILINOS_BASE, which calls the
#   undefined helper macro AX_TRILINOS_ABSOLUTE_HEADER, so the generated
#   configure script fails with a syntax error.
#
# SYNOPSIS
#
#   AX_TRILINOS_THYRA([, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   On success, adds "include Makefile.export.thyra" statements to every
#   Automake file containing @INC_AMINCLUDE@. Requires that Trilinos was
#   configured with the --enable-export-makefiles option. When
#   ACTION-IF-NOT-FOUND is not specified, the default behavior is for
#   configure to fail.
#
# BUGS
#
#   This macro depends on AX_TRILINOS_BASE, whose required
#   AX_TRILINOS_ABSOLUTE_HEADER helper is missing from the archive. Without
#   an external definition of that helper, the dependency prevents
#   generation of a usable configure script. [Rating: broken]
#
# LICENSE
#
#   Copyright (c) 2009 Rhys Ulerich <rhys.ulerich@gmail.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 10

AC_DEFUN([AX_TRILINOS_THYRA],[
  m4_warn([obsolete], [$0 is obsolete: it depends on AX_TRILINOS_BASE, which produces a broken configure script])
    AC_REQUIRE([AX_TRILINOS_BASE])
    ax_trilinos_thyra=yes
    AC_HAVE_LIBRARY([thyra],[:],[ax_trilinos_thyra=no])
    AX_ADD_AM_TRILINOS_MAKEFILE_EXPORT([thyra.macros],[ax_trilinos_thyra=no])
    AX_ADD_AM_TRILINOS_MAKEFILE_EXPORT([thyra],[ax_trilinos_thyra=no])
    if test "$ax_trilinos_thyra" = yes; then
        : # NOP
		ifelse([$1],,,
            [$1])
    else
        : # NOP
		ifelse([$2],,AC_MSG_ERROR([Trilinos Thyra not usable.]),
            [$2])
    fi
])
