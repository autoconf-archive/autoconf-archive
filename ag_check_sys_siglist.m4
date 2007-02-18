##### http://autoconf-archive.cryp.to/ag_check_sys_siglist.html
#
# SYNOPSIS
#
#   AG_CHECK_SYS_SIGLIST
#
# DESCRIPTION
#
#   Check for existence of global sys_siglist[].
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

AC_DEFUN([AG_CHECK_SYS_SIGLIST],[
  AC_MSG_CHECKING([whether there is a global text array sys_siglist])
  AC_CACHE_VAL([ag_cv_sys_siglist],[
  AC_TRY_RUN([#include <signal.h>
int main() {
  const char* pz = sys_siglist[1];
  return (pz != 0) ? 0 : 1; }],[ag_cv_sys_siglist=yes],[ag_cv_sys_siglist=no],[ag_cv_sys_siglist=no]
  ) # end of TRY_RUN]) # end of CACHE_VAL

  AC_MSG_RESULT([$ag_cv_sys_siglist])
  if test x$ag_cv_sys_siglist = xyes
  then
    AC_DEFINE(HAVE_SYS_SIGLIST, 1,
       [Define this if there is a global text array sys_siglist])
    NEED_SYS_SIGLIST=false
  else
    NEED_SYS_SIGLIST=true
  fi
  AC_SUBST(NEED_SYS_SIGLIST)
]) # end of AC_DEFUN of AG_CHECK_SYS_SIGLIST
