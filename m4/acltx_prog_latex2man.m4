##### http://autoconf-archive.cryp.to/acltx_prog_latex2man.html
#
# SYNOPSIS
#
#   ACLTX_PROG_LATEX2MAN([ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   This macro find a latex2man application and set the variable
#   latex2man to the name of the application or to no if not found if
#   ACTION-IF-NOT-FOUND is not specified, configure fail when then
#   application is not found.
#
# LAST MODIFICATION
#
#   2006-07-16
#
# COPYLEFT
#
#   Copyright (c) 2006 Boretti Mathieu <boretti@eig.unige.ch>
#
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU Lesser General Public License
#   as published by the Free Software Foundation; either version 2.1 of
#   the License, or (at your option) any later version.
#
#   This library is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public
#   License along with this library; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
#   02110-1301 USA

AC_DEFUN([ACLTX_PROG_LATEX2MAN],[
AC_CHECK_PROGS(latex2man,[latex2man],no)
if test $latex2man = "no" ;
then
	ifelse($#,0,[AC_MSG_ERROR([Unable to find the latex2man application])],
        $1)
fi
])
