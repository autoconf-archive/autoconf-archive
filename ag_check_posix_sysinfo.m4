# ===========================================================================
#         http://autoconf-archive.cryp.to/ag_check_posix_sysinfo.html
# ===========================================================================
#
# SYNOPSIS
#
#   AG_CHECK_POSIX_SYSINFO
#
# DESCRIPTION
#
#   Check that the POSIX compliant sysinfo(2) call works properly. Linux has
#   its own weirdo alternative.
#
# LICENSE
#
#   Copyright (c) 2008 Bruce Korb <bkorb@gnu.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AG_CHECK_POSIX_SYSINFO],[
  AC_MSG_CHECKING([whether sysinfo(2) is POSIX])
  AC_CACHE_VAL([ag_cv_posix_sysinfo],[
  AC_TRY_RUN([#include <sys/systeminfo.h>
int main() { char z[ 256 ];
long sz = sysinfo( SI_SYSNAME, z, sizeof( z ));
return (sz > 0) ? 0 : 1; }],[ag_cv_posix_sysinfo=yes],[ag_cv_posix_sysinfo=no],[ag_cv_posix_sysinfo=no]
  ) # end of TRY_RUN]) # end of CACHE_VAL

  AC_MSG_RESULT([$ag_cv_posix_sysinfo])
  if test x$ag_cv_posix_sysinfo = xyes
  then
    AC_DEFINE(HAVE_POSIX_SYSINFO, 1,
       [Define this if sysinfo(2) is POSIX])
  fi
]) # end of AC_DEFUN of AG_CHECK_POSIX_SYSINFO
