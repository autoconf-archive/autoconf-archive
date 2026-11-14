# ===========================================================================
#     https://www.gnu.org/software/autoconf-archive/ax_subdir_files.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   An unquoted $0 makes the macro expand itself recursively, so autoconf
#   fails whenever it is used.
#
# SYNOPSIS
#
#   AX_SUBDIR_FILES [(SUBDIRS [, CASEPATTERN])]
#
# DESCRIPTION
#
#   Look into subdirs and copy the (real) files that match pattern into the
#   local directory. Preferably we use a symbolic link of course. existing
#   local files are not overwritten.
#
#   The default casepattern is "*.?|*.cc|*.cpp", the default subdir-list
#   contains all subdirs available.
#
# BUGS
#
#   (1) When CASEPATTERN is supplied, the generated case statement uses
#   SUBDIRS (the first argument) as its pattern instead. With a single
#   subdirectory nothing is copied, and with several the generated configure
#   has a shell syntax error. [Rating: major]
#
#   (2) AC_BEFORE($0,[AX_PROG_CP_S]) does not quote $0, so the macro expands
#   itself inside its own arguments. Every use makes autoconf fail with "m4:
#   recursion limit of 1024 exceeded". [Rating: broken]
#
# LICENSE
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 10

AU_ALIAS([AC_SUBDIR_FILES], [AX_SUBDIR_FILES])
AC_DEFUN([AX_SUBDIR_FILES],
[
  m4_warn([obsolete], [$0 is obsolete: it makes autoconf fail with a recursion error])
AC_BEFORE($0,[AX_PROG_CP_S])
  for ac_subdir in ifelse([$1], , *, $1) ; do
    if test -d $ac_subdir ; then
      AC_MSG_CHECKING(subdir $ac_subdir)
      for ac_file in $ac_subdir/* ; do
        if test -f $ac_file ; then
          if test ! -e `basename $ac_file` ; then
            case `basename $ac_file` in
              ifelse([$2], , *.?|*.cc|*.cpp,[$1]))
                echo ${ECHO_N} "$ac_file," ;
                $CP_S $ac_file . ;;
            esac
          fi
        fi
      done
      AC_MSG_RESULT(;)
    fi
  done
])
