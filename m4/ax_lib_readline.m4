# ===========================================================================
#     https://www.gnu.org/software/autoconf-archive/ax_lib_readline.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_LIB_READLINE
#   AX_LIB_READLINE([MIN-VERSION])
#
# DESCRIPTION
#
#   Searches for a readline compatible library. If found, defines
#   `HAVE_LIBREADLINE'. If the found library has the `add_history' function,
#   sets also `HAVE_READLINE_HISTORY'. Also checks for the locations of the
#   necessary include files and sets `HAVE_READLINE_H' or
#   `HAVE_READLINE_READLINE_H' and `HAVE_READLINE_HISTORY_H' or
#   'HAVE_HISTORY_H' if the corresponding include files exists.
#
#   If given, MIN-VERSION specifies the minimum acceptable version; if that
#   version is not found, HAVE_LIBREADLINE and HAVE_READLINE_HISTORY will
#   not be defined.
#
#   The libraries that may be readline compatible are `libedit',
#   `libeditline' and `libreadline'. Sometimes we need to link a termcap
#   library for readline to work, this macro tests these cases too by trying
#   to link with `libtermcap', `libcurses' or `libncurses' before giving up.
#
#   Here is an example of how to use the information provided by this macro
#   to perform the necessary includes or declarations in a C file:
#
#     #ifdef HAVE_LIBREADLINE
#     #  if defined(HAVE_READLINE_READLINE_H)
#     #    include <readline/readline.h>
#     #  elif defined(HAVE_READLINE_H)
#     #    include <readline.h>
#     #  else /* !defined(HAVE_READLINE_H) */
#     extern char *readline ();
#     #  endif /* !defined(HAVE_READLINE_H) */
#     #else /* !defined(HAVE_READLINE_READLINE_H) */
#       /* no readline */
#     #endif /* HAVE_LIBREADLINE */
#
#     #ifdef HAVE_READLINE_HISTORY
#     #  if defined(HAVE_READLINE_HISTORY_H)
#     #    include <readline/history.h>
#     #  elif defined(HAVE_HISTORY_H)
#     #    include <history.h>
#     #  else /* !defined(HAVE_HISTORY_H) */
#     extern void add_history ();
#     extern int write_history ();
#     extern int read_history ();
#     #  endif /* defined(HAVE_READLINE_HISTORY_H) */
#       /* no history */
#     #endif /* HAVE_READLINE_HISTORY */
#
# LICENSE
#
#   Copyright (c) 2025 Reuben Thomas <rrt@sc3d.org>
#   Copyright (c) 2008 Ville Laurikari <vl@iki.fi>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 10

AU_ALIAS([VL_LIB_READLINE], [AX_LIB_READLINE])
AC_DEFUN([AX_LIB_READLINE], [
  AC_CACHE_CHECK([for a readline compatible library],
                 ax_cv_lib_readline, [
    ORIG_LIBS="$LIBS"
    for readline_lib in readline edit editline; do
      for termcap_lib in "" termcap curses ncurses; do
        if test -z "$termcap_lib"; then
          TRY_LIB="-l$readline_lib"
        else
          TRY_LIB="-l$readline_lib -l$termcap_lib"
        fi
        LIBS="$ORIG_LIBS $TRY_LIB"
        AC_LINK_IFELSE([AC_LANG_CALL([], [readline])], [ax_cv_lib_readline="$TRY_LIB"])
        if test -n "$ax_cv_lib_readline"; then
          break
        fi
      done
      if test -n "$ax_cv_lib_readline"; then
        break
      fi
    done
    if test -z "$ax_cv_lib_readline"; then
      ax_cv_lib_readline="no"
    fi
    LIBS="$ORIG_LIBS"
  ])

  if test "$ax_cv_lib_readline" != "no"; then
    LIBS="$LIBS $ax_cv_lib_readline"
    AC_CHECK_HEADERS(readline.h readline/readline.h)

    m4_if([$1], [],
      [ dnl No version given, so assume it is OK
        ax_cv_lib_readline_version_ok=yes
      ],
      [ dnl Check against given version
        AC_CACHE_CHECK([check readline is at least version $1],
          ax_cv_lib_readline_version_ok, [
            AC_RUN_IFELSE([
              AC_LANG_SOURCE([[
#include <stdio.h>

#if defined(HAVE_READLINE_READLINE_H)
#  include <readline/readline.h>
#elif defined(HAVE_READLINE_H)
#  include <readline.h>
#endif

int main(void) {
    float min_version = $1;
    int min_version_major = (int)min_version;
    int min_version_minor = (int)(min_version * 100.0);
    int min_version_hex = min_version_minor + (min_version_major * 256);
    return !(RL_READLINE_VERSION >= min_version_hex);
}
              ]])
            ], [ax_cv_lib_readline_version_ok=yes], [ax_cv_lib_readline_version_ok=no], [ax_cv_lib_readline_version_ok=no])
        ])
      ]
    )

    if test "$ax_cv_lib_readline_version_ok" = "yes"; then
      AC_DEFINE(HAVE_LIBREADLINE, 1,
              [Define if you have a readline compatible library])

      AC_CACHE_CHECK([whether readline supports history],
                     ax_cv_lib_readline_history, [
        ax_cv_lib_readline_history="no"
        AC_LINK_IFELSE([AC_LANG_CALL([], [add_history])], [ax_cv_lib_readline_history="yes"])
      ])
      if test "$ax_cv_lib_readline_history" = "yes"; then
        AC_DEFINE(HAVE_READLINE_HISTORY, 1,
                  [Define if your readline library has \`add_history'])
        AC_CHECK_HEADERS(history.h readline/history.h)
      fi
    else
      LIBS="$ORIG_LIBS"
    fi
  fi
])dnl
