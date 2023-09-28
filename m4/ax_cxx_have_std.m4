# ===========================================================================
#     https://www.gnu.org/software/autoconf-archive/ax_cxx_have_std.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CXX_HAVE_STD
#
# DESCRIPTION
#
#   If the compiler supports ISO C++ standard library (i.e., can include the
#   files iostream, map, iomanip and cmath), define HAVE_STD.
#
# LICENSE
#
#   Copyright (c) 2008 Todd Veldhuizen
#   Copyright (c) 2008 Luc Maisonobe <luc@spaceroots.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 12

AU_ALIAS([AC_CXX_HAVE_STD], [AX_CXX_HAVE_STD])
AC_DEFUN([AX_CXX_HAVE_STD],
[AC_CACHE_CHECK([whether the compiler supports ISO C++ standard library],
[ax_cv_cxx_have_std],
[AC_REQUIRE([AX_CXX_NAMESPACES])
 AC_LANG_PUSH([C++])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <iostream>
#include <map>
#include <iomanip>
#include <cmath>
#ifdef HAVE_NAMESPACES
using namespace std;
#endif]], [[return 0;]])],[ax_cv_cxx_have_std=yes],[ax_cv_cxx_have_std=no])
 AC_LANG_POP([C++])
])
if test "$ax_cv_cxx_have_std" = yes; then
  AC_DEFINE([HAVE_STD],[1],
            [Define to 1 if compiler supports ISO C++ standard library])
fi
])dnl
