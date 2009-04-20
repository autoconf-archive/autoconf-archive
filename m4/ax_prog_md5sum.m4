# ===========================================================================
#             http://autoconf-archive.cryp.to/ax_prog_md5sum.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_PROG_MD5SUM([ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   This macro find a md5sum application and set the variable md5sum to the
#   name of the application or to no if not found if ACTION-IF-NOT-FOUND is
#   not specified, configure fail when then application is not found.
#
# LAST MODIFICATION
#
#   2009-04-20
#
# COPYLEFT
#
#   Copyright (c) 2009 Gabriele Bartolini <gabriele.bartolini@devise.it>
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

AC_DEFUN([AX_PROG_MD5SUM],[
# Mac users have md5 instead of md5sum
AC_CHECK_PROGS(md5sum,[md5sum md5],no)
if test $md5sum = "no" ;
then
       ifelse($#,0,[AC_MSG_ERROR([Unable to find the md5sum application (or equivalent)])],
               $1)
fi
])
