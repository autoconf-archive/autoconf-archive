# ===========================================================================
#    http://autoconf-archive.cryp.to/acltx_package_listings_language.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_PACKAGE_LISTINGS_LANGUAGE(LANGUAGE,VARIABLETOSET)
#
# DESCRIPTION
#
#   Test if the package listings accept the language LANGUAGE and set
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

define(_ACLTX_PACKAGE_LANGUAGE_INTERNE,[
changequote(*, !)dnl
\documentclass{$defaultclass}
\usepackage{listings}
\lstset{language={$1}}
\begin{document}
\end{document}
changequote([, ])dnl
])

AC_DEFUN([ACLTX_PACKAGE_LISTINGS_LANGUAGE],[
AC_REQUIRE([ACLTX_PACKAGE_LISTINGS])
AC_CACHE_CHECK([for $1 language in package listings with class book],[ac_cv_latex_listings_langugae_]translit($1,[-],[_]),[
_ACLTX_TEST([
_ACLTX_PACKAGE_LANGUAGE_INTERNE($1)
],[ac_cv_latex_listings_langugae_]translit($1,[-],[_]))
])
$2=$[ac_cv_latex_listings_langugae_]translit($1,[-],[_]); export $2;
AC_SUBST($2)
])
