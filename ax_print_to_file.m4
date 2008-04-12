# ===========================================================================
#            http://autoconf-archive.cryp.to/ax_print_to_file.html
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
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Tom Howard <tomhoward@users.sf.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AX_PRINT_TO_FILE],[
AC_REQUIRE([AX_FILE_ESCAPES])
printf "$2" > "$1"
])
