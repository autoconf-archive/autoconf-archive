# ===========================================================================
#        http://autoconf-archive.cryp.to/ac_latex_package_amsmath.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Replaced by ACLTX_PACKAGE_AMSMATH.
#
# SYNOPSIS
#
#   AC_LATEX_PACKAGE_AMSMATH
#
# DESCRIPTION
#
#   This macro test if \usepackage{amsmath,amsfonts} works. If yes, it set
#   $amsmath="\usepackage{amsmath,amsfonts}" Else if \usepackage{amstex}
#   works, set $amsmath="\usepackage{amstex}" else ERROR
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Mathieu Boretti <boretti@eig.unige.ch>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 2 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Macro Archive. When you make and
#   distribute a modified version of the Autoconf Macro, you may extend this
#   special exception to the GPL to apply to your modified version as well.

AC_DEFUN([AC_LATEX_PACKAGE_AMSMATH],[
AC_LATEX_CLASS_BOOK
AC_CACHE_CHECK([for amsmath],[ac_cv_latex_package_f_amsmath],[
_AC_LATEX_TEST([
\documentclass{book}
\usepackage{amsmath,amsfonts}
\begin{document}
\end{document}
],[ac_cv_latex_package_f_amsmath])
if test $ac_cv_latex_package_f_amsmath = "yes" ;
then
    [ac_cv_latex_package_f_amsmath]="\\usepackage{amsmath,amsfonts}" ; export [ac_cv_latex_package_f_amsmath] ;
else
    _AC_LATEX_TEST([
    \documentclass{book}
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
