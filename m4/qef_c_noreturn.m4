# ===========================================================================
#             http://autoconf-archive.cryp.to/qef_c_noreturn.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Test "__GNUC__+0 >= 2 && __GNUC_MINOR__+0 >= 5" instead.
#
# SYNOPSIS
#
#   QEF_C_NORETURN
#
# DESCRIPTION
#
#   Check if we can use GCC's __noreturn__ attribute in prototypes to
#   indicate that functions never return. This can be used by the compiler
#   to do some extra optimizations.
#
#   FUNCATTR_NORETURN is defined as what we should put at the end of
#   function prototypes to achieve this. If the compiler doesn't support it
#   then it is defined as empty.
#
#   An example of a a function's prototype and implementation using this
#   macro:
#
#     void this_function_never_returns (void) FUNCATTR_NORETURN;
#
#     void this_function_never_returns (void) {
#        exit (0);
#     }
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Geoff Richards <ctzgpr@scs.leeds.ac.uk>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([QEF_C_NORETURN],
[AC_REQUIRE([AC_PROG_CC])
AC_MSG_CHECKING(whether the C compiler (${CC-cc}) accepts noreturn attribute)
AC_CACHE_VAL(qef_cv_c_noreturn,
[qef_cv_c_noreturn=no
AC_TRY_COMPILE(
[#include <stdio.h>
void f (void) __attribute__ ((noreturn));
void f (void)
{
   exit (1);
}
], [
   f ();
],
[qef_cv_c_noreturn="yes";  FUNCATTR_NORETURN_VAL="__attribute__ ((noreturn))"],
[qef_cv_c_noreturn="no";   FUNCATTR_NORETURN_VAL="/* will not return */"])
])

AC_MSG_RESULT($qef_cv_c_noreturn)
AC_DEFINE_UNQUOTED(FUNCATTR_NORETURN, $FUNCATTR_NORETURN_VAL)
])dnl
