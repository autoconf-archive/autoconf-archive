# ===========================================================================
#        http://autoconf-archive.cryp.to/ac_cxx_cppflags_std_lang.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_CXX_CPPFLAGS_STD_LANG(CPP-FLAGS)
#
# DESCRIPTION
#
#   Append to CPP-FLAGS the set of flags that should be passed to the C++
#   preprocessor in order to enable use of C++ features as defined in the
#   ANSI C++ standard (eg. use of standard iostream classes in the `std'
#   namespace, etc.).
#
# LICENSE
#
#   Copyright (c) 2008 Ludovic Courtès <ludo@chbouib.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_CXX_CPPFLAGS_STD_LANG],
  [AC_REQUIRE([AC_CXX_COMPILER_VENDOR])
   case "$ac_cv_cxx_compiler_vendor" in
     compaq)
      # By default, Compaq CXX has an iostream classes implementation
      # that is _not_ in the `std' namespace.
      $1="$$1 -D__USE_STD_IOSTREAM=1";;
     hp)
      # When `configure' looks for a C++ header (eg. <iostream>) it invokes
      # `aCC -E $CPPFLAGS'.  However, including standard C++ headers like
      # <iostream> fails if `-AA' is not supplied.
      $1="$$1 -AA";;
   esac])
