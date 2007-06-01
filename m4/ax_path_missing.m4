##### http://autoconf-archive.cryp.to/ax_path_missing.html
#
# SYNOPSIS
#
#   AX_PATH_MISSING(variable, prog-to-check-for, warning-if-not-found, path)
#
# DESCRIPTION
#
#   Check whether program prog-to-check-for exists in path. If it is
#   found, set variable to the full path of prog-to-check-for,
#   otherwise warn warning-if-not-found and set variable to the full
#   path of the Automake missing script with prog-to-check-for as the
#   command to run.
#
# LAST MODIFICATION
#
#   2007-06-01
#
# COPYLEFT
#
#   Copyright (c) 2007 Noah Slater <nslater@bytesexual.org>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AX_PATH_MISSING], [
    AC_PATH_PROG([$1], [$2], [$4])
    if test x${$1} = x; then
        AC_MSG_WARN([$3])
        AC_SUBST([$1], [${am_missing_run}[$2]])
    fi
])
