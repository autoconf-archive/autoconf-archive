# ===========================================================================
#           http://autoconf-archive.cryp.to/ac_latex_packages.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Replaced by ACLTX_PACKAGES.
#
# SYNOPSIS
#
#   AC_LATEX_PACKAGES([<package1>,<package2>,<package3>],<class>,<variable>)
#
# DESCRIPTION
#
#   This macro test if package1 in <class> exists and if not package2 and so
#   and set <variable> to the right value
#
#    AC_LATEX_PACKAGES([allo,varioref,bonjour],book,vbook)
#    should set $vbook="varioref"
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

define(_AC_LATEX_PACKAGE_INTERNE,[
	ifelse($#,0,[],$#,1,[],$#,2,[],$#,3,[
		AC_LATEX_PACKAGE($3,$2,$1)
	],[
		AC_LATEX_PACKAGE($3,$2,$1)
		if test "$$1" = "yes";
		then
			$1=$3 ; export $1 ;
		else
			_AC_LATEX_PACKAGE_INTERNE($1,$2,m4_shift(m4_shift(m4_shift($@))))
		fi;
	])
])

AC_DEFUN([AC_LATEX_PACKAGES],[
	_AC_LATEX_PACKAGE_INTERNE($3,$2,$1)
	AC_SUBST($3)
])
