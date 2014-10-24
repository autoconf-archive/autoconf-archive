# ============================================================================
#  http://www.gnu.org/software/autoconf-archive/ax_cxx_enum_computations.html
# ============================================================================
#
# SYNOPSIS
#
#   AX_CXX_ENUM_COMPUTATIONS
#
# DESCRIPTION
#
#   If the compiler handle computations inside an enum, define
#   HAVE_ENUM_COMPUTATIONS.
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

AU_ALIAS([AC_CXX_ENUM_COMPUTATIONS], [AX_CXX_ENUM_COMPUTATIONS])
AC_DEFUN([AX_CXX_ENUM_COMPUTATIONS],
[AC_CACHE_CHECK(whether the compiler handle computations inside an enum,
ax_cv_cxx_enum_computations,
[AC_DIAGNOSE([obsolete],[Instead of using `AC_LANG', `AC_LANG_SAVE', and `AC_LANG_RESTORE',
you should use `AC_LANG_PUSH' and `AC_LANG_POP'.])dnl
AC_LANG_SAVE
 AC_LANG([C++])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
struct A { enum { a = 5, b = 7, c = 2 }; };
struct B { enum { a = 1, b = 6, c = 9 }; };
template<class T1, class T2> struct Z
{ enum { a = (T1::a > T2::a) ? T1::a : T2::b,
         b = T1::b + T2::b,
         c = (T1::c * T2::c + T2::a + T1::a)
       };
};]], [[
return (((int)Z<A,B>::a == 5)
     && ((int)Z<A,B>::b == 13)
     && ((int)Z<A,B>::c == 24)) ? 0 : 1;]])],[ax_cv_cxx_enum_computations=yes],[ax_cv_cxx_enum_computations=no])
 AC_LANG_POP([])
])
if test "$ax_cv_cxx_enum_computations" = yes; then
  AC_DEFINE(HAVE_ENUM_COMPUTATIONS,,
            [define if the compiler handle computations inside an enum])
fi
])
