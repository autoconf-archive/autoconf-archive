# ===========================================================================
#          http://autoconf-archive.cryp.to/acltx_converting_fig.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_CONVERTING_FIG([ACTION-IF-FOUND[,ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   this macro find a way to convert .fig file to file that can be included
#   by latex and set convert_fig
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

AC_DEFUN([_ACLTX_FIG2DEV_FCT],[
AC_MSG_CHECKING([for $fig2dev -L $1 $2])
$3='no';
rm -rf conftest.dir/.acltx
AS_MKDIR_P([conftest.dir/.acltx])
cd conftest.dir/.acltx
cat > conftest.fig << \ACLEOF
#FIG 3.2
Landscape
Center
Inches
Letter
100.00
Single
-2
1200 2
4 0 0 50 -1 0 12 0.0000 6 135 435 150 450 TEST\001
ACLEOF
$fig2dev -L $1 $2 $4 conftest.fig conftest.eps 2>/dev/null 1>/dev/null && $3='yes';
cd ..
cd ..
sed 's/^/| /' conftest.dir/.acltx/conftest.fig >&5
echo "$as_me:$LINENO: executing $fig2dev -L $1 $2 $4 conftest.fig conftest.eps" >&5
rm -rf conftest.dir/.acltx
AC_MSG_RESULT([$]$3)
])


AC_DEFUN([ACLTX_CONVERTING_FIG],[
convert_fig="no";
ACLTX_PROG_FIG2DEV([AC_MSG_WARN([Unable to locate a fig2dev application to convert fig file])])
if test "$fig2dev" != "no" ; then
    _ACLTX_FIG2DEV_FCT(pstex,[],pstex)
    _ACLTX_FIG2DEV_FCT(pstex_t,[-p],pstex_t,conftest)

    AC_MSG_CHECKING(for a way to convert .fig file to .eps and _t file)
    if test "$pstex" = "yes" -a "$pstex_t" = "yes" ; then
        convert_fig="%.eps %_t : %.fig ; $fig2dev -L pstex \[$]< \[$]*.eps ; $fig2dev -L pstex_t -p \[$]* \[$]< \[$]*_t"
    fi
    AC_MSG_RESULT($convert_fig)
fi
AC_SUBST(convert_fig)
ifelse($#,0,[],$#,1,[
    if test "$convert_fig" != "no" ;
    then
        $1
    fi
],$#,2,[
    ifelse($1,[],[
        if test "$convert_fig" = "no" ;
        then
            $2
        fi
    ],[
        if test "$convert_fig" != "no" ;
        then
            $1
        else
            $2
        fi
    ])
])
])
