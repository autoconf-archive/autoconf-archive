##### http://autoconf-archive.cryp.to/ac_cxx_new_for_scoping.html
#
# SYNOPSIS
#
#   AC_CXX_NEW_FOR_SCOPING
#
# DESCRIPTION
#
#   If the compiler accepts the new for scoping rules (the scope of a
#   variable declared inside the parentheses is restricted to the
#   for-body), define HAVE_NEW_FOR_SCOPING.
#
# LAST MODIFICATION
#
#   2004-02-04
#
# COPYLEFT
#
#   Copyright (c) 2004 Todd Veldhuizen
#   Copyright (c) 2004 Luc Maisonobe <luc@spaceroots.org>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AC_CXX_NEW_FOR_SCOPING],
[AC_CACHE_CHECK(whether the compiler accepts the new for scoping rules,
ac_cv_cxx_new_for_scoping,
[AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE(,[
  int z = 0;
  for (int i = 0; i < 10; ++i)
    z = z + i;
  for (int i = 0; i < 10; ++i)
    z = z - i;
  return z;],
 ac_cv_cxx_new_for_scoping=yes, ac_cv_cxx_new_for_scoping=no)
 AC_LANG_RESTORE
])
if test "$ac_cv_cxx_new_for_scoping" = yes; then
  AC_DEFINE(HAVE_NEW_FOR_SCOPING,,[define if the compiler accepts the new for scoping rules])
fi
])
