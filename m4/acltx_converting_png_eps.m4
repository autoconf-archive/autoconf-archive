# ===========================================================================
#        http://autoconf-archive.cryp.to/acltx_converting_png_eps.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_CONVERTING_PNG_EPS([ACTION-IF-FOUND[,ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   This macro find a way to convert png to eps file. If the way is found,
#   set png_to_eps to this way else set png_to_eps to no.
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

AC_DEFUN([ACLTX_CONVERTING_PNG_EPS],[
ACLTX_PROG_PNGTOPNM([AC_MSG_WARN([Unable to locate a pngtopnm application to convert png file])])
ACLTX_PROG_PNMTOPS([AC_MSG_WARN([Unable to locate a pnmtops application to convert png file])])
AC_MSG_CHECKING(for a way to convert png file to eps file)
png_to_eps='no'; export png_to_eps;
if test "$pngtopnm" != "no" -a "$pnmtops" != "no" ; then
    png_to_eps="%.eps : %.png ; $pngtopnm \[$]*.png | pnmtops -noturn -nocenter -scale 1.00 - >\[$]*.eps"
fi;
AC_MSG_RESULT($png_to_eps)
AC_SUBST(png_to_eps)
ifelse($#,0,[],$#,1,[
    if test "$png_to_eps" = "yes" ;
    then
        $1
    fi
],$#,2,[
    ifelse($1,[],[
        if test "$png_to_eps" = "no" ;
        then
            $2
        fi
    ],[
        if test "$png_to_eps" = "yes" ;
        then
            $1
        else
            $2
        fi
    ])
])
])
