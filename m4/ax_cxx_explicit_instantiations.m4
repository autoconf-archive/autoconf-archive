# ==================================================================================
#  http://www.gnu.org/software/autoconf-archive/ax_cxx_explicit_instantiations.html
# ==================================================================================
#
# SYNOPSIS
#
#   AX_CXX_EXPLICIT_INSTANTIATIONS
#
# DESCRIPTION
#
#   If the C++ compiler supports explicit instanciations syntax, define
#   HAVE_INSTANTIATIONS.
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

#serial 8

AU_ALIAS([AC_CXX_EXPLICIT_INSTANTIATIONS], [AX_CXX_EXPLICIT_INSTANTIATIONS])
AC_DEFUN([AX_CXX_EXPLICIT_INSTANTIATIONS],
[AC_CACHE_CHECK(whether the compiler supports explicit instantiations,
ax_cv_cxx_explinst,
[AC_LANG_PUSH([C++])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[template <class T> class A { T t; }; template class A<int>;]], [[]])],[ax_cv_cxx_explinst=yes],[ax_cv_cxx_explinst=no])
 AC_LANG_POP([])
])
if test "$ax_cv_cxx_explinst" = yes; then
  AC_DEFINE([HAVE_INSTANTIATIONS],[1],
            [Define to 1 if the compiler supports explicit instantiations])
fi
])dnl
