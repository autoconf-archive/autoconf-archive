# ===========================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_check_posix_regcomp.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_POSIX_REGCOMP
#
# DESCRIPTION
#
#   Check that the POSIX compliant regular expression compiler is available
#   in the POSIX specified manner, and it works. If it fails, we have a
#   backup -- use gnu-regex.
#
# LICENSE
#
#   Copyright (c) 2008 Bruce Korb <bkorb@gnu.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 12

AN_FUNCTION([regcomp],[AX_CHECK_POSIX_REGCOMP])
AN_FUNCTION([regexec],[AX_CHECK_POSIX_REGCOMP])
AU_ALIAS([AG_CHECK_POSIX_REGCOMP], [AX_CHECK_POSIX_REGCOMP])
AC_DEFUN([AX_CHECK_POSIX_REGCOMP],[
  AC_MSG_CHECKING([whether we have a POSIX compliant regcomp()/regexec()])
  AC_CACHE_VAL([ax_cv_posix_regcomp],[
  AC_RUN_IFELSE([AC_LANG_SOURCE([[#include <sys/types.h>
#include <regex.h>
int main(void) {
  int flags = (REG_EXTENDED | REG_ICASE | REG_NEWLINE);
  regex_t  re;
  if (regcomp(&re, "^.*$", flags) != 0)
    return 1;
  return regcomp(&re, "|no.*", flags); }]])],[ax_cv_posix_regcomp=yes],[ax_cv_posix_regcomp=no],[ax_cv_posix_regcomp=no
  ]) # end of RUN_IFELSE]) # end of CACHE_VAL

  AC_MSG_RESULT([$ax_cv_posix_regcomp])
  if test x$ax_cv_posix_regcomp = xyes
  then
    AC_DEFINE([HAVE_POSIX_REGCOMP],[1],
       [Define this if POSIX compliant regcomp()/regexec()])
  fi
]) # end of AC_DEFUN of AX_CHECK_POSIX_REGCOMP
