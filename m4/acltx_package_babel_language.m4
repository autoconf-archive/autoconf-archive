# ===========================================================================
#      http://autoconf-archive.cryp.to/acltx_package_babel_language.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_PACKAGE_BABEL_LANGUAGE(LANGUAGES,VARIABLETOSET[ACTION-IF-FOUND[,ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   Check if the package babel exists and support language and set
#   VARIABLETOSET to yes or no
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

AC_DEFUN([ACLTX_PACKAGE_BABEL_LANGUAGE],[
ACLTX_PACKAGE_BABEL([],[AC_MSG_WARN([Unable to locate babel with $defaultclass])])
AC_CACHE_CHECK([for babel with class $defaultclass and language $1],[ac_cv_latex_babel_langugage_]translit([$1],[-,{}()= ],[________]),[
_ACLTX_TEST([changequote(*, !)dnl
\documentclass{$defaultclass}
\usepackage[$1]{babel}
\begin{document}
\end{document}dnl
changequote([, ])],[ac_cv_latex_babel_langugage_]translit([$1],[-,{}()= ],[________]))
])
$2=$[ac_cv_latex_babel_langugage_]translit([$1],[-,{}()= ],[________]); export $2;
AC_SUBST($2)
ifelse($#,2,[],$#,3,[
    if test "[$]$2" != "no" ;
    then
        $3
    fi
],$#,4,[
    ifelse($3,[],[
        if test "[$]$2" = "no" ;
        then
            $4
        fi
    ],[
        if test "[$]$2" != "no" ;
        then
            $3
        else
            $4
        fi
    ])
])
])
