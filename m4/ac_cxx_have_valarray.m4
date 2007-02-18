##### http://autoconf-archive.cryp.to/ac_cxx_have_valarray.html
#
# SYNOPSIS
#
#   AC_CXX_HAVE_VALARRAY
#
# DESCRIPTION
#
#   If the compiler has valarray<T>, define HAVE_VALARRAY.
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

AC_DEFUN([AC_CXX_HAVE_VALARRAY],
[AC_CACHE_CHECK(whether the compiler has valarray<T>,
ac_cv_cxx_have_valarray,
[AC_REQUIRE([AC_CXX_NAMESPACES])
 AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE([#include <valarray>
#ifdef HAVE_NAMESPACES
using namespace std;
#endif],[valarray<float> x(100); return 0;],
 ac_cv_cxx_have_valarray=yes, ac_cv_cxx_have_valarray=no)
 AC_LANG_RESTORE
])
if test "$ac_cv_cxx_have_valarray" = yes; then
  AC_DEFINE(HAVE_VALARRAY,,[define if the compiler has valarray<T>])
fi
])
