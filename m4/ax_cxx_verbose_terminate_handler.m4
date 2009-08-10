# ==============================================================================
#  http://www.nongnu.org/autoconf-archive/ax_cxx_verbose_terminate_handler.html
# ==============================================================================
#
# SYNOPSIS
#
#   AX_CXX_VERBOSE_TERMINATE_HANDLER
#
# DESCRIPTION
#
#   If the compiler does have the verbose terminate handler, define
#   HAVE_VERBOSE_TERMINATE_HANDLER.
#
# LICENSE
#
#   Copyright (c) 2008 Lapo Luchini <lapo@lapo.it>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AX_CXX_VERBOSE_TERMINATE_HANDLER],
[AC_CACHE_CHECK(whether the compiler has __gnu_cxx::__verbose_terminate_handler,
ax_cv_verbose_terminate_handler,
[
  AC_REQUIRE([AX_CXX_EXCEPTIONS])
  AC_REQUIRE([AX_CXX_NAMESPACES])
  AC_LANG_SAVE
  AC_LANG_CPLUSPLUS
  AC_TRY_COMPILE(
    [#include <exception>], [std::set_terminate(__gnu_cxx::__verbose_terminate_handler);],
    ax_cv_verbose_terminate_handler=yes, ax_cv_verbose_terminate_handler=no
  )
  AC_LANG_RESTORE
])
if test "$ax_cv_verbose_terminate_handler" = yes; then
  AC_DEFINE(HAVE_VERBOSE_TERMINATE_HANDLER, , [define if the compiler has __gnu_cxx::__verbose_terminate_handler])
fi
])
