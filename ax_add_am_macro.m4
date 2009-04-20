# ===========================================================================
#            http://autoconf-archive.cryp.to/ax_add_am_macro.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_ADD_AM_MACRO([RULE])
#
# DESCRIPTION
#
#   Adds the specified rule to $AMINCLUDE. This macro will only work
#   properly with implementations of Make which allow include statements.
#   See also AX_ADD_AM_MACRO_STATIC.
#
# LAST MODIFICATION
#
#   2009-04-20
#
# COPYLEFT
#
#   Copyright (c) 2009 Tom Howard <tomhoward@users.sf.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AX_ADD_AM_MACRO],[
  AC_REQUIRE([AX_AM_MACROS])
  AX_APPEND_TO_FILE([$AMINCLUDE],[$1])
])
