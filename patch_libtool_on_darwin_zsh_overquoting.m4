# ==============================================================================
#  http://autoconf-archive.cryp.to/patch_libtool_on_darwin_zsh_overquoting.html
# ==============================================================================
#
# OBSOLETE MACRO
#
#   The problem is fixed in modern libtool versions.
#
# SYNOPSIS
#
#   PATCH_LIBTOOL_ON_DARWIN_ZSH_OVERQUOTING
#
# DESCRIPTION
#
#   libtool 1.4.x has a bug on darwin where the "zsh" is installed as the
#   bourne shell replacement. Of course, the zsh is called in a
#   compatibility mode but there is a common problem with it, probably a bug
#   of zsh. Newer darwin systems have a "bash" installed now, but the
#   configure-default will be "zsh" in most systems still.
#
#   The bug revelas itself as an overquoted statement in the libtool
#   cmds-spec for sharedlib creation on testing for "module" builds. Later
#   libtool has gone rid of it by simply removing the quotes at that point .
#   Here we maintain the original style and simply remove the extra escape
#   character, i.e. we look for "archive_cmds" and replace a sequence of
#   triple-backslash-and-doublequote with single-backslash-and-doublequote.
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

AC_DEFUN([PATCH_LIBTOOL_ON_DARWIN_ZSH_OVERQUOTING],
[# libtool-1.4 specific, on zsh target the final requoting does one too much
case "$host_os" in
  darwin*)
    if grep "1.92" libtool >/dev/null ; then
AC_MSG_RESULT(patching libtool on .so-sharedlib creation (zsh overquoting))
      test -f libtool.old || (mv libtool libtool.old && cp libtool.old libtool)
      sed -e '/archive_cmds=/s:[[\\]][[\\]][[\\]]*":\\":g' libtool >libtool.new
      (test -s libtool.new || rm libtool.new) 2>/dev/null
      test -f libtool.new && mv libtool.new libtool # not 2>/dev/null !!
      test -f libtool     || mv libtool.old libtool
    fi
  ;;
esac
])
