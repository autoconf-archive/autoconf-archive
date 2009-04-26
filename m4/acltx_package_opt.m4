# ===========================================================================
#           http://autoconf-archive.cryp.to/acltx_package_opt.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_PACKAGE_OPT(PACKAGENAME,CLASSNAME,VARIABLETOSET,PARAMETER[,ACTION-IF-FOUND[,ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   This package do the same thing as ACLTX_PACKAGE, except, that PARAMETER
#   is optional parameter for the package
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

define(_ACLTX_PACKAGE_OPT_INTERNE,[
changequote(*, !)dnl
\documentclass{$2}
\usepackage[$3]{$1}
\begin{document}
\end{document}
changequote([, ])dnl

])

AC_DEFUN([ACLTX_PACKAGE_OPT],[
ACLTX_PACKAGE_LOCATION($1.sty,$3_location)
if test "[$]$3_location" = "no" ; then
    AC_MSG_WARN([Unable to locate the $1.sty file])
    [ac_cv_latex_]translit($1,[-],[_])[_]translit($2,[-],[_])[_]translit([$4],[-,{}()= ],[________])="no";
else
if test "$[ac_cv_latex_class_]translit($2,[-],[_])" = "" ;
then
	ACLTX_CLASS($2,boretti_classesansparametre)
	export boretti_classesansparametre;
else
	boretti_classesansparametre=$[ac_cv_latex_class_]translit($2,[-],[_]) ;
	export boretti_classesansparemetre;
fi;
if test $boretti_classesansparametre = "no" ;
then
    AC_MSG_ERROR([Unable to find $1 class])
fi
AC_CACHE_CHECK([for usability of package $1 in class $2 with $4 as option],[ac_cv_latex_]translit($1,[-],[_])[_]translit($2,[-],[_])[_]translit([$4],[-,{}()= ],[________]),[
_ACLTX_TEST([
_ACLTX_PACKAGE_OPT_INTERNE($1,$2,[$4])
],[ac_cv_latex_]translit($1,[-],[_])[_]translit($2,[-],[_])[_]translit([$4],[-,{}()= ],[________]))
])
fi
$3=$[ac_cv_latex_]translit($1,[-],[_])[_]translit($2,[-],[_])[_]translit([$4],[-,{}()= ],[________]); export $3;
AC_SUBST($3)
ifelse($#,4,[],$#,5,[
    if test "[$]$3" = "yes" ;
    then
        $5
    fi
],$#,6,[
    ifelse($5,[],[
        if test "[$]$3" = "no" ;
        then
            $6
        fi
    ],[
        if test "[$]$3" = "yes" ;
        then
            $5
        else
            $6
        fi
    ])
])
])
