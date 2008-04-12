# ===========================================================================
#             http://autoconf-archive.cryp.to/ac_prog_bibtex.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Replaced by ACLTX_PROG_BIBTEX.
#
# SYNOPSIS
#
#   AC_PROG_BIBTEX
#
# DESCRIPTION
#
#   This macro test if bibtex is installed. If bibtex is installed, it set
#   $bibtex to the right value
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

AC_DEFUN([AC_PROG_BIBTEX],[
AC_CHECK_PROGS(bibtex,bibtex,no)
export bibtex;
if test $bibtex = "no" ;
then
	AC_MSG_ERROR([Unable to find a BiTex application]);
fi
AC_SUBST(bibtex)
])
