# ===========================================================================
#         http://autoconf-archive.cryp.to/acltx_package_location.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_PACKAGE_LOCATION(FILENAME,VARIABLETOSET)
#
# DESCRIPTION
#
#   Find the file FILENAME in the acces path of texmf and set VARIABLETOSET
#   to the location or no if not found
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

AC_DEFUN([ACLTX_PACKAGE_LOCATION],[
AC_REQUIRE([ACLTX_PROG_KPSEWHICH])
AC_CACHE_CHECK([for location of $1],[ac_cv_latex_location_]translit($1,[-.],[__]),[
[ac_cv_latex_location_]translit($1,[-.],[__])=`$kpsewhich $1`; export [ac_cv_latex_location_]translit($1,[-.],[__]);
if test "[ac_cv_latex_location_]translit($1,[-.],[__])" = "";
then
    [ac_cv_latex_location_]translit($1,[-.],[__])="no"; export [ac_cv_latex_location_]translit($1,[-.],[__]);
fi
echo "$as_me:$LINENO: executing $kpsewhich $1" >&5
])
$2=$[ac_cv_latex_location_]translit($1,[-.],[__]); export $2;
AC_SUBST($2)
])
