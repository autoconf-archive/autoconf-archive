# ===========================================================================
#           http://autoconf-archive.cryp.to/vl_decl_wchar_max.html
# ===========================================================================
#
# SYNOPSIS
#
#   VL_DECL_WCHAR_MAX
#
# DESCRIPTION
#
#   Checks whether the system headers define WCHAR_MAX or not. If it is
#   already defined, does nothing. Otherwise checks the size and signedness
#   of `wchar_t', and defines WCHAR_MAX to the maximum value that can be
#   stored in a variable of type `wchar_t'.
#
# LICENSE
#
#   Copyright (c) 2008 Ville Laurikari <vl@iki.fi>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([VL_DECL_WCHAR_MAX], [
  AC_CACHE_CHECK([whether WCHAR_MAX is defined], vl_cv_decl_wchar_max, [
    AC_TRY_COMPILE([
#ifdef HAVE_WCHAR_H
#include <wchar.h>
#endif
],[WCHAR_MAX],[vl_cv_decl_wchar_max="yes"],[vl_cv_decl_wchar_max="no"])])
  if test $vl_cv_decl_wchar_max = "no"; then
    VL_CHECK_SIGN([wchar_t],
      [ wc_signed="yes"
        AC_DEFINE(WCHAR_T_SIGNED, 1, [Define if wchar_t is signed]) ],
      [ wc_signed="no"
        AC_DEFINE(WCHAR_T_UNSIGNED, 1, [Define if wchar_t is unsigned])], [
#ifdef HAVE_WCHAR_H
#include <wchar.h>
#endif
])
    if test "$wc_signed" = "yes"; then
      AC_DEFINE(WCHAR_MAX, [(1L << (sizeof(wchar_t) * 8 - 1) - 1)], [
Define to the maximum value of wchar_t if not already defined elsewhere])
    elif test "$wc_signed" = "no"; then
      AC_DEFINE(WCHAR_MAX, [(1L << (sizeof(wchar_t) * 8) - 1)])
    fi
  fi
])dnl
