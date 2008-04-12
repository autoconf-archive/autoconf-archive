# ===========================================================================
#      http://autoconf-archive.cryp.to/ac_prog_cc_strict_prototypes.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Use AX_CFLAGS_STRICT_PROTOTYPES.
#
# SYNOPSIS
#
#   AC_PROG_CC_STRICT_PROTOTYPES(substvar [,hard])
#
# DESCRIPTION
#
#   Try to find a compiler option that warns when a function prototype is
#   not fully defined. Enable it only if the the system headers are
#   reasonably clean with respect to compiling with strict-prototypes.
#
#   The sanity check is done by looking at sys/signal.h which has a set of
#   macro-definitions SIG_DFL and SIG_IGN that are cast to the local
#   signal-handler type. If that signal-handler type is not fully qualified
#   then the system headers are not seen as strictly prototype clean.
#
#   Currently this macro knows about GCC. hopefully will evolve to use:
#   Solaris C compiler, Digital Unix C compiler, C for AIX Compiler, HP-UX C
#   compiler, and IRIX C compiler.
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
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
#   Macro released by the Autoconf Macro Archive. When you make and
#   distribute a modified version of the Autoconf Macro, you may extend this
#   special exception to the GPL to apply to your modified version as well.

AC_DEFUN([AC_PROG_CC_STRICT_PROTOTYPES], [
  pushdef([CV], ac_cv_prog_cc_strict_prototypes)dnl
  hard=$2
  if test -z "$hard"; then
    msg="C to warn at nonstrict prototypes"
  else
    msg="C to require strict prototypes"
  fi
  AC_CACHE_CHECK($msg, CV, [
  cat > conftest.c <<EOF
#include <sys/signal.h>
int main (void)
{
   if (signal (SIGINT, SIG_IGN) == SIG_DFL) return 0;
   return 1;
}
EOF

  dnl GCC
  if test "$GCC" = "yes"; then
    if test -z "$hard"; then
      CV="-Wstrict-prototypes"
    else
      CV="-fstrict-prototypes -Wstrict-prototypes"
    fi

    if test -n "`${CC-cc} -c $CV conftest.c 2>&1`" ; then
      CV="suppressed...sys/stat.h"
    fi

  dnl Solaris C compiler

  dnl HP-UX C compiler

  dnl Digital Unix C compiler

  dnl C for AIX Compiler

  dnl IRIX C compiler

  fi
  rm -f conftest.*
  ])
  if test -z "[$]$1" ; then
    if test -n "$CV" ; then
      case "$CV" in
        *...*) $1="" ;; # known but suppressed
        *)  $1="$CV" ;;
      esac
    fi
  fi
  AC_SUBST($1)
  popdef([CV])dnl
])
