##### http://autoconf-archive.cryp.to/ax_split_version.html
#
# SYNOPSIS
#
#   AX_SPLIT_VERSION
#
# DESCRIPTION
#
#   Splits a version number in the format MAJOR.MINOR.POINT into it's
#   separeate components.
#
#   Sets the variables.
#
# LAST MODIFICATION
#
#   2005-01-14
#
# COPYLEFT
#
#   Copyright (c) 2005 Tom Howard <tomhoward@users.sf.net>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AX_SPLIT_VERSION],[
    AX_MAJOR_VERSION=`echo "$VERSION" | $SED 's/\([[^.]][[^.]]*\).*/\1/'`
    AX_MINOR_VERSION=`echo "$VERSION" | $SED 's/[[^.]][[^.]]*.\([[^.]][[^.]]*\).*/\1/'`
    AX_POINT_VERSION=`echo "$VERSION" | $SED 's/[[^.]][[^.]]*.[[^.]][[^.]]*.\(.*\)/\1/'`
    AC_MSG_CHECKING([Major version])
    AC_MSG_RESULT([$AX_MAJOR_VERSION])
    AC_MSG_CHECKING([Minor version])
    AC_MSG_RESULT([$AX_MINOR_VERSION])
    AC_MSG_CHECKING([Point version])
    AC_MSG_RESULT([$AX_POINT_VERSION])
])
