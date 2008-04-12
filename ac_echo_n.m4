# ===========================================================================
#               http://autoconf-archive.cryp.to/ac_echo_n.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Use the pre-defined $ECHO_N variable.
#
# SYNOPSIS
#
#   AC_ECHO_N(PATH)
#
# DESCRIPTION
#
#   this is somewhat like the macro _AC_ECHO_N from autoconf 2.4x defined
#   here for use in autoconf 2.1x, add the _ when you use 2.4x
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
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

# _AC_ECHO_N(STRING, [FD = AS_MESSAGE_FD])
# ------------------------------------
# Same as _AS_ECHO, but echo doesn't return to a new line.
AC_DEFUN([AC_ECHO_N],[dnl
[echo $ac_n "$1""$ac_c" >&AC_FD_MSG])
