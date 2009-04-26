# ===========================================================================
#          http://autoconf-archive.cryp.to/acltx_prog_kpsewhich.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_PROG_KPSEWHICH([ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   This macro find a kpsewhich application and set the variable kpsewhich
#   to the name of the application or to no if not found if
#   ACTION-IF-NOT-FOUND is not specified, configure fail when then
#   application is not found.
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

AC_DEFUN([ACLTX_PROG_KPSEWHICH],[
AC_CHECK_PROGS(kpsewhich,[kpsewhich],no)
if test $kpsewhich = "no" ;
then
	ifelse($#,0,[AC_MSG_ERROR([Unable to find the kpsewhich application])],
        $1)
fi
])
