# ===========================================================================
#    https://www.gnu.org/software/autoconf-archive/ax_cxx_static_cast.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CXX_STATIC_CAST
#
# DESCRIPTION
#
#   If the compiler supports static_cast<>, define HAVE_STATIC_CAST.
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

AU_ALIAS([AC_CXX_STATIC_CAST], [AX_CXX_STATIC_CAST])
AC_DEFUN([AX_CXX_STATIC_CAST],
[AC_CACHE_CHECK([whether the compiler supports static_cast<>],
[ax_cv_cxx_static_cast],
[AC_LANG_PUSH([C++])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <typeinfo>
class Base { public : Base () {} virtual void f () = 0; };
class Derived : public Base { public : Derived () {} virtual void f () {} };
int g (Derived&) { return 0; }]], [[
Derived d; Base& b = d; Derived& s = static_cast<Derived&> (b); return g (s);]])],
 [ax_cv_cxx_static_cast=yes], [ax_cv_cxx_static_cast=no])
 AC_LANG_POP([C++])
])
if test "$ax_cv_cxx_static_cast" = yes; then
  AC_DEFINE([HAVE_STATIC_CAST],[1],
            [Define to 1 if the compiler supports static_cast<>])
fi
])dnl
