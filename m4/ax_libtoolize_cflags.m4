# ===========================================================================
#   https://www.gnu.org/software/autoconf-archive/ax_libtoolize_cflags.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_LIBTOOLIZE_CFLAGS(COMPILER-FLAGS-VAR)
#
# DESCRIPTION
#
#   Change the contents of variable COMPILER-FLAGS-VAR so that they are
#   Libtool friendly, ie. prefix each of them with `-Xcompiler' so that
#   Libtool doesn't remove them.
#
# BUGS
#
#   Private shell variables such as i lack an ax_ prefix. They share
#   configure's shell namespace with callers and other macros, so they may
#   collide with variables of the same name. These variables should use
#   macro-specific ax_ names. [Rating: minor]
#
# LICENSE
#
#   Copyright (c) 2008 Ludovic Courtes <ludo@chbouib.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 7

AU_ALIAS([AC_LIBTOOLIZE_CFLAGS], [AX_LIBTOOLIZE_CFLAGS])
AC_DEFUN([AX_LIBTOOLIZE_CFLAGS],
  [ac_libtoolize_ldflags_temp=""
   for i in $$1
   do
     ac_libtoolize_ldflags_temp="$ac_libtoolize_ldflags_temp -Xcompiler $i"
   done
   $1="$ac_libtoolize_ldflags_temp"])dnl
