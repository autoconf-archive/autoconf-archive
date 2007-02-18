##### http://autoconf-archive.cryp.to/acltx_classes.html
#
# SYNOPSIS
#
#   ACLTX_CLASSES(CLASSESNAMES,VARIABLETOSET[,ACTION-IF-FOUND[,ACTION-IF-NOT-FOUND]])
#
# DESCRIPTION
#
#   This class search for the first suitable package in CLASSESNAMES
#   (comma separated list) and set VARIABLETOSET to the class found or
#   to no
#
# LAST MODIFICATION
#
#   2006-07-16
#
# COPYLEFT
#
#   Copyright (c) 2006 Boretti Mathieu <boretti@eig.unige.ch>
#
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU Lesser General Public License
#   as published by the Free Software Foundation; either version 2.1 of
#   the License, or (at your option) any later version.
#
#   This library is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public
#   License along with this library; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
#   02110-1301 USA

define(_ACLTX_CLASSES_INTERNE,[
	ifelse($#,1,[],$#,2,[
		ACLTX_CLASS($2,$1)
	],[
		ACLTX_CLASS($2,$1)
		if test "$$1" = "yes";
		then
			$1=$2 ; export $1 ;
		else
			_ACLTX_CLASSES_INTERNE($1,m4_shift(m4_shift($@)))
		fi;
	])
])

AC_DEFUN([ACLTX_CLASSES],[
	_ACLTX_CLASSES_INTERNE($2,$1)
	AC_SUBST($2)
ifelse($#,2,[],$#,3,[
    if test "[$]$2" != "no" ;
    then
        $3
    fi
],$#,4,[
    ifelse($3,[],[
        if test "[$]$2" = "no" ;
        then
            $4
        fi
    ],[
        if test "[$]$2" != "no" ;
        then
            $3
        else
            $4
        fi
    ])
])
])
