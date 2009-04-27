# ===========================================================================
#           http://autoconf-archive.cryp.to/ag_check_pathfind.html
# ===========================================================================
#
# SYNOPSIS
#
#   AG_CHECK_PATHFIND
#
# DESCRIPTION
#
#   Not all systems have pathfind(3). See if we need to substitute. To make
#   this work, you have to do horrible things. See the doc for
#   AG_CHECK_STRCSPN.
#
# LICENSE
#
#   Copyright (c) 2008 Bruce Korb <bkorb@gnu.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AG_CHECK_PATHFIND],[
  AC_MSG_CHECKING([whether pathfind(3) works])
  AC_CACHE_VAL([ag_cv_pathfind],[
  AC_TRY_RUN([#include <string.h>
#include <stdlib.h>
int main (int argc, char** argv) {
   char* pz = pathfind( getenv( "PATH" ), "sh", "x" );
   return (pz == 0) ? 1 : 0;
}],[ag_cv_pathfind=yes],[ag_cv_pathfind=no],[ag_cv_pathfind=no]
  ) # end of TRY_RUN]) # end of CACHE_VAL

  AC_MSG_RESULT([$ag_cv_pathfind])
  if test x$ag_cv_pathfind = xyes
  then
    AC_DEFINE(HAVE_PATHFIND, 1,
       [Define this if pathfind(3) works])
  else
    if test x$ac_cv_lib_gen_pathfind = xyes
    then :
    else
      COMPATOBJ="$COMPATOBJ pathfind.lo"
    fi
  fi
]) # end of AC_DEFUN of AG_CHECK_PATHFIND
