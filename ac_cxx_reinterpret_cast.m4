# ===========================================================================
#        http://autoconf-archive.cryp.to/ac_cxx_reinterpret_cast.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_CXX_REINTERPRET_CAST
#
# DESCRIPTION
#
#   If the compiler supports reinterpret_cast<>, define
#   HAVE_REINTERPRET_CAST.
#
# LICENSE
#
#   Copyright (c) 2008 Todd Veldhuizen
#   Copyright (c) 2008 Luc Maisonobe <luc@spaceroots.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_CXX_REINTERPRET_CAST],
[AC_CACHE_CHECK(whether the compiler supports reinterpret_cast<>,
ac_cv_cxx_reinterpret_cast,
[AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE([#include <typeinfo>
class Base { public : Base () {} virtual void f () = 0;};
class Derived : public Base { public : Derived () {} virtual void f () {} };
class Unrelated { public : Unrelated () {} };
int g (Unrelated&) { return 0; }],[
Derived d;Base& b=d;Unrelated& e=reinterpret_cast<Unrelated&>(b);return g(e);],
 ac_cv_cxx_reinterpret_cast=yes, ac_cv_cxx_reinterpret_cast=no)
 AC_LANG_RESTORE
])
if test "$ac_cv_cxx_reinterpret_cast" = yes; then
  AC_DEFINE(HAVE_REINTERPRET_CAST,,
            [define if the compiler supports reinterpret_cast<>])
fi
])
