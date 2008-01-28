##### http://autoconf-archive.cryp.to/ax_prog_guile_version.html
#
# SYNOPSIS
#
#   AX_PROG_GUILE_VERSION([VERSION],[ACTION-IF-TRUE],[ACTION-IF-FALSE])
#
# DESCRIPTION
#
#   Makes sure that guile supports the version indicated. If true the
#   shell commands in ACTION-IF-TRUE are executed. If not the shell
#   commands in ACTION-IF-FALSE are run. Note if $GUILE is not set (for
#   example by running AC_CHECK_PROG or AC_PATH_PROG),
#
#   Example:
#
#     AC_PATH_PROG([GUILE],[guile])
#     AC_PROG_GUILE_VERSION([1.6.0],[ ... ],[ ... ])
#
#   This will check to make sure that the guile you have supports at
#   least version 1.6.0.
#
#   NOTE: This macro uses the $GUILE variable to perform the check.
#   AX_WITH_GUILE can be used to set that variable prior to running
#   this macro. The $GUILE_VERSION variable will be valorized with the
#   detected version.
#
# LAST MODIFICATION
#
#   2008-01-27
#
# COPYLEFT
#
#   Copyright (c) 2008 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

AC_DEFUN([AX_PROG_GUILE_VERSION],[
    AC_REQUIRE([AC_PROG_SED])

    AS_IF([test -n "$GUILE"],[
        ax_guile_version="$1"

        AC_MSG_CHECKING([for guile version])
        changequote(<<,>>)
        guile_version=`$GUILE -q --version 2>&1 | head -n 1 | $SED -e 's/.* \([0-9]*\.[0-9]*\.[0-9]*\)/\1/'`
        changequote([,])
        AC_MSG_RESULT($guile_version)

	AC_SUBST([GUILE_VERSION],[$guile_version])

        AX_COMPARE_VERSION([$ax_guile_version],[le],[$guile_version],[
	    :
            $2
        ],[
	    :
            $3
        ])
    ],[
        AC_MSG_WARN([could not find the guile interpreter])
        $3
    ])
])
