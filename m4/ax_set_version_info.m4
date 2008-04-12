# ===========================================================================
#          http://autoconf-archive.cryp.to/ax_set_version_info.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_SET_VERSION_INFO [(VERSION [,PREFIX])]
#
# DESCRIPTION
#
#   Defaults:
#
#     $1 = $PACKAGE_VERSION
#     $2 = <none>
#
#   Check the $VERSION number and cut the two last digit-sequences off which
#   will form a -version-info in a @VERSION_INFO@ ac_subst while the rest is
#   going to the -release name in a @RELEASE_INFO@ ac_subst.
#
#   you should keep these two seperate - the release-name may contain
#   alpha-characters and can be modified later with extra release-hints e.g.
#   RELEASE_INFO="$RELEASE_INFO-debug" for a debug version of your lib. The
#   $VERSION_INFO however should not be touched.
#
#   example: a VERSION="2.4.18" will be transformed into
#
#      RELEASE_INFO = -release 2
#      VERSION_INFO = -versioninfo 4:18
#
#   then use these two variables and push them to your libtool linker
#
#      libtest_la_LIBADD = @RELEASE_INFO@ @VERSION_INFO@
#
#   and for a linux-target this will tell libtool to install the lib as
#
#      libmy.so libmy.la libmy.a libmy-2.so.4 libmy-2.so.4.0.18
#
#   and executables will get link-resolve-infos for libmy-2.so.4 - therefore
#   the patch-level is ignored during ldso linking, and ldso will use the
#   one with the highest patchlevel. Using just "-release $(VERSION)" during
#   libtool-linking would not do that - omitting the -version-info will
#   libtool install libmy.so libmy.la libmy.a libmy-2.4.18.so and
#   executables would get hardlinked with the 2.4.18 version of your lib.
#
#   This background does also explain the default dll name for a win32
#   target : libtool will choose to make up libmy-2-4.dll for this version
#   spec.
#
#   this macro does also set the usual three parts of a version spec
#   $MAJOR_VERSION.$MINOR_VERSION.$MICRO_VERSION but does not ac_subst for
#   the plain AX_SET_VERSION_INFO macro. Use instead one of the numbered
#   macros AX_SET_VERSION_INFO1 (use first number for release part) or that
#   AX_SET_VERSION_INFO2 (use the first two numbers for release part).
#
#   You may add sublevel parts like "1.4.2-ac5" where the sublevel is just
#   killed from these version/release substvars. That allows to grab the
#   version off a .spec file like with AX_SPEC_PACKAGE_VERSION where the
#   $VERSION is used to name a tarball or distpack like mylib-2.2.9pre4
#
#   Unlike earlier macros, you can use this one to break up different
#   VERSIONs and put them into different variables, just hint with
#   PREFIX-setting - i.e. _VERSION(2.4.5,TEST) will set variables named
#   TEST_MAJOR_VERSION=2... and of course $TEST_RELEASE_INFO etc. (for the
#   moment, it needs to be a literal prefix *sigh*)
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 2 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.
#
#   As a special exception, the respective Autoconf Macro's copyright owner
#   gives unlimited permission to copy, distribute and modify the configure
#   scripts that are the output of Autoconf when processing the Macro. You
#   need not follow the terms of the GNU General Public License when using
#   or distributing such scripts, even though portions of the text of the
#   Macro appear in them. The GNU General Public License (GPL) does govern
#   all other use of the material that constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the Autoconf
#   Macro released by the Autoconf Macro Archive. When you make and
#   distribute a modified version of the Autoconf Macro, you may extend this
#   special exception to the GPL to apply to your modified version as well.

AC_DEFUN([AX_SET_VERSION_INFO1],[dnl
AS_VAR_PUSHDEF([MAJOR],ifelse($2,,[MAJOR_VERSION],[$2_MAJOR_VERSION]))dnl
AS_VAR_PUSHDEF([MINOR],ifelse($2,,[MINOR_VERSION],[$2_MINOR_VERSION]))dnl
AS_VAR_PUSHDEF([MICRO],ifelse($2,,[MICRO_VERSION],[$2_MICRO_VERSION]))dnl
AS_VAR_PUSHDEF([PATCH],ifelse($2,,[PATCH_VERSION],[$2_PATCH_VERSION]))dnl
AS_VAR_PUSHDEF([LTREL],ifelse($2,,[RELEASE_INFO],[$2_RELEASE_INFO]))dnl
AS_VAR_PUSHDEF([LTVER],ifelse($2,,[VERSION_INFO],[$2_VERSION_INFO]))dnl
test ".$PACKAGE_VERSION" = "." && PACKAGE_VERSION="$VERSION"
AC_MSG_CHECKING(ifelse($2,,,[$2 ])out linker version info dnl
ifelse($1,,$PACKAGE_VERSION,$1) )
  MINOR=`echo ifelse( $1, , $PACKAGE_VERSION, $1 )`
  MAJOR=`echo "$MINOR" | sed -e 's/[[.]].*//'`
  MINOR=`echo "$MINOR" | sed -e "s/^$MAJOR//" -e 's/^.//'`
  MICRO="$MINOR"
  MINOR=`echo "$MICRO" | sed -e 's/[[.]].*//'`
  MICRO=`echo "$MICRO" | sed -e "s/^$MINOR//" -e 's/^.//'`
  PATCH="$MICRO"
  MICRO=`echo "$PATCH" | sed -e 's/[[^0-9]].*//'`
  PATCH=`echo "$PATCH" | sed -e "s/^$MICRO//" -e 's/^[[-.]]//'`
  if test "_$MICRO" = "_" ; then MICRO="0" ; fi
  if test "_$MINOR" = "_" ; then MINOR="$MAJOR" ; MAJOR="0" ; fi
  MINOR=`echo "$MINOR" | sed -e 's/[[^0-9]].*//'`
  LTREL="-release $MAJOR"
  LTVER="-version-info $MINOR:$MICRO"
AC_MSG_RESULT([/$MAJOR/$MINOR:$MICRO (-$MAJOR.so.$MINOR.0.$MICRO)])
AC_SUBST(MAJOR)
AC_SUBST(MINOR)
AC_SUBST(MICRO)
AC_SUBST(PATCH)
AC_SUBST(LTREL)
AC_SUBST(LTVER)
AS_VAR_POPDEF([LTVER])dnl
AS_VAR_POPDEF([LTREL])dnl
AS_VAR_POPDEF([PATCH])dnl
AS_VAR_POPDEF([MICRO])dnl
AS_VAR_POPDEF([MINOR])dnl
AS_VAR_POPDEF([MAJOR])dnl
])

AC_DEFUN([AX_SET_VERSION_INFO2],[dnl
AS_VAR_PUSHDEF([MAJOR],ifelse($2,,[MAJOR_VERSION],[$2_MAJOR_VERSION]))dnl
AS_VAR_PUSHDEF([MINOR],ifelse($2,,[MINOR_VERSION],[$2_MINOR_VERSION]))dnl
AS_VAR_PUSHDEF([MICRO],ifelse($2,,[MICRO_VERSION],[$2_MICRO_VERSION]))dnl
AS_VAR_PUSHDEF([PATCH],ifelse($2,,[PATCH_VERSION],[$2_PATCH_VERSION]))dnl
AS_VAR_PUSHDEF([LTREL],ifelse($2,,[RELEASE_INFO],[$2_RELEASE_INFO]))dnl
AS_VAR_PUSHDEF([LTVER],ifelse($2,,[VERSION_INFO],[$2_VERSION_INFO]))dnl
test ".$PACKAGE_VERSION" = "." && PACKAGE_VERSION="$VERSION"
AC_MSG_CHECKING(ifelse($2,,,[$2 ])out linker version info dnl
ifelse($1,,$PACKAGE_VERSION,$1) )
  MINOR=`echo ifelse( $1, , $PACKAGE_VERSION, $1 )`
  MAJOR=`echo "$MINOR" | sed -e 's/[[.]].*//'`
  MINOR=`echo "$MINOR" | sed -e "s/^$MAJOR//" -e 's/^.//'`
  MICRO="$MINOR"
  MINOR=`echo "$MICRO" | sed -e 's/[[.]].*//'`
  MICRO=`echo "$MICRO" | sed -e "s/^$MINOR//" -e 's/^.//'`
  PATCH="$MICRO"
  MICRO=`echo "$PATCH" | sed -e 's/[[^0-9]].*//'`
  PATCH=`echo "$PATCH" | sed -e "s/^$MICRO//" -e 's/^[[-.]]//'`
  test "_$MICRO" != "_" || MICRO="0"
  if test "_$MINOR" != "_" ; then MINOR="$MAJOR" ; MAJOR="0" ; fi
  MINOR=`echo "$MINOR" | sed -e 's/[[^0-9]].*//'`
  LTREL="-release $MAJOR.$MINOR"
  LTVER="-version-info 0:$MICRO"
AC_MSG_RESULT([/$MAJOR/$MINOR:$MICRO (-$MAJOR.so.$MINOR.0.$MICRO)])
AC_SUBST(MAJOR)
AC_SUBST(MINOR)
AC_SUBST(MICRO)
AC_SUBST(PATCH)
AC_SUBST(LTREL)
AC_SUBST(LTVER)
AS_VAR_POPDEF([LTVER])dnl
AS_VAR_POPDEF([LTREL])dnl
AS_VAR_POPDEF([PATCH])dnl
AS_VAR_POPDEF([MICRO])dnl
AS_VAR_POPDEF([MINOR])dnl
AS_VAR_POPDEF([MAJOR])dnl
])

AC_DEFUN([AX_SET_VERSION_INFO],[dnl
AS_VAR_PUSHDEF([MAJOR],ifelse($2,,[MAJOR_VERSION],[$2_MAJOR_VERSION]))dnl
AS_VAR_PUSHDEF([MINOR],ifelse($2,,[MINOR_VERSION],[$2_MINOR_VERSION]))dnl
AS_VAR_PUSHDEF([MICRO],ifelse($2,,[MICRO_VERSION],[$2_MICRO_VERSION]))dnl
AS_VAR_PUSHDEF([PATCH],ifelse($2,,[PATCH_VERSION],[$2_PATCH_VERSION]))dnl
AS_VAR_PUSHDEF([LTREL],ifelse($2,,[RELEASE_INFO],[$2_RELEASE_INFO]))dnl
AS_VAR_PUSHDEF([LTVER],ifelse($2,,[VERSION_INFO],[$2_VERSION_INFO]))dnl
test ".$PACKAGE_VERSION" = "." && PACKAGE_VERSION="$VERSION"
AC_MSG_CHECKING(ifelse($2,,,[$2 ])out linker version info dnl
ifelse($1,,$PACKAGE_VERSION,$1) )
  MINOR=`echo ifelse( $1, , $PACKAGE_VERSION, $1 )`
  MAJOR=`echo "$MINOR" | sed -e 's/[[.]].*//'`
  MINOR=`echo "$MINOR" | sed -e "s/^$MAJOR//" -e 's/^.//'`
  MICRO="$MINOR"
  MINOR=`echo "$MICRO" | sed -e 's/[[.]].*//'`
  MICRO=`echo "$MICRO" | sed -e "s/^$MINOR//" -e 's/^.//'`
  PATCH="$MICRO"
  MICRO=`echo "$PATCH" | sed -e 's/[[^0-9]].*//'`
  PATCH=`echo "$PATCH" | sed -e "s/^$MICRO//" -e 's/[[-.]]//'`
  if test "_$MICRO" = "_" ; then MICRO="0" ; fi
  if test "_$MINOR" = "_" ; then MINOR="$MAJOR" ; MAJOR="0" ; fi
  MINOR=`echo "$MINOR" | sed -e 's/[[^0-9]].*//'`
  LTREL="-release $MAJOR"
  LTVER="-version-info $MINOR:$MICRO"
AC_MSG_RESULT([/$MAJOR/$MINOR:$MICRO (-$MAJOR.so.$MINOR.0.$MICRO)])
AC_SUBST(LTREL)
AC_SUBST(LTVER)
AS_VAR_POPDEF([LTVER])dnl
AS_VAR_POPDEF([LTREL])dnl
AS_VAR_POPDEF([PATCH])dnl
AS_VAR_POPDEF([MICRO])dnl
AS_VAR_POPDEF([MINOR])dnl
AS_VAR_POPDEF([MAJOR])dnl
])
