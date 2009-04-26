# ===========================================================================
#        http://autoconf-archive.cryp.to/ac_cxx_member_constants.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_CXX_MEMBER_CONSTANTS
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
#   and this notice are preserved.

AC_DEFUN([AC_CXX_MEMBER_CONSTANTS],
[AC_CACHE_CHECK(whether the compiler supports member constants,
ac_cv_cxx_member_constants,
[AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE([class C {public: static const int i = 0;}; const int C::i;],
[return C::i;],
 ac_cv_cxx_member_constants=yes, ac_cv_cxx_member_constants=no)
 AC_LANG_RESTORE
])
if test "$ac_cv_cxx_member_constants" = yes; then
  AC_DEFINE(HAVE_MEMBER_CONSTANTS,,[define if the compiler supports member constants])
fi
])
