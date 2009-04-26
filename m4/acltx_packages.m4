# ===========================================================================
#             http://autoconf-archive.cryp.to/acltx_packages.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_PACKAGES(PACKAGESNAMES,CLASSNAME,VARIABLETOSET[,ACTION-IF-FOUND[,ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   This package search for the first suitable package in PACKAGESNAMES
#   (comma separated list) with class CLASSNAME and set VARIABLETOSET the
#   package found or to no
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

define(_ACLTX_PACKAGE_INTERNE,[
	ifelse($#,0,[],$#,1,[],$#,2,[],$#,3,[
		ACLTX_PACKAGE($3,$2,$1)
	],[
		ACLTX_PACKAGE($3,$2,$1)
		if test "$$1" = "yes";
		then
			$1=$3 ; export $1 ;
		else
			_ACLTX_PACKAGE_INTERNE($1,$2,m4_shift(m4_shift(m4_shift($@))))
		fi;
	])
])

AC_DEFUN([ACLTX_PACKAGES],[
	_ACLTX_PACKAGE_INTERNE($3,$2,$1)
	AC_SUBST($3)
ifelse($#,3,[],$#,4,[
    if test "[$]$3" != "no" ;
    then
        $4
    fi
],$#,5,[
    ifelse($4,[],[
        if test "[$]$3" = "no" ;
        then
            $5
        fi
    ],[
        if test "[$]$3" != "no" ;
        then
            $4
        else
            $5
        fi
    ])
])
])
