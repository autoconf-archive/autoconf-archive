# ===========================================================================
#     http://autoconf-archive.cryp.to/ac_set_default_paths_dllsystem.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   AC_SET_DEFAULT_PATHS_SYSTEM is even more intelligent.
#
# SYNOPSIS
#
#   AC_SET_DEFAULT_PATHS_DLLSYSTEM
#
# DESCRIPTION
#
#   This macro diverts all subpaths to either /bin/.. or /share/..
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

AC_DEFUN([AC_SET_DEFAULT_PATHS_DLLSYSTEM],
[AC_REQUIRE([AC_CANONICAL_HOST])
case ${host_os} in
  *cygwin* | *mingw* | *uwin* | *djgpp | *emx*)
     AC_MSG_RESULT(changing default paths for win/dos target...yes)
     test "$ac_default_prefix" = "/usr/local" && ac_default_prefix="/programs"
     # on win/dos, .exe .dll and .cfg live in the same directory
     bindir=`echo $bindir |sed -e '/^..exec_prefix/s:/bin$:/${PACKAGE}:'`
     libdir=`echo $libdir |sed -e 's:^..exec_prefix./lib$:${bindir}:'`
     sbindir=`echo $sbindir |sed -e 's:^..exec_prefix./sbin$:${bindir}:'`
     sysconfdir=`echo $sysconfdir |sed -e 's:^..prefix./etc$:${bindir}:'`
     libexecdir=`echo $libexecdir |sed -e 's:^..exec_prefix./libexec$:${bindir}/system:'`
     # help-files shall be set with --infodir
     # leave datadir as /share
     infodir=`echo $infodir |sed -e 's:^..prefix./info$:${datadir}/help:'`
     mandir=`echo $mandir |sed -e 's:^..prefix./man$:${datadir}/help:'`
     includedir=`echo $includedir |sed -e 's:..prefix./include$:${datadir}/include:'`
     sharedstatedir=`echo $sharedstatedir |sed -e 's:..prefix./com$:${datadir}/common:'`
     localstatedir=`echo $localstatedir |sed -e 's:..prefix./var$:${datadir}/local:'`
  ;;
esac
])
