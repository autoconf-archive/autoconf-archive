# ===========================================================================
#         http://autoconf-archive.cryp.to/acltx_package_amsmath.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_PACKAGE_AMSMATH
#
# DESCRIPTION
#
#   This macro check for a way to include amsmath and set amsmath to this
#   way
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

AC_DEFUN([ACLTX_PACKAGE_AMSMATH],[
AC_REQUIRE([ACLTX_DEFAULT_CLASS])
AC_CACHE_CHECK([for amsmath],[ac_cv_latex_package_f_amsmath],[
_ACLTX_TEST([\documentclass{$defaultclass}
\usepackage{amsmath,amsfonts}
\begin{document}
\end{document}],[ac_cv_latex_package_f_amsmath])
if test $ac_cv_latex_package_f_amsmath = "yes" ;
then
    [ac_cv_latex_package_f_amsmath]="\\usepackage{amsmath,amsfonts}" ; export [ac_cv_latex_package_f_amsmath] ;
else
    _ACLTX_TEST([
    \documentclass{$defaultclass}
    \usepackage{amstex}
    \begin{document}
    \end{document}
    ],[ac_cv_latex_package_f_amsmath])
    if test $ac_cv_latex_package_f_amsmath = "yes" ;
    then
        [ac_cv_latex_package_f_amsmath]="\\usepackage{amstex}" ; export [ac_cv_latex_package_f_amsmath] ;
    else
        AC_MSG_ERROR([Unable to find amsmath])
    fi
fi
])
amsmath=$[ac_cv_latex_package_f_amsmath]; export amsmath;
AC_SUBST(amsmath)
])
