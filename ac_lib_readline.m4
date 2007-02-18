##### http://autoconf-archive.cryp.to/ac_lib_readline.html
#
# OBSOLETE MACRO
#
#   Renamed to VL_LIB_READLINE.
#
# SYNOPSIS
#
#   AC_LIB_READLINE
#
# DESCRIPTION
#
#   Searches for a readline compatible library. If found, defines
#   `HAVE_LIBREADLINE'. If the found library has the `add_history'
#   function, sets also `HAVE_READLINE_HISTORY'. Also checks for the
#   locations of the necessary include files and sets `HAVE_READLINE_H'
#   or `HAVE_READLINE_READLINE_H' and `HAVE_READLINE_HISTORY_H' or
#   'HAVE_HISTORY_H' if the corresponding include files exists.
#
#   The libraries that may be readline compatible are `libedit',
#   `libeditline' and `libreadline'. Sometimes we need to link a
#   termcap library for readline to work, this macro tests these cases
#   too by trying to link with `libtermcap', `libcurses' or
#   `libncurses' before giving up.
#
#   Here is an example of how to use the information provided by this
#   macro to perform the necessary includes or declarations in a C
#   file:
#
#     #include <config.h>
#
#     #ifdef HAVE_LIBREADLINE
#     #if defined(HAVE_READLINE_READLINE_H)
#     #include <readline/readline.h>
#     #elif defined(HAVE_READLINE_H)
#     #include <readline.h>
#     #else /* !defined(HAVE_READLINE_H) */
#     extern char *readline ();
#     #endif /* !defined(HAVE_READLINE_H) */
#     char *cmdline = NULL;
#     #else /* !defined(HAVE_READLINE_READLINE_H) */
#       /* no readline */
#     #endif /* HAVE_LIBREADLINE */
#
#     #ifdef HAVE_READLINE_HISTORY
#     #if defined(HAVE_READLINE_HISTORY_H)
#     #include <readline/history.h>
#     #elif defined(HAVE_HISTORY_H)
#     #include <history.h>
#     #else /* !defined(HAVE_HISTORY_H) */
#     extern void add_history ();
#     extern int write_history ();
#     extern int read_history ();
#     #endif /* defined(HAVE_READLINE_HISTORY_H) */
#       /* no history */
#     #endif /* HAVE_READLINE_HISTORY */
#
# LAST MODIFICATION
#
#   2005-01-25
#
# COPYLEFT
#
#   Copyright (c) 2005 Ville Laurikari <vl@iki.fi>
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

AC_DEFUN([AC_LIB_READLINE], [
  AC_CACHE_CHECK([for a readline compatible library],
                 ac_cv_lib_readline, [
    ORIG_LIBS=$LIBS
    for readline_lib in readline edit editline; do
      for termcap_lib in "" termcap curses ncurses; do
        if test -z "$termcap_lib"; then
          TRY_LIB="-l$readline_lib"
        else
          TRY_LIB="-l$readline_lib -l$termcap_lib"
        fi
        LIBS="$ORIG_LIBS $TRY_LIB"
        AC_TRY_LINK_FUNC(readline, ac_cv_lib_readline="$TRY_LIB")
        if test -n "$ac_cv_lib_readline"; then
          break
        fi
      done
      if test -n "$ac_cv_lib_readline"; then
        break
      fi
    done
    if test -z "$ac_cv_lib_readline"; then
      ac_cv_lib_readline="no"
      LIBS=$ORIG_LIBS
    fi
  ])

  if test "$ac_cv_lib_readline" != "no"; then
    AC_DEFINE(HAVE_LIBREADLINE, 1,
              [Define if you have a readline compatible library])
    AC_CHECK_HEADERS(readline.h readline/readline.h)
    AC_CACHE_CHECK([whether readline supports history],
                   ac_cv_lib_readline_history, [
      ac_cv_lib_readline_history="no"
      AC_TRY_LINK_FUNC(add_history, ac_cv_lib_readline_history="yes")
    ])
    if test "$ac_cv_lib_readline_history" = "yes"; then
      AC_DEFINE(HAVE_READLINE_HISTORY, 1,
                [Define if your readline library has \`add_history'])
      AC_CHECK_HEADERS(history.h readline/history.h)
    fi
  fi
])
