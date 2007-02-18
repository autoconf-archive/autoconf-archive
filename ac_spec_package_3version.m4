##### http://autoconf-archive.cryp.to/ac_spec_package_3version.html
#
# OBSOLETE MACRO
#
#   Use AX_SPEC_PACKAGE_VERSION.
#
# SYNOPSIS
#
#   AC_SPEC_PACKAGE_3VERSION(rpmspecfile)
#
# DESCRIPTION
#
#   set PACKAGE and VERSION from the defines in the given specfile
#   default to basename and currentdate if rpmspecfile is not found if
#   the VERSION-number from the spec-file is shorter than 3 digits then
#   additional numbers are taken from the current date using entries
#   from `date` as %y and %W%w since libtool version numbers can be as
#   max only be 3 digits. The year counts from 1900.
#
#   spec example:
#
#       Name: testprog
#       Version: 2
#
#   result: (on 1. April 2002, being monday of 13th week)
#
#       VERSION="2.102.131"
#       PACKAGE="testprog"
#
#   See also AC_SET_RELEASEINFO_VERSIONINFO for the use of a 3VERSION.
#
# LAST MODIFICATION
#
#   2006-10-13
#
# COPYLEFT
#
#   Copyright (c) 2006 Guido U. Draheim <guidod@gmx.de>
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

AC_DEFUN([AC_SPEC_PACKAGE_3VERSION],[dnl
  pushdef([specfile], ac_spec_package_version_file)
  specfile=`basename $1`
  AC_MSG_CHECKING( $specfile package version)
  if test -z "$1"; then
    AC_MSG_ERROR( no rpm spec file given )
  else
    # find specfile
    for i in $1 $srcdir/$1 $srcdir/../$1 ; do
      if test -f "$i" ; then
        specfile="$i"
        break
      fi
    done
    if test ! -f $specfile ; then
      k="w/o spec"
    else
      if test -z "$PACKAGE" ; then
        i=`grep -i '^name:' $specfile | head -1 | sed -e 's/.*://'`
	PACKAGE=`echo $i | sed -e 's/ /-/'`
      fi
      if test -z "$VERSION" ; then
        i=`grep -i '^version:' $specfile | head -1 | sed -e 's/.*://'`
	VERSION=`echo $i | sed -e 's/ /-/'`
      fi
    fi
    if test -z "$PACKAGE" ; then
      PACKAGE=`basename $specfile .spec`
    fi
    if test -z "$VERSION" ; then
      VERSION=`date +0.1%y.%W%w`
    fi
    case "$VERSION" in
    *.*.*) ;;
    *.*) VERSION="$VERSION."`date +1%y%W%w` ;;
    *) VERSION="$VERSION."`date +1%y.%W%w` ;;
    esac
    VERSION=`echo $VERSION | sed -e 's/[[.]]0/./g'`
    AC_MSG_RESULT( $PACKAGE $VERSION $k )
  fi
])
