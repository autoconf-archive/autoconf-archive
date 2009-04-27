# ===========================================================================
#        http://autoconf-archive.cryp.to/acltx_converting_jpg_eps.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_CONVERTING_JPG_EPS([ACTION-IF-FOUND[,ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   This macro find a way to convert jpg to eps file. If the way is found,
#   set jpg_to_eps to this way else set jpg_to_eps to no.
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

AC_DEFUN([ACLTX_CONVERTING_JPG_EPS],[
ACLTX_PROG_JPEGTOPNM([AC_MSG_WARN([Unable to locate a jpegtopnm application to convert jpg file])])
ACLTX_PROG_PNMTOPS([AC_MSG_WARN([Unable to locate a pnmtops application to convert jpg file])])
AC_MSG_CHECKING(for a way to convert jpg file to eps file)
jpg_to_eps='no'; export jpg_to_eps;
if test "$jpegtopnm" != "no" -a "$pnmtops" != "no" ; then
    jpg_to_eps="%.eps : %.jpg ; $jpegtopnm \[$]*.jpg | pnmtops -noturn -nocenter -scale 1.00 - >\[$]*.eps"
fi;
AC_MSG_RESULT($jpg_to_eps)
AC_SUBST(jpg_to_eps)
ifelse($#,0,[],$#,1,[
    if test "$jpg_to_eps" = "yes" ;
    then
        $1
    fi
],$#,2,[
    ifelse($1,[],[
        if test "$jpg_to_eps" = "no" ;
        then
            $2
        fi
    ],[
        if test "$jpg_to_eps" = "yes" ;
        then
            $1
        else
            $2
        fi
    ])
])
])
