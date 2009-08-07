# ===========================================================================
#       http://www.nongnu.org/autoconf-archive/ax_latex_dvips_t_a4.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_LATEX_DVIPS_T_A4
#
# DESCRIPTION
#
#   Check if dvips accepts "-t a4".
#
# LICENSE
#
#   Copyright (c) 2008 Boretti Mathieu <boretti@eig.unige.ch>
#
#   This library is free software; you can redistribute it and/or modify it
#   under the terms of the GNU Lesser General Public License as published by
#   the Free Software Foundation; either version 2.1 of the License, or (at
#   your option) any later version.
#
#   This library is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
#   General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public License
#   along with this library. If not, see <http://www.gnu.org/licenses/>.

AC_DEFUN([AX_LATEX_DVIPS_T_A4],[
AX_LATEX_DVIPS_T(a4,dvips_t_a4)
if test $dvips_t_a4 = "no";
then
    AC_MSG_ERROR([Unable to find the -t a4 option in dvips])
fi
])
