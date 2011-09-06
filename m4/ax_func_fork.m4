# ===========================================================================
#       http://www.gnu.org/software/autoconf-archive/ax_func_fork.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Deprecated in favor of AC_CHECK_FUNC(fork).
#
# SYNOPSIS
#
#   AX_FUNC_FORK
#
# DESCRIPTION
#
#   Check to for a working fork. Use to provide a workaround for systems
#   that don't have a working fork. For example, the workaround for the
#   fork()/exec() sequence for DOS is to use spawn.
#
#   Defines HAVE_NO_FORK is fork() doesn't work or isn't implemented.
#
# LICENSE
#
#   Copyright (c) 2008 Mark Elbrecht
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 2 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 5

AU_ALIAS([ACX_FUNC_FORK], [AX_FUNC_FORK])
AC_DEFUN([AX_FUNC_FORK],
[AC_MSG_CHECKING(for a working fork)
AC_CACHE_VAL(ax_cv_func_fork_works,
[AC_REQUIRE([AC_TYPE_PID_T])
AC_REQUIRE([AC_HEADER_SYS_WAIT])
AC_TRY_RUN([#include <sys/types.h>
#ifdef HAVE_SYS_WAIT_H
#include <sys/wait.h>
#endif
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif

int main()
{
  int status;
  pid_t child = fork();

  if (child < 0) /* Error */
    return (1);
  else if (child == 0) /* Child */
    return (0);

  /* Parent */
  status = (wait(&status) != child);
  return  (status >= 0) ? 0 : 1;
}
], ax_cv_func_fork_works=yes, ax_cv_func_fork_works=no, ax_cv_func_fork_works=no)
])
AC_MSG_RESULT($ax_cv_func_fork_works)
if test $ax_cv_func_fork_works = no; then
  AC_DEFINE(HAVE_NO_FORK)
fi
])
