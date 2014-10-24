# ===========================================================================
#      http://www.gnu.org/software/autoconf-archive/ax_cxx_mutable.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CXX_MUTABLE
#
# DESCRIPTION
#
#   If the compiler allows modifying class data members flagged with the
#   mutable keyword even in const objects (for example in the body of a
#   const member function), define HAVE_MUTABLE.
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

AU_ALIAS([AC_CXX_MUTABLE], [AX_CXX_MUTABLE])
AC_DEFUN([AX_CXX_MUTABLE],
[AC_CACHE_CHECK(whether the compiler supports the mutable keyword,
ax_cv_cxx_mutable,
[AC_DIAGNOSE([obsolete],[Instead of using `AC_LANG', `AC_LANG_SAVE', and `AC_LANG_RESTORE',
you should use `AC_LANG_PUSH' and `AC_LANG_POP'.])dnl
AC_LANG_SAVE
 AC_LANG([C++])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
class A { mutable int i;
          public:
          int f (int n) const { i = n; return i; }
        };
]], [[A a; return a.f (1);]])],[ax_cv_cxx_mutable=yes],[ax_cv_cxx_mutable=no])
 AC_LANG_POP([])
])
if test "$ax_cv_cxx_mutable" = yes; then
  AC_DEFINE(HAVE_MUTABLE,,[define if the compiler supports the mutable keyword])
fi
])
