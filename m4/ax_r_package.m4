# ===========================================================================
#       https://www.gnu.org/software/autoconf-archive/ax_r_package.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_R_PACKAGE(pkgname[, version, R])
#
# DESCRIPTION
#
#   Checks for an R package.
#
#   Optionally checks for the version when a second argument is given. A
#   different R can be used by providing a third argument.
#
# BUGS
#
#   (1) The presence test passes is.na(packageDescription(...)) directly to
#   if. For an installed package this is a logical vector with several
#   elements, and since R 4.2.0, R rejects such a condition with "the
#   condition has length > 1". Installed packages are therefore reported as
#   missing. [Rating: broken]
#
#   (2) Private shell variables such as TEST lack an ax_ prefix. They share
#   configure's shell namespace with callers and other macros, so they may
#   collide with variables of the same name. These variables should use
#   macro-specific ax_ names. [Rating: minor]
#
# LICENSE
#
#   Copyright (c) 2017, 2022 Ricardo Wurmus
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 6

AC_DEFUN([AX_R_PACKAGE], [
    pushdef([PKG],$1)
    pushdef([VERSION],$2)

    if test -z $R;
    then
        if test -z "$3";
        then
            R="R"
        else
            R="$3"
        fi
    fi

    AC_MSG_CHECKING([R package PKG VERSION])

    TEST=$( $R --silent --vanilla -e 'if(is.na(packageDescription("PKG"))) stop("not found")' 2>/dev/null )
    AS_IF([test $? -eq 0], [], [
      AC_MSG_RESULT([no])
      AC_MSG_ERROR([R package PKG not found.])
    ])

    if test -n "VERSION"
    then
      TEST=$( $R --silent --vanilla -e 'if(compareVersion(packageDescription("PKG")$Version, "VERSION") < 0) { stop("not found") }' 2>/dev/null )
      AS_IF([test $? -eq 0], [], [
        AC_MSG_RESULT([no])
        AC_MSG_ERROR([You need at least version VERSION of the R package PKG.])
      ])
    fi

    AC_MSG_RESULT(yes)
    popdef([PKG])
    popdef([VERSION])
])
