# ===========================================================================
#     http://autoconf-archive.cryp.to/ac_set_releaseinfo_versioninfo.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Superseded by AX_SET_VERSION_INFO.
#
# SYNOPSIS
#
#   AC_SET_RELEASEINFO_VERSIONINFO [(VERSION)]
#
# DESCRIPTION
#
#     default $1 = $VERSION
#
#   check the $VERSION number and cut the two last digit-sequences off which
#   will form a -version-info in a @VERSIONINFO@ ac_subst while the rest is
#   going to the -release name in a @RELEASEINFO@ ac_subst.
#
#   you should keep these two seperate - the release-name may contain
#   alpha-characters and can be modified later with extra release-hints e.g.
#   RELEASEINFO="$RELEASINFO-debug" for a debug version of your lib.
#
#   example: a VERSION="2.4.18" will be transformed into "-release 2
#   -version-info 4:18" and for a linux-target this will tell libtool to
#   install the lib as "libmy.so libmy.la libmy.a libmy-2.so.4
#   libmy-2.so.4.0.18" and executables will get link-resolve-infos for
#   libmy-2.so.4 - therefore the patch-level is ignored during ldso linking,
#   and ldso will use the one with the highest patchlevel. Using just
#   "-release $(VERSION)" during libtool-linking would not do that -
#   omitting the -version-info will libtool install libmy.so libmy.la
#   libmy.a libmy-2.4.18.so and executables would get hardlinked with the
#   2.4.18 version of your lib.
#
#   This background does also explain the default dll name for a win32
#   target : libtool will choose to make up libmy-2-4.dll for this version
#   spec.
#
#   this macro does set the three parts VERSION_REL.VERSION_REQ.VERSION_REL
#   from the VERSION-spec but does not ac_subst them like the two INFOs. If
#   you prefer a two-part VERSION-spec, the VERSION_REL will still be set,
#   either to the host_cpu or just a simple "00". You may add sublevel parts
#   like "1.4.2-ac5" where the sublevel is just killed from these
#   versioninfo/releasinfo substvars.
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

AC_DEFUN([AC_SET_RELEASEINFO_VERSIONINFO],
[# ------ AC SET RELEASEINFO VERSIONINFO --------------------------------
AC_MSG_CHECKING(version info)
  VERSION_REQ=`echo ifelse( $1, , $VERSION, $1 )` # VERSION_TMP really...
  VERSION_REL=`echo $VERSION_REQ | sed -e 's/[[.]][[^.]]*$//'`  # delete micro
  VERSION_REV=`echo $VERSION_REQ | sed -e "s/^$VERSION_REL.//"` # the rest
  VERSION_REQ=`echo $VERSION_REL | sed -e 's/.*[[.]]//'`  # delete prefix now
  VERSION_REV=`echo $VERSION_REV | sed -e 's/[[^0-9]].*//'` # 5-p4 -> 5
  if test "$VERSION_REQ" != "$VERSION_REL" ; then # three-part version...
  VERSION_REL=`echo $VERSION_REL | sed -e "s/.$VERSION_REQ\$//"`
  else # or has been two-part version - try using host_cpu if available
  VERSION_REL="00" ; test "_$host_cpu" != "_" && VERSION_REL="$host_cpu"
  fi
  RELEASEINFO="-release $VERSION_REL"
  VERSIONINFO="-version-info $VERSION_REQ:$VERSION_REV"
AC_MSG_RESULT([$RELEASEINFO $VERSIONINFO])
AC_SUBST([RELEASEINFO])
AC_SUBST([VERSIONINFO])
])
