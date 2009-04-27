# ===========================================================================
#             http://autoconf-archive.cryp.to/mp_with_curses.html
# ===========================================================================
#
# SYNOPSIS
#
#   MP_WITH_CURSES
#
# DESCRIPTION
#
#   Detect SysV compatible curses, such as ncurses.
#
#   Defines HAVE_CURSES_H or HAVE_NCURSES_H if curses is found. CURSES_LIB
#   is also set with the required libary, but is not appended to LIBS
#   automatically. If no working curses libary is found CURSES_LIB will be
#   left blank.
#
#   This macro adds the option "--with-ncurses" to configure which can force
#   the use of ncurses or nothing at all.
#
# LICENSE
#
#   Copyright (c) 2008 Mark Pulford <mark@kyne.com.au>
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
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

AC_DEFUN([MP_WITH_CURSES],
  [AC_ARG_WITH(ncurses, [  --with-ncurses          Force the use of ncurses over curses],,)
   mp_save_LIBS="$LIBS"
   CURSES_LIB=""
   if test "$with_ncurses" != yes
   then
     AC_CACHE_CHECK([for working curses], mp_cv_curses,
       [LIBS="$LIBS -lcurses"
        AC_TRY_LINK(
          [#include <curses.h>],
          [chtype a; int b=A_STANDOUT, c=KEY_LEFT; initscr(); ],
          mp_cv_curses=yes, mp_cv_curses=no)])
     if test "$mp_cv_curses" = yes
     then
       AC_DEFINE([HAVE_CURSES_H],[1],[Define if you have curses.h])
       CURSES_LIB="-lcurses"
     fi
   fi
   if test ! "$CURSES_LIB"
   then
     AC_CACHE_CHECK([for working ncurses], mp_cv_ncurses,
       [LIBS="$mp_save_LIBS -lncurses"
        AC_TRY_LINK(
          [#include <ncurses.h>],
          [chtype a; int b=A_STANDOUT, c=KEY_LEFT; initscr(); ],
          mp_cv_ncurses=yes, mp_cv_ncurses=no)])
     if test "$mp_cv_ncurses" = yes
     then
       AC_DEFINE([HAVE_NCURSES_H],[1],[Define if you have ncurses.h])
       CURSES_LIB="-lncurses"
     fi
   fi
   LIBS="$mp_save_LIBS"
])dnl
