##### http://autoconf-archive.cryp.to/ac_prog_cc_no_writeable_strings.html
#
# OBSOLETE MACRO
#
#   Use AX_CFLAGS_NO_WRITABLE_STRINGS.
#
# SYNOPSIS
#
#   AC_PROG_CC_NO_WRITEABLE_STRINGS(substvar [,hard])
#
# DESCRIPTION
#
#   Try to find a compiler option that warns when a stringliteral is
#   used in a place that could potentially modify the address. This
#   should warn on giving an stringliteral to a function that asks of a
#   non-const-modified char-pointer.
#
#   The sanity check is done by looking at string.h which has a set of
#   strcpy definitions that should be defined with const-modifiers to
#   not emit a warning in all so many places.
#
#   Currently this macro knows about GCC. hopefully will evolve to use:
#   Solaris C compiler, Digital Unix C compiler, C for AIX Compiler,
#   HP-UX C compiler, and IRIX C compiler.
#
# LAST MODIFICATION
#
#   2006-10-13
#
# COPYLEFT
#
#   Copyright (c) 2006 Guido U. Draheim <guidod@gmx.de>
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

AC_DEFUN([AC_PROG_CC_NO_WRITEABLE_STRINGS], [
  pushdef([CV],ac_cv_prog_cc_no_writeable_strings)dnl
  hard=$2
  if test -z "$hard"; then
    msg="C to warn about writing to stringliterals"
  else
    msg="C to prohibit any write to stringliterals"
  fi
  AC_CACHE_CHECK($msg, CV, [
  cat > conftest.c <<EOF
#include <string.h>
int main (void)
{
   char test[[16]];
   if (strcpy (test, "test")) return 0;
   return 1;
}
EOF
  dnl GCC
  if test "$GCC" = "yes";
  then
        if test -z "$hard"; then
            CV="-Wwrite-strings"
        else
            CV="-fno-writable-strings -Wwrite-strings"
        fi

        if test -n "`${CC-cc} -c $CV conftest.c 2>&1`" ; then
            CV="suppressed: string.h"
        fi

  dnl Solaris C compiler
  elif  $CC -flags 2>&1 | grep "Xc.*strict ANSI C" > /dev/null 2>&1 &&
        $CC -c -xstrconst conftest.c > /dev/null 2>&1 &&
        test -f conftest.o
  then
        # strings go into readonly segment
        CV="-xstrconst"

        rm conftest.o
        if test -n "`${CC-cc} -c $CV conftest.c 2>&1`" ; then
             CV="suppressed: string.h"
        fi

  dnl HP-UX C compiler
  elif  $CC > /dev/null 2>&1 &&
        $CC -c +ESlit conftest.c > /dev/null 2>&1 &&
        test -f conftest.o
  then
       # strings go into readonly segment
        CV="+ESlit"

        rm conftest.o
        if test -n "`${CC-cc} -c $CV conftest.c 2>&1`" ; then
             CV="suppressed: string.h"
        fi

  dnl Digital Unix C compiler
  elif ! $CC > /dev/null 2>&1 &&
        $CC -c -readonly_strings conftest.c > /dev/null 2>&1 &&
        test -f conftest.o
  then
       # strings go into readonly segment
        CV="-readonly_strings"

        rm conftest.o
        if test -n "`${CC-cc} -c $CV conftest.c 2>&1`" ; then
             CV="suppressed: string.h"
        fi

  dnl C for AIX Compiler

  dnl IRIX C compiler
        # -use_readonly_const is the default for IRIX C,
        # puts them into .rodata, but they are copied later.
        # need to be "-G0 -rdatashared" for strictmode but
        # I am not sure what effect that has really.

  fi
  rm -f conftest.*
  ])
  if test -z "[$]$1" ; then
    if test -n "$CV" ; then
      case "$CV" in
        suppressed*) $1="" ;; # known but suppressed
        *)  $1="$CV" ;;
      esac
    fi
  fi
  AC_SUBST($1)
  popdef([CV])dnl
])
