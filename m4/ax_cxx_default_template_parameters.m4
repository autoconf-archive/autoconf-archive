# ======================================================================================
#  http://www.gnu.org/software/autoconf-archive/ax_cxx_default_template_parameters.html
# ======================================================================================
#
# SYNOPSIS
#
#   AX_CXX_DEFAULT_TEMPLATE_PARAMETERS
#
# DESCRIPTION
#
#   If the compiler supports default template parameters, define
#   HAVE_DEFAULT_TEMPLATE_PARAMETERS.
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

AU_ALIAS([AC_CXX_DEFAULT_TEMPLATE_PARAMETERS], [AX_CXX_DEFAULT_TEMPLATE_PARAMETERS])
AC_DEFUN([AX_CXX_DEFAULT_TEMPLATE_PARAMETERS],
[AC_CACHE_CHECK(whether the compiler supports default template parameters,
ax_cv_cxx_default_template_parameters,
[AC_DIAGNOSE([obsolete],[Instead of using `AC_LANG', `AC_LANG_SAVE', and `AC_LANG_RESTORE',
you should use `AC_LANG_PUSH' and `AC_LANG_POP'.])dnl
AC_LANG_SAVE
 AC_LANG([C++])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
template<class T = double, int N = 10> class A {public: int f() {return 0;}};
]], [[A<float> a; return a.f();]])],[ax_cv_cxx_default_template_parameters=yes],[ax_cv_cxx_default_template_parameters=no])
 AC_LANG_POP([])
])
if test "$ax_cv_cxx_default_template_parameters" = yes; then
  AC_DEFINE(HAVE_DEFAULT_TEMPLATE_PARAMETERS,,
            [define if the compiler supports default template parameters])
fi
])
