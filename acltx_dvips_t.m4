# ===========================================================================
#             http://autoconf-archive.cryp.to/acltx_dvips_t.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_DVIPS_T(PAPERSIZE,VARIABLETOSET,[LANDSCAPE])
#
# DESCRIPTION
#
#   Check if dvips accept the PAPERSIZE option with optional LANDSCAPE and
#   set VARIABLETOSET to yes or no.
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

AC_DEFUN([ACLTX_DVIPS_T],[
AC_REQUIRE([ACLTX_DEFAULT_CLASS])
AC_REQUIRE([ACLTX_PROG_DVIPS])
if test "$3" = "on" ;
then
_ac_latex_dvips_local=" -t landscape" ; export _ac_latex_dvips_local ;
else
_ac_latex_dvips_local=" " ; export _ac_latex_dvips_local ;
fi
AC_CACHE_CHECK([for option $dvips -t $1 $_ac_latex_dvips_local],[ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]),[
_ACLTX_TEST([\documentclass{$defaultclass}
\begin{document}
Test
\end{document}],[],no)
cd conftest.dir/.acltx
[ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_])="no"; export [ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]);
$dvips -o conftest.ps texput.dvi -t $1 $_ac_latex_dvips_local 2>error 1>/dev/null
cat error | grep "dvips: no match for papersize" 1>/dev/null 2>&1 || [ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_])="yes"; export [ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_])
cd ..
cd ..
echo "$as_me:$LINENO: executing $dvips -o conftest.ps texput.dvi -t $1 $_ac_latex_dvips_local" >&5
sed 's/^/| /' conftest.dir/.acltx/error >&5
rm -rf conftest.dir/.acltx
])
$2=$[ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]); export $2;
AC_SUBST($2)
])
