# ===========================================================================
#           http://autoconf-archive.cryp.to/acltx_class_report.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_CLASS_REPORT([ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   This macro test if class report is installed and fail (default) with a
#   error message if not
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

AC_DEFUN([ACLTX_CLASS_REPORT],[
ACLTX_CLASS(report,report,[],[m4_ifval([$1],[$1],AC_MSG_ERROR([Unable to find the report class]))])
])
