# =============================================================================================
#  http://www.nongnu.org/autoconf-archive/ac_cxx_explicit_template_function_qualification.html
# =============================================================================================
#
# OBSOLETE MACRO
#
#   Renamed to AX_CXX_EXPLICIT_TEMPLATE_FUNCTION_QUALIFICATION
#
# SYNOPSIS
#
#   AC_CXX_EXPLICIT_TEMPLATE_FUNCTION_QUALIFICATION
#
# DESCRIPTION
#
#   If the compiler supports explicit template function qualification,
#   define HAVE_EXPLICIT_TEMPLATE_FUNCTION_QUALIFICATION.
#
# LICENSE
#
#   Copyright (c) 2008 Todd Veldhuizen
#   Copyright (c) 2008 Luc Maisonobe <luc@spaceroots.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AU_ALIAS([AC_CXX_EXPLICIT_TEMPLATE_FUNCTION_QUALIFICATION], [AX_CXX_EXPLICIT_TEMPLATE_FUNCTION_QUALIFICATION])
AC_DEFUN([AC_CXX_EXPLICIT_TEMPLATE_FUNCTION_QUALIFICATION],
[AC_CACHE_CHECK(whether the compiler supports explicit template function qualification,
ac_cv_cxx_explicit_template_function_qualification,
[AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE([
template<class Z> class A { public : A() {} };
template<class X, class Y> A<X> to (const A<Y>&) { return A<X>(); }
],[A<float> x; A<double> y = to<double>(x); return 0;],
 ac_cv_cxx_explicit_template_function_qualification=yes, ac_cv_cxx_explicit_template_function_qualification=no)
 AC_LANG_RESTORE
])
if test "$ac_cv_cxx_explicit_template_function_qualification" = yes; then
  AC_DEFINE(HAVE_EXPLICIT_TEMPLATE_FUNCTION_QUALIFICATION,,
            [define if the compiler supports explicit template function qualification])
fi
])
