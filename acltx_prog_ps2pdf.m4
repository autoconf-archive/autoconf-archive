# ===========================================================================
#           http://autoconf-archive.cryp.to/acltx_prog_ps2pdf.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_PROG_PS2PDF([ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   This macro find a ps2pdf application and set the variable ps2pdf to the
#   name of the application or to no if not found if ACTION-IF-NOT-FOUND is
#   not specified, configure fail when then application is not found.
#
#   It is possible to set manually the program to use using ps2pdf=...
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

AC_DEFUN([ACLTX_PROG_PS2PDF],[
AC_ARG_VAR(ps2pdf,[specify default ps2pdf application])
if test "$ac_cv_env_ps2pdf_set" = "set" ; then
    AC_MSG_CHECKING([Checking for ps2pdf])
    ps2pdf="$ac_cv_env_ps2pdf_value";
    AC_MSG_RESULT([$ps2pdf (from parameter)])
else
    AC_CHECK_PROGS(ps2pdf,[ps2pdf14 ps2pdf13 ps2pdf12 ps2pdf pstopdf],no)
fi
if test $ps2pdf = "no" ;
then
	ifelse($#,0,[AC_MSG_ERROR([Unable to find the ps2pdf application])],
        $1)
fi
])
