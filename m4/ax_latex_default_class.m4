# ===========================================================================
#     http://www.nongnu.org/autoconf-archive/ax_latex_default_class.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Deprecated because of licensing issues. The Lesser GPL imposes licensing
#   restrictions on the generated configure script unless it is augmented
#   with an Autoconf Exception clause.
#
# SYNOPSIS
#
#   AX_LATEX_DEFAULT_CLASS([OTHER-DEFAULT-CLASS])
#
# DESCRIPTION
#
#   This class search for the first suitable class in book report article
#   and set defaultclass to this value If no one of this classes are found,
#   fail
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

AC_DEFUN([AX_LATEX_DEFAULT_CLASS],[
    if test "$ax_latex_cv_latex_class_default" = "" ; then
        AX_LATEX_CLASSES([m4_ifval([$1],[$1,])book,report,article],defaultclass)
    fi
    AC_MSG_CHECKING([for a default class in m4_ifval([$1],[$1,])book,report,article])
    AC_CACHE_VAL(ax_latex_cv_latex_class_default,[
        ax_latex_cv_latex_class_default=$defaultclass;
    ])
    AC_MSG_RESULT($defaultclass)
    AC_SUBST(defaultclass)
    if test "$defaultclass" = "no" ; then
        AC_MSG_ERROR([Unable to locate a default class])
    fi
])
