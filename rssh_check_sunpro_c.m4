# ===========================================================================
#          http://autoconf-archive.cryp.to/rssh_check_sunpro_c.html
# ===========================================================================
#
# SYNOPSIS
#
#   RSSH_CHECK_SUNPRO_C([ACTION-IF-YES],[ACTION-IF-NOT])
#
# DESCRIPTION
#
#   Check whether we are using SUN workshop C compiler. The corresponding
#   cache values is rssh_cv_check_sunpro_c, which is set to "yes" or "no"
#   respectively.
#
# LICENSE
#
#   Copyright (c) 2008 Ruslan Shevchenko <Ruslan@Shevchenko.Kiev.UA>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([RSSH_CHECK_SUNPRO_C],
[AC_CACHE_CHECK([whether using Sun Worckshop C compiler],
                [rssh_cv_check_sunpro_c],

[AC_LANG_SAVE
 AC_LANG_C
 AC_TRY_COMPILE([],
[#ifndef __SUNPRO_C
# include "error: this is not Sun Workshop."
#endif
],
               rssh_cv_check_sunpro_c=yes,
                rssh_cv_check_sunpro_c=no)
AC_LANG_RESTORE])
if test ${rssh_cv_check_sunpro_c} = yes
then
  $2
else
  $3
fi
])dnl
