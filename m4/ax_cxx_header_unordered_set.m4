# ================================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_cxx_header_unordered_set.html
# ================================================================================
#
# SYNOPSIS
#
#   AX_CXX_HEADER_UNORDERED_SET
#
# DESCRIPTION
#
#   Check whether the C++ include <unordered_set> exists and define
#   HAVE_UNORDERED_SET if it does.
#
# LICENSE
#
#   Copyright (c) 2008 Benjamin Kosnik <bkoz@redhat.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 12

AU_ALIAS([AC_CXX_HEADER_UNORDERED_SET], [AX_CXX_HEADER_UNORDERED_SET])
AC_DEFUN([AX_CXX_HEADER_UNORDERED_SET], [
  AC_CACHE_CHECK([for unordered_set],
  [ax_cv_cxx_unordered_set],
  [AC_REQUIRE([AC_COMPILE_STDCXX_0X])
  AC_LANG_PUSH([C++])
  ac_save_CXXFLAGS="$CXXFLAGS"
  CXXFLAGS="$CXXFLAGS -std=gnu++0x"
  AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <unordered_set>]],
  [[using std::unordered_set;]])],
  [ax_cv_cxx_unordered_set=yes], [ax_cv_cxx_unordered_set=no])
  CXXFLAGS="$ac_save_CXXFLAGS"
  AC_LANG_POP([C++])
  ])
  if test "$ax_cv_cxx_unordered_set" = yes; then
    AC_DEFINE([HAVE_UNORDERED_SET],[1],
              [Define to 1 if unordered_set is present.])
  fi
])dnl
