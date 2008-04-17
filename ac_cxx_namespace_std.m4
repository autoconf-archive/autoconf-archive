# ===========================================================================
#          http://autoconf-archive.cryp.to/ac_cxx_namespace_std.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_CXX_NAMESPACE_STD
#
# DESCRIPTION
#
#   If the compiler supports namespace std, define HAVE_NAMESPACE_STD.
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Todd Veldhuizen
#   Copyright (c) 2008 Luc Maisonobe <luc@spaceroots.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_CXX_NAMESPACE_STD], [
  AC_CACHE_CHECK(if g++ supports namespace std,
  ac_cv_cxx_have_std_namespace,
  [AC_LANG_SAVE
  AC_LANG_CPLUSPLUS
  AC_TRY_COMPILE([#include <iostream>
                  std::istream& is = std::cin;],,
  ac_cv_cxx_have_std_namespace=yes, ac_cv_cxx_have_std_namespace=no)
  AC_LANG_RESTORE
  ])
  if test "$ac_cv_cxx_have_std_namespace" = yes; then
    AC_DEFINE(HAVE_NAMESPACE_STD,,[Define if g++ supports namespace std. ])
  fi
])
