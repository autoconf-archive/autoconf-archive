# ===========================================================================
#              http://autoconf-archive.cryp.to/ax_prog_fasm.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_PROG_FASM([ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   This macro searches for the FASM assembler and sets the variable "fasm"
#   to the name of the application or to "no" if not found. If
#   ACTION-IF-NOT-FOUND is not specified, configure will fail when the
#   program is not found.
#
#   Example:
#
#     AX_PROG_FASM()
#     AX_PROG_FASM([fasm_avail="no"])
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
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

AC_DEFUN([AX_PROG_FASM],[
AC_CHECK_PROGS(fasm,[fasm],no)
if test $fasm = "no" ;
then
	ifelse($#,0,[AC_MSG_ERROR([FASM assembler not found])],
        $1)
fi
])
