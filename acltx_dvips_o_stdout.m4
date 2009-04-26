# ===========================================================================
#          http://autoconf-archive.cryp.to/acltx_dvips_o_stdout.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_DVIPS_O_STDOUT
#
# DESCRIPTION
#
#   Check if dvips accept "-o-".
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

AC_DEFUN([ACLTX_DVIPS_O_STDOUT],[
AC_REQUIRE([ACLTX_DEFAULT_CLASS])
AC_REQUIRE([ACLTX_PROG_DVIPS])
AC_CACHE_CHECK([for option -o- in dvips],ac_cv_dvips_o_stdout,[
_ACLTX_TEST([\documentclass{$defaultclass}
\begin{document}
Test
\end{document}],[],no)
cd conftest.dir/.acltx
ac_cv_dvips_o_stdout="no"; export ac_cv_dvips_o_stdout;
$dvips -o- texput.dvi   1>/dev/null 2>&1 && ac_cv_dvips_o_stdout="yes"; export ac_cv_dvips_o_stdout
cd ..
cd ..
echo "$as_me:$LINENO: executing $dvips -o- texput.dvi" >&5
rm -rf conftest.dir/.acltx
])
DVIPS_O_STDOUT=$ac_cv_dvips_o_stdout; export DVIPS_O_STDOUT;
if test $DVIPS_O_STDOUT = "no" ;
then
    AC_MSG_ERROR(Unable to find the option -o- in dvips)
fi
AC_SUBST(DVIPS_O_STDOUT)
])
