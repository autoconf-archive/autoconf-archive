# ===========================================================================
#  http://www.gnu.org/software/autoconf-archive/ax_cxx_member_constants.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CXX_MEMBER_CONSTANTS
#
# DESCRIPTION
#
#   If the compiler supports member constants, define HAVE_MEMBER_CONSTANTS.
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

AU_ALIAS([AC_CXX_MEMBER_CONSTANTS], [AX_CXX_MEMBER_CONSTANTS])
AC_DEFUN([AX_CXX_MEMBER_CONSTANTS],
[AC_CACHE_CHECK(whether the compiler supports member constants,
ax_cv_cxx_member_constants,
[AC_DIAGNOSE([obsolete],[Instead of using `AC_LANG', `AC_LANG_SAVE', and `AC_LANG_RESTORE',
you should use `AC_LANG_PUSH' and `AC_LANG_POP'.])dnl
AC_LANG_SAVE
 AC_LANG([C++])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[class C {public: static const int i = 0;}; const int C::i;]], [[return C::i;]])],[ax_cv_cxx_member_constants=yes],[ax_cv_cxx_member_constants=no])
 AC_LANG_POP([])
])
if test "$ax_cv_cxx_member_constants" = yes; then
  AC_DEFINE(HAVE_MEMBER_CONSTANTS,,[define if the compiler supports member constants])
fi
])
