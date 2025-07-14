# ==========================================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_cxx_member_templates_outside_class.html
# ==========================================================================================
#
# SYNOPSIS
#
#   AX_CXX_MEMBER_TEMPLATES_OUTSIDE_CLASS
#
# DESCRIPTION
#
#   If the compiler supports member templates outside the class declaration,
#   define HAVE_MEMBER_TEMPLATES_OUTSIDE_CLASS.
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

AU_ALIAS([AC_CXX_MEMBER_TEMPLATES_OUTSIDE_CLASS], [AX_CXX_MEMBER_TEMPLATES_OUTSIDE_CLASS])
AC_DEFUN([AX_CXX_MEMBER_TEMPLATES_OUTSIDE_CLASS],
[AC_CACHE_CHECK(whether the compiler supports member templates outside the class declaration,
[ax_cv_cxx_member_templates_outside_class],
[AC_LANG_PUSH([C++])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
template<class T, int N> class A
{ public :
  template<int N2> A<T,N> operator=(const A<T,N2>& z);
};
template<class T, int N> template<int N2>
A<T,N> A<T,N>::operator=(const A<T,N2>& z){ return A<T,N>(); }]], [[
A<double,4> x; A<double,7> y; x = y; return 0;]])],
 [ax_cv_cxx_member_templates_outside_class=yes], [ax_cv_cxx_member_templates_outside_class=no])
 AC_LANG_POP([C++])
])
if test "$ax_cv_cxx_member_templates_outside_class" = yes; then
  AC_DEFINE([HAVE_MEMBER_TEMPLATES_OUTSIDE_CLASS],[1],
            [Define to 1 if the compiler supports member templates outside the class declaration])
fi
])dnl
