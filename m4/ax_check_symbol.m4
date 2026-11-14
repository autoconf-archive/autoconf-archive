# ===========================================================================
#     https://www.gnu.org/software/autoconf-archive/ax_check_symbol.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   AX_CHECK_SYMBOLS calls an undefined macro and makes autoconf fail, and
#   AX_CHECK_SYMBOL does not even find declared symbols such as strlen in
#   <string.h>. Use Autoconf's AC_CHECK_DECLS instead.
#
# SYNOPSIS
#
#   AX_CHECK_SYMBOL(SYMBOL, HEADER... [,ACTION-IF-FOUND [,ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   A wrapper around AC_EGREP_HEADER. The shellvar $ac_found will hold the
#   HEADER-name that had been containing the symbol. This value is shown to
#   the user.
#
# BUGS
#
#   (1) AX_CHECK_SYMBOLS calls P4_CHECK_SYMBOL, which is not defined by this
#   archive, instead of AX_CHECK_SYMBOL. The plural entry point therefore
#   leaves an undefined macro in configure and cannot be used without an
#   external definition. [Rating: major]
#
#   (2) The cache check uses ac_cv_func_SYMBOL but never assigns it.
#   Pre-existing results from AC_CHECK_FUNC can skip the symbol check and
#   its caller actions, even though function linkage and header declarations
#   are different properties. [Rating: major]
#
#   (3) Private shell variables such as symbol lack an ax_ prefix. They
#   share configure's shell namespace with callers and other macros, so they
#   may collide with variables of the same name. These variables should use
#   macro-specific ax_ names. [Rating: minor]
#
#   (4) AX_CHECK_SYMBOLS calls P4_CHECK_SYMBOL, which is not defined
#   anywhere; the macro in this file is AX_CHECK_SYMBOL. Using
#   AX_CHECK_SYMBOLS makes autoconf fail with "undefined or overquoted
#   macro" errors. [Rating: broken]
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

AU_ALIAS([AC_CHECK_SYMBOL], [AX_CHECK_SYMBOL])
AC_DEFUN([AX_CHECK_SYMBOL],
[
  m4_warn([obsolete], [$0 is obsolete: it is unreliable; use AC_CHECK_DECLS instead])
AC_MSG_CHECKING([for $1 in $2])
AC_CACHE_VAL(ac_cv_func_$1,
[AC_REQUIRE_CPP()dnl
changequote(, )dnl
symbol="[^a-zA-Z_0-9]$1[^a-zA-Z_0-9]"
changequote([, ])dnl
ac_found=no
for ac_header in $2 ; do
  ac_safe=`echo "$ac_header" | sed 'y%./+-%__p_%' `
  if test $ac_found != "yes" ; then
      if eval "test \"`echo '$ac_cv_header_'$ac_safe`\" = yes"; then
            AC_EGREP_HEADER( $symbol, $ac_header, [ac_found="$ac_header"] )
      fi
  fi
done
if test "$ac_found" != "no" ; then
  AC_MSG_RESULT($ac_found)
  ifelse([$3], , :, [$3])
else
  AC_MSG_RESULT(no)
  ifelse([$4], , , [$4
])dnl
fi
])])

dnl AX_CHECK_SYMBOLS( symbol..., header... [, action-if-found [, action-if-not-found]])
AC_DEFUN([AX_CHECK_SYMBOLS],
[
  m4_warn([obsolete], [$0 is obsolete: it is unreliable; use AC_CHECK_DECLS instead])
for ac_func in $1
do
P4_CHECK_SYMBOL($ac_func, $2,
[changequote(, )dnl
  ac_tr_func=HAVE_`echo $ac_func | sed -e 'y:abcdefghijklmnopqrstuvwxyz:ABCDEFGHIJKLMNOPQRSTUVWXYZ:' -e 's:[[^A-Z0-9]]:_:'`
changequote([, ])dnl
  AC_DEFINE_UNQUOTED($ac_tr_func) $2], $3)dnl
done
])
