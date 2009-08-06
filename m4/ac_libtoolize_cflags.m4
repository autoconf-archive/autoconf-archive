# ===========================================================================
#      http://www.nongnu.org/autoconf-archive/ac_libtoolize_cflags.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Renamed to AX_LIBTOOLIZE_CFLAGS
#
# SYNOPSIS
#
#   AC_LIBTOOLIZE_CFLAGS(COMPILER-FLAGS-VAR)
#
# DESCRIPTION
#
#   Change the contents of variable COMPILER-FLAGS-VAR so that they are
#   Libtool friendly, ie. prefix each of them with `-Xcompiler' so that
#   Libtool doesn't remove them.
#
# LICENSE
#
#   Copyright (c) 2008 Ludovic Courtes <ludo@chbouib.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_LIBTOOLIZE_CFLAGS],
  [ac_libtoolize_ldflags_temp=""
   for i in $$1
   do
     ac_libtoolize_ldflags_temp="$ac_libtoolize_ldflags_temp -Xcompiler $i"
   done
   $1="$ac_libtoolize_ldflags_temp"])dnl
