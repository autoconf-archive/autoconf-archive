# ===========================================================================
#    http://www.gnu.org/software/autoconf-archive/ax_cxx_dynamic_cast.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CXX_DYNAMIC_CAST
#
# DESCRIPTION
#
#   If the compiler supports dynamic_cast<>, define HAVE_DYNAMIC_CAST.
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

#serial 6

AU_ALIAS([AC_CXX_DYNAMIC_CAST], [AX_CXX_DYNAMIC_CAST])
AC_DEFUN([AX_CXX_DYNAMIC_CAST],
[AC_CACHE_CHECK(whether the compiler supports dynamic_cast<>,
ax_cv_cxx_dynamic_cast,
[AC_DIAGNOSE([obsolete],[Instead of using `AC_LANG', `AC_LANG_SAVE', and `AC_LANG_RESTORE',
you should use `AC_LANG_PUSH' and `AC_LANG_POP'.])dnl
AC_LANG_SAVE
 AC_LANG([C++])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <typeinfo>
class Base { public : Base () {} virtual void f () = 0;};
class Derived : public Base { public : Derived () {} virtual void f () {} };]], [[
Derived d; Base& b=d; return dynamic_cast<Derived*>(&b) ? 0 : 1;]])],[ax_cv_cxx_dynamic_cast=yes],[ax_cv_cxx_dynamic_cast=no])
 AC_LANG_POP([])
])
if test "$ax_cv_cxx_dynamic_cast" = yes; then
  AC_DEFINE(HAVE_DYNAMIC_CAST,,[define if the compiler supports dynamic_cast<>])
fi
])
