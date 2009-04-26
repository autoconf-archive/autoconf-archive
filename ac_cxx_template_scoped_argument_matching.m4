# ===============================================================================
#  http://autoconf-archive.cryp.to/ac_cxx_template_scoped_argument_matching.html
# ===============================================================================
#
# SYNOPSIS
#
#   AC_CXX_TEMPLATE_SCOPED_ARGUMENT_MATCHING
#
# DESCRIPTION
#
#   If the compiler supports function matching with argument types which are
#   template scope-qualified, define HAVE_TEMPLATE_SCOPED_ARGUMENT_MATCHING.
#
# LICENSE
#
#   Copyright (c) 2008 Todd Veldhuizen
#   Copyright (c) 2008 Luc Maisonobe <luc@spaceroots.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_CXX_TEMPLATE_SCOPED_ARGUMENT_MATCHING],
[AC_CACHE_CHECK(whether the compiler supports function matching with argument types which are template scope-qualified,
ac_cv_cxx_template_scoped_argument_matching,
[AC_REQUIRE([AC_CXX_TYPENAME])
 AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE([
#ifndef HAVE_TYPENAME
 #define typename
#endif
template<class X> class A { public : typedef X W; };
template<class Y> class B {};
template<class Y> void operator+(B<Y> d1, typename Y::W d2) {}
],[B<A<float> > z; z + 0.5f; return 0;],
 ac_cv_cxx_template_scoped_argument_matching=yes, ac_cv_cxx_template_scoped_argument_matching=no)
 AC_LANG_RESTORE
])
if test "$ac_cv_cxx_template_scoped_argument_matching" = yes; then
  AC_DEFINE(HAVE_TEMPLATE_SCOPED_ARGUMENT_MATCHING,,
            [define if the compiler supports function matching with argument types which are template scope-qualified])
fi
])
