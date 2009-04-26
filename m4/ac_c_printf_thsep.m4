# ===========================================================================
#           http://autoconf-archive.cryp.to/ac_c_printf_thsep.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_C_PRINTF_THSEP
#
# DESCRIPTION
#
#   This macro checks whether the compiler supports the ' flag in printf,
#   which causes the non-fractional digits to be separated using a separator
#   and grouping determined by the locale. If true, HAVE_PRINTF_THSEP is
#   defined in config.h
#
# LICENSE
#
#   Copyright (c) 2008 Bill Poser <billposer@alum.mit.edu>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_C_PRINTF_THSEP],
[AC_TRY_COMPILE(,[printf("%'2d",101);],ac_cv_c_printf_thsep=yes,ac_cv_c_printf_thsep=no)
 if test $ac_cv_c_printf_thsep = yes; then
  AC_DEFINE(HAVE_PRINTF_THSEP, 1, [compiler understands printf flag for thousands separation in ints])
 fi
])
