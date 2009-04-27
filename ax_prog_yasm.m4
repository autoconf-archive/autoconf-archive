# ===========================================================================
#              http://autoconf-archive.cryp.to/ax_prog_yasm.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_PROG_YASM([ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   This macro searches for the YASM assembler and sets the variable "yasm"
#   to the name of the application or to "no" if not found. If
#   ACTION-IF-NOT-FOUND is not specified, configure will fail when the
#   program is not found.
#
#   Example:
#
#     AX_PROG_YASM()
#     AX_PROG_YASM([yasm_avail="no"])
#
# LICENSE
#
#   Copyright (c) 2008 Bogdan Drozdowski <bogdandr # op . pl>
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU Lesser General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or (at
#   your option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
#   General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public License
#   along with this program. If not, see <http://www.gnu.org/licenses/>.

AC_DEFUN([AX_PROG_YASM],[
AC_CHECK_PROGS(yasm,[yasm],no)
if test $yasm = "no" ;
then
	ifelse($#,0,[AC_MSG_ERROR([YASM assembler not found])],
        $1)
fi
])
