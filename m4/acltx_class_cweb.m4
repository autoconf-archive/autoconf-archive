# ===========================================================================
#            http://autoconf-archive.cryp.to/acltx_class_cweb.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_CLASS_CWEB(VARIABLETOSET[,ACTION-IF-FOUND[,ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   This macros test if the class cweb exists and works. It sets
#   VARIABLETOSET to yes or no If ACTION-IF-FOUND (and ACTION-IF-NOT-FOUND)
#   are set, do the correct action.
#
#   The cweb package is used to provide LaTeX support atop Knuth's CWEB
#   literate programming environment. The test LaTeX document requires some
#   additional logic beyond ACLTX_CLASS because the cweb package expects
#   cweave to insert some boilerplate. See
#   http://www.ctan.org/tex-archive/help/Catalogue/entries/cweb-latex.html.
#
# LAST MODIFICATION
#
#   2008-08-03
#
# COPYLEFT
#
#   Copyright (c) 2008 Rhys Ulerich <rhys.ulerich@gmail.com>
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

AC_DEFUN([ACLTX_CLASS_CWEB],[
ACLTX_PACKAGE_LOCATION(cweb.cls,$1_location)
if test "[$]$1_location" = "no" ; then
    AC_MSG_WARN([Unable to locate the cweb.cls file])
    [ac_cv_latex_class_]translit(cweb,[-],[_])="no";
else
AC_CACHE_CHECK([for usability of class cweb],[ac_cv_latex_class_]translit(cweb,[-],[_]),[
_ACLTX_TEST([
\input cwebmac
\documentclass{cweb}
\begin{document}
\M{1}
\end{document}
\fi
\fin
],[ac_cv_latex_class_]translit(cweb,[-],[_]))
])
fi
$1=$[ac_cv_latex_class_]translit(cweb,[-],[_]) ; export $1;
AC_SUBST($1)
ifelse($#,1,[],$#,2,[
    if test "[$]$1" = "yes" ;
    then
        $2
    fi
],$#,4,[
    ifelse($2,[],[
        if test "[$]$1" = "no" ;
        then
            $3
        fi
    ],[
        if test "[$]$1" = "yes" ;
        then
            $2
        else
            $3
        fi
    ])
])
