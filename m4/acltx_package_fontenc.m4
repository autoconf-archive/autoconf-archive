# ===========================================================================
#         http://autoconf-archive.cryp.to/acltx_package_fontenc.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_PACKAGE_FONTENC([ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   Check if the package fontenc exists and try to use T1 or OT1 and set
#   fontenc to T1, OT1 or no
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

define(_ACLTX_PACKAGE_FONTENC_INTERNE,[changequote(*, !)dnl
\documentclass{$defaultclass}
\usepackage[$1]{fontenc}
\begin{document}
\end{document}dnl
changequote([, ])])

AC_DEFUN([ACLTX_PACKAGE_FONTENC],[
    AC_REQUIRE([ACLTX_DEFAULT_CLASS])
    ACLTX_PACKAGE_LOCATION(fontenc.sty,fontenc_location)
    AC_CACHE_CHECK([for fontenc],[ac_cv_latex_package_fontenc_opt],[
        _ACLTX_TEST([_ACLTX_PACKAGE_FONTENC_INTERNE(T1)],[ac_cv_latex_package_fontenc_opt])
        if test $ac_cv_latex_package_fontenc_opt = "yes" ;
        then
            ac_cv_latex_package_fontenc_opt="T1"; export ac_cv_latex_package_fontenc_opt;
        else
            _ACLTX_TEST([_ACLTX_PACKAGE_FONTENC_INTERNE(OT1)],[ac_cv_latex_package_fontenc_opt])
            if test $ac_cv_latex_package_fontenc_opt = "yes" ;
            then
                ac_cv_latex_package_fontenc_opt="OT1"; export ac_cv_latex_package_fontenc_opt;
            fi
        fi

    ])
    if test $ac_cv_latex_package_fontenc_opt = "no" ;
    then
        m4_ifval([$1],$1,[AC_MSG_ERROR([Unable to use fontenc with T1 nor OT1])])
    fi
    fontenc=$ac_cv_latex_package_fontenc_opt ; export fontenc ;
    AC_SUBST(fontenc)
])
