##### http://autoconf-archive.cryp.to/ax_gcc_option.html
#
# SYNOPSIS
#
#   AX_GCC_OPTION(VARIABLE, OPTION, VALUE-IF-SUCCESSFUL, VALUE-IF-NOT-SUCCESFUL)
#
# DESCRIPTION
#
#   AX_GCC_OPTION checks wheter gcc accepts the passed OPTION. If it
#   accepts the OPTION then then macro sets VARIABLE to
#   VALUE-IF-SUCCESSFUL, otherwise it sets VARIABLE to
#   VALUE-IF-UNSUCCESSFUL.
#
# LAST MODIFICATION
#
#   2005-01-22
#
# COPYLEFT
#
#   Copyright (c) 2005 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

AC_DEFUN([AX_GCC_OPTION], [
AC_REQUIRE([AC_PROG_CC])
if test "x$GCC" = "xyes"; then
	AC_MSG_CHECKING([if gcc accepts $2 option])
   	if AC_TRY_COMMAND($CC $2) >/dev/null 2>&1; then
   		$1=$3
   	        AC_MSG_RESULT([yes])
   	else
   		$1=$4
   		AC_MSG_RESULT([no])
   	fi
else
	unset $1
        AC_MSG_RESULT([sorry, no gcc available])
fi
])
