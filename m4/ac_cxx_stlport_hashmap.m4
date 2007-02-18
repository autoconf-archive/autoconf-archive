##### http://autoconf-archive.cryp.to/ac_cxx_stlport_hashmap.html
#
# SYNOPSIS
#
#   AC_CXX_STLPORT_HASHMAP
#
# DESCRIPTION
#
#   Test for the presence of STLport's hashmap extension.
#
# LAST MODIFICATION
#
#   2005-07-18
#
# COPYLEFT
#
#   Copyright (c) 2005 Patrick Mauritz <oxygene@studentenbude.ath.cx>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AC_CXX_STLPORT_HASHMAP],[
AC_CACHE_CHECK(whether the compiler supports std::hash_map,
ac_cv_cxx_stlport_hashmap,
[AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 AC_TRY_COMPILE([#include <hash_map>
using std::hash_map;],
 [],
 ac_cv_cxx_stlport_hashmap=yes, ac_cv_cxx_stlport_hashmap=no)
 AC_LANG_RESTORE
])
if test "$ac_cv_cxx_stlport_hashmap" = yes; then
  AC_DEFINE(HAVE_STLPORT_HASHMAP,,[define if the compiler supports std::hash_map])
fi
])
