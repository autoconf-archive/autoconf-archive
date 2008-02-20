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
#   A typical use is the following:
#
#     AX_PATH_MISSING([AUTOGEN],[autogen],[autogen seems missing ...])
#
#   This macro is the combination of AC_PATH_PROG and AX_MISSING_PROG.
#   If you do not want to run AC_PATH_PROG, simply use AX_MISSING_PROG
#   or AM_MISSING.
#
# LAST MODIFICATION
#
#   2007-11-28
#
# COPYLEFT
#
#   Copyright (c) 2007 Noah Slater <nslater@bytesexual.org>
#   Copyright (c) 2007 Francesco Salvestrini <salvestrini@sourceforge.net>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AX_PATH_MISSING], [
    AC_PATH_PROG([$1], [$2], [$4])
    AS_IF([ test -z "${$1}" ],[
        AX_MISSING_PROG([$1],[$2],[$3])
    ])
])
