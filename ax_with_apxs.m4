##### http://autoconf-archive.cryp.to/ax_with_apxs.html
#
# SYNOPSIS
#
#   AX_WITH_APXS([value-if-not-found], [path])
#
# DESCRIPTION
#
#   Locates an installed apxs binary, placing the result in the
#   precious variable $APXS. Accepts a preset $APXS, then --with-apxs,
#   and failing that searches for apxs in the given path (which
#   defaults to the system path). If apxs is found, $APXS is set to the
#   full path of the binary; otherwise it is set to VALUE-IF-NOT-FOUND,
#   which defaults to apxs.
#
#   Example:
#
#     AX_WITH_APXS(missing)
#
# LAST MODIFICATION
#
#   2005-01-22
#
# COPYLEFT
#
#   Copyright (c) 2005 Dustin Mitchell <dustin@cs.uchicago.edu>
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

AC_DEFUN([AX_WITH_APXS],
[
  AC_ARG_VAR([APXS])

  dnl unless APXS was supplied to us (as a precious variable)
  if test -z "$APXS"
  then
    AC_MSG_CHECKING(for --with-apxs)
    AC_ARG_WITH(apxs,
                AC_HELP_STRING([--with-apxs=APXS],
                               [absolute path name of apxs executable]),
                [ if test "$withval" != "yes"
                  then
                    APXS="$withval"
                    AC_MSG_RESULT($withval)
                  else
                    AC_MSG_RESULT(no)
                  fi
                ],
                [ AC_MSG_RESULT(no)
                ])
  fi

  dnl if it's still not found, check the paths, or use the fallback
  if test -z "$APXS"
  then
    AC_PATH_PROG([APXS], apxs, m4_ifval([$1],[$1],[apxs]), $2)
  fi
])
