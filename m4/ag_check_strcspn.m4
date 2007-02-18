##### http://autoconf-archive.cryp.to/ag_check_strcspn.html
#
# SYNOPSIS
#
#   AG_CHECK_STRCSPN
#
# DESCRIPTION
#
#   Not all systems have strcspn(3). See if we need to substitute. To
#   make this work, you have to do horrible things. In one of your
#   Makefile.am files, you must make an explicit rule to make this
#   object. It should look like this:
#
#     strcspn.lo : $(top_srcdir)/compat/strcspn.c
#         $(LTCOMPILE) -o $@ -c $(top_srcdir)/compat/strcspn.c
#
#   and you must include ``@COMPATOBJ@'' in a LIBADD somewhere and,
#   finally, you must add another artificial dependency, something
#   like:
#
#     makeshell.lo : genshell.c @COMPATOBJ@
#
#   It is all pretty horrific, but I have found nothing else that
#   works.
#
# LAST MODIFICATION
#
#   2001-12-01
#
# COPYLEFT
#
#   Copyright (c) 2001 Bruce Korb <bkorb@gnu.org>
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
#   02111-1307, USA.
#
#   As a special exception, the respective Autoconf Macro's copyright
#   owner gives unlimited permission to copy, distribute and modify the
#   configure scripts that are the output of Autoconf when processing
#   the Macro. You need not follow the terms of the GNU General Public
#   License when using or distributing such scripts, even though
#   portions of the text of the Macro appear in them. The GNU General
#   Public License (GPL) does govern all other use of the material that
#   constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the
#   Autoconf Macro released by the Autoconf Macro Archive. When you
#   make and distribute a modified version of the Autoconf Macro, you
#   may extend this special exception to the GPL to apply to your
#   modified version as well.

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
