##### http://autoconf-archive.cryp.to/acltx_dvips_t_letter.html
#
# SYNOPSIS
#
#   ACLTX_DVIPS_T_LETTER
#
# DESCRIPTION
#
#   Check if dvips accept "-t letter".
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

AC_DEFUN([AC_LATEX_DVIPS_T_LETTER],[
ACLTX_DVIPS_T(letter,dvips_t_letter)
if test $dvips_t_letter = "no";
then
    AC_MSG_ERROR([Unable to find the -t letter option in dvips])
fi
])
