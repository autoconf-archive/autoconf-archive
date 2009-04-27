# ===========================================================================
#     http://autoconf-archive.cryp.to/ac_cxx_explicit_instantiations.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_CXX_EXPLICIT_INSTANTIATIONS
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
#   and this notice are preserved.

AC_DEFUN([AC_CXX_EXPLICIT_INSTANTIATIONS],
[AC_CACHE_CHECK(whether the compiler supports explicit instantiations,
ac_cv_cxx_explinst,
[AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE([template <class T> class A { T t; }; template class A<int>;],
 [], ac_cv_cxx_explinst=yes, ac_cv_cxx_explinst=no)
 AC_LANG_RESTORE
])
if test "$ac_cv_cxx_explinst" = yes; then
  AC_DEFINE(HAVE_INSTANTIATIONS,,
            [define if the compiler supports explicit instantiations])
fi
])
