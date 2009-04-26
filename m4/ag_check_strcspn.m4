# ===========================================================================
#            http://autoconf-archive.cryp.to/ag_check_strcspn.html
# ===========================================================================
#
# SYNOPSIS
#
#   AG_CHECK_STRCSPN
#
# DESCRIPTION
#
#   Not all systems have strcspn(3). See if we need to substitute. To make
#   this work, you have to do horrible things. In one of your Makefile.am
#   files, you must make an explicit rule to make this object. It should
#   look like this:
#
#     strcspn.lo : $(top_srcdir)/compat/strcspn.c
#         $(LTCOMPILE) -o $@ -c $(top_srcdir)/compat/strcspn.c
#
#   and you must include ``@COMPATOBJ@'' in a LIBADD somewhere and, finally,
#   you must add another artificial dependency, something like:
#
#     makeshell.lo : genshell.c @COMPATOBJ@
#
#   It is all pretty horrific, but I have found nothing else that works.
#
# LICENSE
#
#   Copyright (c) 2008 Bruce Korb <bkorb@gnu.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AG_CHECK_STRCSPN],[
  AC_MSG_CHECKING([whether strcspn matches prototype and works])
  AC_CACHE_VAL([ag_cv_strcspn],[
  AC_TRY_RUN([#include <string.h>
int main (int argc, char** argv) {
   char zRej[] = "reject";
   char zAcc[] = "a-ok-eject";
   return strcspn( zAcc, zRej ) - 5;
}],[ag_cv_strcspn=yes],[ag_cv_strcspn=no],[ag_cv_strcspn=no]
  ) # end of TRY_RUN]) # end of CACHE_VAL

  AC_MSG_RESULT([$ag_cv_strcspn])
  if test x$ag_cv_strcspn = xyes
  then
    AC_DEFINE(HAVE_STRCSPN, 1,
       [Define this if strcspn matches prototype and works])
  else
    COMPATOBJ="$COMPATOBJ strcspn.lo"
  fi
]) # end of AC_DEFUN of AG_CHECK_STRCSPN
