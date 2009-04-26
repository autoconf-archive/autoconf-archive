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
#   cweave to insert some boilerplate. Both macros for the original CWEB and
#   the compatible offshoot CWEBx are tested here. See
#   http://www.ctan.org/tex-archive/help/Catalogue/entries/cweb-latex.html.
#
# LICENSE
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
ACLTX_PACKAGE_LOCATION(cweb.cls,ac_cv_latex_class_cweb_location)
if test "[$]ac_cv_latex_class_cweb_location" = "no" ; then
    AC_MSG_WARN([Unable to locate the cweb.cls file])
    ac_cv_latex_class_cweb="no";
else
    AC_CACHE_CHECK(
        [for usability of class cweb with Levy/Knuth CWEB],
        [ac_cv_latex_class_cweb_CWEB],[
        _ACLTX_TEST([
        \input cwebmac
        \documentclass{cweb}
        \begin{document}
        \M{1}
        \end{document}
        \fi
        \fin
        ], [ac_cv_latex_class_cweb_CWEB])
    ])
    AC_CACHE_CHECK(
        [for usability of class cweb with van Leeuwen CWEBx],
        [ac_cv_latex_class_cweb_CWEBx],[
        _ACLTX_TEST([
        \input cwebcmac
        \documentclass{cweb}
        \begin{document}
        \M{1}
        \end{document}
        \fi
        \fin
        ],[ac_cv_latex_class_cweb_CWEBx])
    ])
    ac_cv_latex_class_cweb=no
    if test "$ac_cv_latex_class_cweb_CWEB" = yes; then
        ac_cv_latex_class_cweb=yes
    fi
    if test "$ac_cv_latex_class_cweb_CWEBx" = yes; then
        ac_cv_latex_class_cweb=yes
    fi
fi

$1=$[ac_cv_latex_class_cweb] ; export $1
AC_SUBST($1)

if test "$[ac_cv_latex_class_cweb]" = yes ; then
    dnl NOP required
    :
    ifelse([$2], , ,[$2])
else
    dnl NOP required
    :
    ifelse([$3], , ,[$3])
fi
])
