# ===========================================================================
#       https://www.gnu.org/software/autoconf-archive/ax_lib_mysql.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_LIB_MYSQL([MINIMUM-VERSION])
#
# DESCRIPTION
#
#   This macro provides tests of availability of MySQL client library of
#   particular version or newer.
#
#   AX_LIB_MYSQL macro takes only one argument which is optional. If there
#   is no required version passed, then macro does not run version test.
#
#   The --with-mysql option takes one of three possible values:
#
#   no - do not check for MySQL client library
#
#   yes - do check for MySQL library in standard locations (mysql_config
#   should be in the PATH)
#
#   path - complete path to mysql_config utility, use this option if
#   mysql_config can't be found in the PATH
#
#   This macro calls:
#
#     AC_SUBST(MYSQL_CFLAGS)
#     AC_SUBST(MYSQL_LDFLAGS)
#     AC_SUBST(MYSQL_VERSION)
#
#   And sets:
#
#     HAVE_MYSQL
#
# BUGS
#
#   (1) A failed MINIMUM-VERSION comparison only prints no. It does not
#   reset found_mysql or prevent HAVE_MYSQL from being defined, so an
#   installed client older than requested is still accepted. [Rating: major]
#
#   (2) Private shell variables such as mysql_version_check and
#   mysql_version_major lack an ax_ prefix. They share configure's shell
#   namespace with callers and other macros, so they may collide with
#   variables of the same name. These variables should use macro-specific
#   ax_ names. [Rating: minor]
#
# LICENSE
#
#   Copyright (c) 2008 Mateusz Loskot <mateusz@loskot.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 16

AC_DEFUN([AX_LIB_MYSQL],
[
  m4_warn([override],
    [$0: MySQL client versions older than the requested minimum are still
     accepted.])
    AC_ARG_WITH([mysql],
        AS_HELP_STRING([--with-mysql=@<:@ARG@:>@],
            [use MySQL client library @<:@default=yes@:>@, optionally specify path to mysql_config]
        ),
        [
        if test "$withval" = "no"; then
            want_mysql="no"
        elif test "$withval" = "yes"; then
            want_mysql="yes"
        else
            want_mysql="yes"
            MYSQL_CONFIG="$withval"
        fi
        ],
        [want_mysql="yes"]
    )
    AC_ARG_VAR([MYSQL_CONFIG], [Full path to mysql_config program])

    MYSQL_CFLAGS=""
    MYSQL_LDFLAGS=""
    MYSQL_VERSION=""

    dnl
    dnl Check MySQL libraries
    dnl

    AS_IF([test "$want_mysql" = "yes"],[

        found_mysql=no
        AS_IF([test -z "$MYSQL_CONFIG"],[
            PKG_CHECK_MODULES([MYSQL],[mysqlclient],[
                MYSQL_LDFLAGS=$MYSQL_LIBS
                MYSQL_VERSION=`$PKG_CONFIG --modversion mysqlclient`
                found_mysql=yes
            ],[
                AC_PATH_PROGS([MYSQL_CONFIG], [mysql_config mysql_config5], [no])
            ])
        ])

        if test "$found_mysql" = no && test "$MYSQL_CONFIG" != "no"; then
            MYSQL_CFLAGS="`$MYSQL_CONFIG --cflags`"
            MYSQL_LDFLAGS="`$MYSQL_CONFIG --libs`"

            MYSQL_VERSION=`$MYSQL_CONFIG --version`

            found_mysql="yes"
        fi
    ])

    dnl
    dnl Check if required version of MySQL is available
    dnl


    mysql_version_req=ifelse([$1], [], [], [$1])

    if test "$found_mysql" = "yes" -a -n "$mysql_version_req"; then

        AC_MSG_CHECKING([if MySQL version is >= $mysql_version_req])

        dnl Decompose required version string of MySQL
        dnl and calculate its number representation
        mysql_version_req_major=`expr $mysql_version_req : '\([[0-9]]*\)'`
        mysql_version_req_minor=`expr $mysql_version_req : '[[0-9]]*\.\([[0-9]]*\)'`
        mysql_version_req_micro=`expr $mysql_version_req : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
        if test "x$mysql_version_req_micro" = "x"; then
            mysql_version_req_micro="0"
        fi

        mysql_version_req_number=`expr $mysql_version_req_major \* 1000000 \
                                   \+ $mysql_version_req_minor \* 1000 \
                                   \+ $mysql_version_req_micro`

        dnl Decompose version string of installed MySQL
        dnl and calculate its number representation
        mysql_version_major=`expr $MYSQL_VERSION : '\([[0-9]]*\)'`
        mysql_version_minor=`expr $MYSQL_VERSION : '[[0-9]]*\.\([[0-9]]*\)'`
        mysql_version_micro=`expr $MYSQL_VERSION : '[[0-9]]*\.[[0-9]]*\.\([[0-9]]*\)'`
        if test "x$mysql_version_micro" = "x"; then
            mysql_version_micro="0"
        fi

        mysql_version_number=`expr $mysql_version_major \* 1000000 \
                                   \+ $mysql_version_minor \* 1000 \
                                   \+ $mysql_version_micro`

        mysql_version_check=`expr $mysql_version_number \>\= $mysql_version_req_number`
        if test "$mysql_version_check" = "1"; then
            AC_MSG_RESULT([yes])
        else
            AC_MSG_RESULT([no])
        fi
    fi

    if test "$found_mysql" = "yes" ; then
        AC_DEFINE([HAVE_MYSQL], [1],
                  [Define to 1 if MySQL libraries are available])
    fi

    AC_SUBST([MYSQL_VERSION])
    AC_SUBST([MYSQL_CFLAGS])
    AC_SUBST([MYSQL_LDFLAGS])
])
