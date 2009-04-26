# ===========================================================================
#           http://autoconf-archive.cryp.to/acltx_compress_eps.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_COMPRESS_EPS([ACTION-IF-FOUND[,ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   this macro find a way to compress eps file, using Makefile target. If
#   the way is found, set compress_eps to this way else set compress_eps to
#   no
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

AC_DEFUN([ACLTX_COMPRESS_EPS],[
ACLTX_PROG_GZIP([AC_MSG_WARN([Unable to locate a gzip application to compress eps file])])
compress_eps=''; export compress_eps;
if test "$gzip" = "no" ; then
    AC_MSG_CHECKING(for a way to compress eps)
    AC_MSG_RESULT(no)
else
    AC_CHECK_PROGS(grep,grep,no)
    AC_MSG_CHECKING(for a way to compress eps)
    if test "$grep" = "no" ; then
    AC_MSG_RESULT(no)
    else
        compress_eps="%.eps.gz %.eps.bb : %.eps ; cat \[$]*.eps | grep \"%%BoundingBox\" > \[$]*.eps.bb ; rm -f \[$]*.eps.gz ; gzip \[$]*.eps"; export compress_eps
        AC_MSG_RESULT($compress_eps)
    fi;
fi;
AC_SUBST(compress_eps)
ifelse($#,0,[],$#,1,[
    if test "$compress_eps" != "no" ;
    then
        $1
    fi
],$#,2,[
    ifelse($1,[],[
        if test "$compress_eps" = "no" ;
        then
            $2
        fi
    ],[
        if test "$compress_eps" != "no" ;
        then
            $1
        else
            $2
        fi
    ])
])
])
