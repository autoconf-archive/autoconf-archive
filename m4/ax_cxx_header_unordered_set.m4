# ================================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_cxx_header_unordered_set.html
# ================================================================================
#
# OBSOLETE MACRO
#
#   This macro requires the undefined macro AC_COMPILE_STDCXX_0X, so
#   autoconf fails whenever it is used. The header <unordered_set> is part
#   of C++11: use AX_CXX_COMPILE_STDCXX([11]) to require C++11, or
#   AC_CHECK_HEADERS to check for the header directly.
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
# BUGS
#
#   (1) The macro requires AC_COMPILE_STDCXX_0X, which is not defined by
#   Autoconf or this archive. Even with the archived C++ standard-check
#   macros loaded, standalone use fails unless the caller supplies this
#   missing macro. [Rating: broken]
#
#   (2) Private shell variables such as ac_save_CXXFLAGS lack an ax_ prefix.
#   They share configure's shell namespace with callers and other macros, so
#   they may collide with variables of the same name. These variables should
#   use macro-specific ax_ names. [Rating: minor]
#
# LICENSE
#
#   Copyright (c) 2008 Benjamin Kosnik <bkoz@redhat.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 10

AU_ALIAS([AC_CXX_HEADER_UNORDERED_SET], [AX_CXX_HEADER_UNORDERED_SET])
AC_DEFUN([AX_CXX_HEADER_UNORDERED_SET], [
  m4_warn([obsolete], [$0 is obsolete: it requires the undefined macro AC_COMPILE_STDCXX_0X; use AX_CXX_COMPILE_STDCXX([11]) instead])
  AC_CACHE_CHECK(for unordered_set,
  ax_cv_cxx_unordered_set,
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
    AC_DEFINE(HAVE_UNORDERED_SET,,[Define if unordered_set is present. ])
  fi
])
