# ===========================================================================
#        http://www.nongnu.org/autoconf-archive/ax_prog_fasm_opt.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_PROG_FASM_OPT(option, var_name)
#
# DESCRIPTION
#
#   This macro checks if the FASM assembler accepts the given option. If
#   yes, the option is appended to the variable 'var_name', otherwise
#   'var_name' is unchanged.
#
#   Example:
#
#     AX_PROG_FASM_OPT([-m 256], [FASM_OPTS])
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

AC_DEFUN([AX_PROG_FASM_OPT],[
AC_REQUIRE([AX_PROG_FASM])dnl
AC_MSG_CHECKING([if $fasm accepts $1])
echo '' > conftest.asm
if $fasm $$2 $1 conftest.asm > conftest.err; then
	$2="$$2 $1"
	AC_MSG_RESULT([yes])
else
	AC_MSG_RESULT([no])
fi
])
