# ===========================================================================
#          http://www.nongnu.org/autoconf-archive/ax_prog_tasm.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_PROG_TASM([ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   This macro searches for the TASM assembler and sets the variable "tasm"
#   to the name of the application or to "no" if not found. If
#   ACTION-IF-NOT-FOUND is not specified, configure will fail when the
#   program is not found.
#
#   Example:
#
#     AX_PROG_TASM()
#     AX_PROG_TASM([tasm_avail="no"])
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

AC_DEFUN([AX_PROG_TASM],[
AC_CHECK_PROGS(tasm,[tasm tasm32],no)
if test $tasm = "no" ;
then
	ifelse($#,0,[AC_MSG_ERROR([TASM assembler not found])],
        $1)
fi
])
