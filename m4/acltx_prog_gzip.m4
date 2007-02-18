##### http://autoconf-archive.cryp.to/acltx_prog_gzip.html
#
# SYNOPSIS
#
#   ACLTX_PROG_GZIP([ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   This macro find a gzip application and set the variable gzip to the
#   name of the application or to no if not found if
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

AC_DEFUN([ACLTX_PROG_GZIP],[
AC_CHECK_PROGS(gzip,[gzip],no)
if test $gzip = "no" ;
then
	ifelse($#,0,[AC_MSG_ERROR([Unable to find the gzip application])],
        $1)
fi
])
