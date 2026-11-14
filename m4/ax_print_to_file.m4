# ===========================================================================
#     https://www.gnu.org/software/autoconf-archive/ax_print_to_file.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_PRINT_TO_FILE([FILE],[DATA])
#
# DESCRIPTION
#
#   Writes the specified data to the specified file.
#
# BUGS
#
#   DATA is used as the printf format string. Backslash escapes are
#   interpreted deliberately, since AX_FILE_ESCAPES relies on this, but
#   percent signs are interpreted as well: "100% complete" is written as
#   "100 omplete". Write % as %% to avoid this. [Rating: major]
#
# LICENSE
#
#   Copyright (c) 2008 Tom Howard <tomhoward@users.sf.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 9

AC_DEFUN([AX_PRINT_TO_FILE],[
AC_REQUIRE([AX_FILE_ESCAPES])
printf "$2" > "$1"
])
