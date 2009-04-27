# ===========================================================================
#          http://autoconf-archive.cryp.to/acltx_package_input.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_PACKAGE_INPUT(PACKAGENAME,CLASSNAME,VARIABLETOSET)
#
# DESCRIPTION
#
#   This macro test if package in <class> exists and set <variable> to the
#   right value (yes or no). Use \input instance of \usepackage.
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

AC_DEFUN([ACLTX_PACKAGE_INPUT],[
ACLTX_PACKAGE_LOCATION($1,$3_location)
if test "[$]$3_location" = "no" ; then
    AC_MSG_WARN([Unable to locate the $1.sty file])
    [ac_cv_latex_i_]translit($1,[-.],[__])[_]translit($2,[-],[_])="no";
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
    AC_MSG_ERROR([Unable to find $2 class])
fi
AC_CACHE_CHECK([for usability of package $1 in class $2, using \\input instance of \\usepackage],[ac_cv_latex_i_]translit($1,[-.],[__])[_]translit($2,[-],[_]),[
_ACLTX_TEST([
\documentclass{$2}
\input $1
\begin{document}
\end{document}
],[ac_cv_latex_i_]translit($1,[-.],[__])[_]translit($2,[-],[_]))
])
fi
$3=$[ac_cv_latex_i_]translit($1,[-.],[__])[_]translit($2,[-],[_]); export $3;
AC_SUBST($3)
])
