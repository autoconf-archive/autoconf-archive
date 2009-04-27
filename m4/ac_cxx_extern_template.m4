# ===========================================================================
#         http://autoconf-archive.cryp.to/ac_cxx_extern_template.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_CXX_EXTERN_TEMPLATE
#
# DESCRIPTION
#
#   Test whether the C++ compiler supports "extern template".
#
# LICENSE
#
#   Copyright (c) 2008 Patrick Mauritz <oxygene@studentenbude.ath.cx>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_CXX_EXTERN_TEMPLATE],[
AC_CACHE_CHECK(whether the compiler supports extern template,
ac_cv_cxx_extern_template,
[AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE([template <typename T> void foo(T); extern template void foo<int>(int);],
 [],
 ac_cv_cxx_extern_template=yes, ac_cv_cxx_extern_template=no)
 AC_LANG_RESTORE
])
if test "$ac_cv_cxx_extern_template" = yes; then
  AC_DEFINE(HAVE_EXTERN_TEMPLATE,,[define if the compiler supports extern template])
fi
])
