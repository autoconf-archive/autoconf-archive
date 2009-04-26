# ===========================================================================
#        http://autoconf-archive.cryp.to/ag_check_allocated_ctime.html
# ===========================================================================
#
# SYNOPSIS
#
#   AG_CHECK_ALLOCATED_CTIME
#
# DESCRIPTION
#
#   Check whether we need to free the memory returned by ctime.
#
# LICENSE
#
#   Copyright (c) 2008 Bruce Korb <bkorb@gnu.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AG_CHECK_ALLOCATED_CTIME],[
  AC_MSG_CHECKING([whether ctime() allocates memory for its result])
  AC_CACHE_VAL([ag_cv_allocated_ctime],[
  AC_TRY_RUN([#include <time.h>
int main (int argc, char** argv) {
   time_t  timeVal = time( (time_t*)NULL );
   char*   pzTime  = ctime( &timeVal );
   free( (void*)pzTime );
   return 0; }],[ag_cv_allocated_ctime=yes],[ag_cv_allocated_ctime=no],[ag_cv_allocated_ctime=no]
  ) # end of TRY_RUN]) # end of CACHE_VAL

  AC_MSG_RESULT([$ag_cv_allocated_ctime])
  if test x$ag_cv_allocated_ctime = xyes
  then
    AC_DEFINE(HAVE_ALLOCATED_CTIME, 1,
       [Define this if ctime() allocates memory for its result])
  fi
]) # end of AC_DEFUN of AG_CHECK_ALLOCATED_CTIME
