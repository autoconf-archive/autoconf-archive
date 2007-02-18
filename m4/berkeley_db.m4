##### http://autoconf-archive.cryp.to/berkeley_db.html
#
# SYNOPSIS
#
#   AX_BERKELEY_DB([MINIMUM-VERSION [, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]]])
#
# DESCRIPTION
#
#   This macro tries to find Berkeley DB. It honors MINIMUM-VERSION if
#   given.
#
#   If libdb is found, DB_HEADER and DB_LIBS variables are set and
#   ACTION-IF-FOUND shell code is executed if specified. DB_HEADER is
#   set to location of db.h header in quotes (e.g. "db3/db.h") and
#   AC_DEFINE_UNQUOTED is called on it, so that you can type
#
#        #include DB_HEADER
#
#   in your C/C++ code. DB_LIBS is set to linker flags needed to link
#   against the library (e.g. -ldb3.1) and AC_SUBST is called on it.
#
# LAST MODIFICATION
#
#   2005-01-21
#
# COPYLEFT
#
#   Copyright (c) 2005 Vaclav Slavik <vaclav.slavik@matfyz.cz>
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
#   02111-1307, USA.
#
#   As a special exception, the respective Autoconf Macro's copyright
#   owner gives unlimited permission to copy, distribute and modify the
#   configure scripts that are the output of Autoconf when processing
#   the Macro. You need not follow the terms of the GNU General Public
#   License when using or distributing such scripts, even though
#   portions of the text of the Macro appear in them. The GNU General
#   Public License (GPL) does govern all other use of the material that
#   constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the
#   Autoconf Macro released by the Autoconf Macro Archive. When you
#   make and distribute a modified version of the Autoconf Macro, you
#   may extend this special exception to the GPL to apply to your
#   modified version as well.

AC_DEFUN([AX_BERKELEY_DB],
[
  old_LIBS="$LIBS"

  minversion=ifelse([$1], ,,$1)

  DB_HEADER=""
  DB_LIBS=""

  if test -z $minversion ; then
      minvermajor=0
      minverminor=0
      minverpatch=0
      AC_MSG_CHECKING([for Berkeley DB])
  else
      minvermajor=`echo $minversion | cut -d. -f1`
      minverminor=`echo $minversion | cut -d. -f2`
      minverpatch=`echo $minversion | cut -d. -f3`
      minvermajor=${minvermajor:-0}
      minverminor=${minverminor:-0}
      minverpatch=${minverpatch:-0}
      AC_MSG_CHECKING([for Berkeley DB >= $minversion])
  fi

  for version in "" 5.0 4.9 4.8 4.7 4.6 4.5 4.4 4.3 4.2 4.1 4.0 3.6 3.5 3.4 3.3 3.2 3.1 ; do

    if test -z $version ; then
        db_lib="-ldb"
        try_headers="db.h"
    else
        db_lib="-ldb-$version"
        try_headers="db$version/db.h db`echo $version | sed -e 's,\..*,,g'`/db.h"
    fi

    LIBS="$old_LIBS $db_lib"

    for db_hdr in $try_headers ; do
        if test -z $DB_HEADER ; then
            AC_LINK_IFELSE(
                [AC_LANG_PROGRAM(
                    [
                        #include <${db_hdr}>
                    ],
                    [
                        #if !((DB_VERSION_MAJOR > (${minvermajor}) || \
                              (DB_VERSION_MAJOR == (${minvermajor}) && \
                                    DB_VERSION_MINOR > (${minverminor})) || \
                              (DB_VERSION_MAJOR == (${minvermajor}) && \
                                    DB_VERSION_MINOR == (${minverminor}) && \
                                    DB_VERSION_PATCH >= (${minverpatch}))))
                            #error "too old version"
                        #endif

                        DB *db;
                        db_create(&db, NULL, 0);
                    ])],
                [
                    AC_MSG_RESULT([header $db_hdr, library $db_lib])

                    DB_HEADER="$db_hdr"
                    DB_LIBS="$db_lib"
                ])
        fi
    done
  done

  LIBS="$old_LIBS"

  if test -z $DB_HEADER ; then
    AC_MSG_RESULT([not found])
    ifelse([$3], , :, [$3])
  else
    AC_DEFINE_UNQUOTED(DB_HEADER, ["$DB_HEADER"])
    AC_SUBST(DB_LIBS)
    ifelse([$2], , :, [$2])
  fi
])
