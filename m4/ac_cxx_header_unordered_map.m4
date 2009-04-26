# ===========================================================================
#      http://autoconf-archive.cryp.to/ac_cxx_header_unordered_map.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_CXX_HEADER_UNORDERED_MAP
#
# DESCRIPTION
#
#   Check whether the C++ include <unordered_map> exists and define
#   HAVE_UNORDERED_MAP if it does.
#
# LICENSE
#
#   Copyright (c) 2008 Benjamin Kosnik <bkoz@redhat.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_CXX_HEADER_UNORDERED_MAP], [
  AC_CACHE_CHECK(for unordered_map,
  ac_cv_cxx_unordered_map,
  [AC_REQUIRE([AC_COMPILE_STDCXX_0X])
  AC_LANG_SAVE
  AC_LANG_CPLUSPLUS
  ac_save_CXXFLAGS="$CXXFLAGS"
  CXXFLAGS="$CXXFLAGS -std=gnu++0x"
  AC_TRY_COMPILE([#include <unordered_map>], [using std::unordered_map;],
  ac_cv_cxx_unordered_map=yes, ac_cv_cxx_unordered_map=no)
  CXXFLAGS="$ac_save_CXXFLAGS"
  AC_LANG_RESTORE
  ])
  if test "$ac_cv_cxx_unordered_map" = yes; then
    AC_DEFINE(HAVE_UNORDERED_MAP,,[Define if unordered_map is present. ])
  fi
])
