# ===========================================================================
#    https://www.gnu.org/software/autoconf-archive/ax_decl_wchar_max.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_DECL_WCHAR_MAX
#
# DESCRIPTION
#
#   Checks whether the system headers define WCHAR_MAX or not. If it is
#   already defined, does nothing. Otherwise checks the size and signedness
#   of `wchar_t', and defines WCHAR_MAX to the maximum value that can be
#   stored in a variable of type `wchar_t'.
#
# BUGS
#
#   (1) The fallback WCHAR_MAX expressions put the final subtraction inside
#   the shift count. For a signed 32-bit wchar_t the result is 1L << 30, not
#   (1L << 31) - 1; the unsigned formula is similarly incorrect. [Rating:
#   major]
#
#   (2) Private shell variables such as wc_signed lack an ax_ prefix. They
#   share configure's shell namespace with callers and other macros, so they
#   may collide with variables of the same name. These variables should use
#   macro-specific ax_ names. [Rating: minor]
#
#   (3) The probe includes <wchar.h> only if HAVE_WCHAR_H is defined. Unless
#   the caller has run AC_CHECK_HEADERS([wchar.h]) first, even glibc systems
#   take the fallback path, which defines WCHAR_T_UNSIGNED and an incorrect
#   WCHAR_MAX. [Rating: major]
#
# LICENSE
#
#   Copyright (c) 2008 Ville Laurikari <vl@iki.fi>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 10

AU_ALIAS([VL_DECL_WCHAR_MAX], [AX_DECL_WCHAR_MAX])
AC_DEFUN([AX_DECL_WCHAR_MAX], [
  m4_warn([portability],
    [$0: Fallback WCHAR_MAX values are incorrect; check for wchar.h first
     to avoid unnecessary fallback.])
  AC_CACHE_CHECK([whether WCHAR_MAX is defined], ax_cv_decl_wchar_max, [
    AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
#ifdef HAVE_WCHAR_H
#include <wchar.h>
#endif
]], [[WCHAR_MAX]])], [ax_cv_decl_wchar_max="yes"], [ax_cv_decl_wchar_max="no"])])
  if test $ax_cv_decl_wchar_max = "no"; then
    AX_CHECK_SIGN([wchar_t],
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
