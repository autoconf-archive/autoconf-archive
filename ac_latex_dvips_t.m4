# ===========================================================================
#            http://autoconf-archive.cryp.to/ac_latex_dvips_t.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Replaced by ACLTX_DVIPS_T.
#
# SYNOPSIS
#
#   AC_LATEX_DVIPS_T(<paper>,<var>) or AC_LATEX_DVIPS_T(<paper>,<var>,on|off)
#
# DESCRIPTION
#
#   This macro test if dvips -o ... -t <paper> works. When using the on
#   option, test if dvips -o ... -t <paper> -t landscape works. if it works,
#   set $var to yes, else $var="no"
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Boretti Mathieu <boretti@eig.unige.ch>
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

AC_DEFUN([AC_LATEX_DVIPS_T],[
AC_REQUIRE([AC_LATEX_CLASS_BOOK])
if test "$3" = "on" ;
then
_ac_latex_dvips_local=" -t landscape" ; export _ac_latex_dvips_local ;
else
_ac_latex_dvips_local=" " ; export _ac_latex_dvips_local ;
fi
AC_CACHE_CHECK([for option -t $1 $_ac_latex_dvips_local with dvips],[ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]),[
rm -rf .dvips
mkdir .dvips
cd .dvips
cat > test.tex << EOF
\documentclass{book}
\begin{document}
Test
\end{document}
EOF
$latex test.tex 1>/dev/null 2>&1
[ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_])="yes"; export [ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]);
$dvips -o test.ps test.dvi -t $1 $_ac_latex_dvips_local 2>&1 1>/dev/null | (grep "dvips: no match for papersize" 1>/dev/null 2>&1 && [ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_])="no"; export [ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]))
cd ..
])
$2=$[ac_cv_dvips_t_]translit($1,[-],[_])[_]translit($3,[-],[_]); export $2;
AC_SUBST($2)
])
