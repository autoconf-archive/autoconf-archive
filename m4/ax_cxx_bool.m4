# ===========================================================================
#        http://www.gnu.org/software/autoconf-archive/ax_cxx_bool.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CXX_BOOL
#
# DESCRIPTION
#
#   If the compiler recognizes bool as a separate built-in type, define
#   HAVE_BOOL. Note that a typedef is not a separate type since you cannot
#   overload a function such that it accepts either the basic type or the
#   typedef.
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

AU_ALIAS([AC_CXX_BOOL], [AX_CXX_BOOL])
AC_DEFUN([AX_CXX_BOOL],
[AC_CACHE_CHECK(whether the compiler recognizes bool as a built-in type,
ax_cv_cxx_bool,
[AC_DIAGNOSE([obsolete],[Instead of using `AC_LANG', `AC_LANG_SAVE', and `AC_LANG_RESTORE',
you should use `AC_LANG_PUSH' and `AC_LANG_POP'.])dnl
AC_LANG_SAVE
 AC_LANG([C++])
 AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
int f(int  x){return 1;}
int f(char x){return 1;}
int f(bool x){return 1;}
]], [[bool b = true; return f(b);]])],[ax_cv_cxx_bool=yes],[ax_cv_cxx_bool=no])
 AC_LANG_POP([])
])
if test "$ax_cv_cxx_bool" = yes; then
  AC_DEFINE(HAVE_BOOL,,[define if bool is a built-in type])
fi
])
