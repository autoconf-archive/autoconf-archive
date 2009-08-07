# ===========================================================================
#    http://www.nongnu.org/autoconf-archive/ax_latex_package_listings.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_LATEX_PACKAGE_LISTINGS
#
# DESCRIPTION
#
#   Check if the package listings exists and set listings to yes or no
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

AC_DEFUN([AX_LATEX_PACKAGE_LISTINGS],[
    AC_REQUIRE([AX_LATEX_DEFAULT_CLASS])
AC_CACHE_CHECK([for listings with class $defaultclass],[ac_cv_latex_package_f_listings],[
_AX_LATEX_TEST([changequote(*, !)dnl
\documentclass{$defaultclass}
\usepackage{listings}
\begin{document}
\end{document}dnl
changequote([, ])],[ac_cv_latex_package_f_listings])
])
listings=$[ac_cv_latex_package_f_listings]; export listings;
AC_SUBST(listings)

])
