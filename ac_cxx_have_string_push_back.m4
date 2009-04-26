# ===========================================================================
#      http://autoconf-archive.cryp.to/ac_cxx_have_string_push_back.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_CXX_HAVE_STRING_PUSH_BACK
#
# DESCRIPTION
#
#   If the implementation of the C++ library provides the method
#   std::string::push_back (char), define HAVE_STRING_PUSH_BACK.
#
# LICENSE
#
#   Copyright (c) 2008 Jan Langer <jan@langernetz.de>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_CXX_HAVE_STRING_PUSH_BACK],
[AC_CACHE_CHECK(whether the compiler has std::string::push_back (char),
ac_cv_cxx_have_string_push_back,
[AC_REQUIRE([AC_CXX_NAMESPACES])
 AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE([#include <string>
#ifdef HAVE_NAMESPACES
using namespace std;
#endif],[string message; message.push_back ('a'); return 0;],
 ac_cv_cxx_have_string_push_back=yes, ac_cv_cxx_have_string_push_back=no)
 AC_LANG_RESTORE
])
if test "$ac_cv_cxx_have_string_push_back" = yes; then
 AC_DEFINE(HAVE_STRING_PUSH_BACK,,[define if the compiler has the method
std::string::push_back (char)])
fi
])dnl
