# ===========================================================================
#     https://www.gnu.org/software/autoconf-archive/ax_check_typedef.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_TYPEDEF(TYPEDEF, HEADER [, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND ]])
#
# DESCRIPTION
#
#   Check if the given typedef-name is recognized as a type. The trick is to
#   use a sizeof(TYPEDEF) and see if the compiler is happy with that.
#
#   This can be thought of as a mixture of AC_CHECK_TYPE(TYPEDEF,DEFAULT)
#   and AC_CHECK_LIB(LIBRARY,FUNCTION,ACTION-IF-FOUND,ACTION-IF-NOT-FOUND).
#
#   A convenience macro AX_CHECK_TYPEDEF_ is provided that will not emit any
#   message to the user - it just executes one of the actions.
#
# BUGS
#
#   (1) The public AX_CHECK_TYPEDEF wrapper discards ACTION-IF-FOUND and
#   ACTION-IF-NOT-FOUND and supplies only its own result messages to the
#   implementation. Since the macro defines nothing else, it has no usable
#   effect. [Rating: broken]
#
#   (2) The cache check reads ac_cv_lib_TYPE_HEADER but the probe writes
#   ac_cv_type_TYPE_HEADER. Its result is not cached under the variable that
#   controls the check. [Rating: minor]
#
#   (3) Private shell variables such as ac_lib_var lack an ax_ prefix. They
#   share configure's shell namespace with callers and other macros, so they
#   may collide with variables of the same name. These variables should use
#   macro-specific ax_ names. [Rating: minor]
#
# LICENSE
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 9

AU_ALIAS([AC_CHECK_TYPEDEF], [AX_CHECK_TYPEDEF])
AC_DEFUN([AX_CHECK_TYPEDEF_],
[dnl
ac_lib_var=`echo $1['_']$2 | sed 'y%./+-%__p_%'`
AC_CACHE_VAL(ac_cv_lib_$ac_lib_var,
[ eval "ac_cv_type_$ac_lib_var='not-found'"
  ac_cv_check_typedef_header=`echo ifelse([$2], , stddef.h, $2)`
  AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <$ac_cv_check_typedef_header>]],
    [[int x = sizeof($1); x = x;]])],
    [eval "ac_cv_type_$ac_lib_var=yes"],
    [eval "ac_cv_type_$ac_lib_var=no"])
  if test `eval echo '$ac_cv_type_'$ac_lib_var` = "no" ; then
     ifelse([$4], , :, $4)
  else
     ifelse([$3], , :, $3)
  fi
])])

dnl AX_CHECK_TYPEDEF(TYPEDEF, HEADER [, ACTION-IF-FOUND,
dnl    [, ACTION-IF-NOT-FOUND ]])
AC_DEFUN([AX_CHECK_TYPEDEF],
[dnl
 AC_MSG_CHECKING([for $1 in $2])
 AX_CHECK_TYPEDEF_($1,$2,AC_MSG_RESULT(yes),AC_MSG_RESULT(no))dnl
])
