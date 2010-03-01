# ===========================================================================
#     http://www.gnu.org/software/autoconf-archive/ax_cxx_templates.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CXX_TEMPLATES
#
# DESCRIPTION
#
#   If the compiler supports basic templates, define HAVE_TEMPLATES.
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

AU_ALIAS([AC_CXX_TEMPLATES], [AX_CXX_TEMPLATES])
AC_DEFUN([AX_CXX_TEMPLATES],
[AC_CACHE_CHECK(whether the compiler supports basic templates,
ax_cv_cxx_templates,
[AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE([template<class T> class A {public:A(){}};
template<class T> void f(const A<T>& ){}],[
A<double> d; A<int> i; f(d); f(i); return 0;],
 ax_cv_cxx_templates=yes, ax_cv_cxx_templates=no)
 AC_LANG_RESTORE
])
if test "$ax_cv_cxx_templates" = yes; then
  AC_DEFINE(HAVE_TEMPLATES,,[define if the compiler supports basic templates])
fi
])
