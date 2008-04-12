# ===========================================================================
#            http://autoconf-archive.cryp.to/ac_check_cc_opt.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Use CFLAGS/CXXFLAGS related macros as soon as possible.
#
# SYNOPSIS
#
#   AC_CHECK_CC_OPT(flag, cachevarname)
#
# DESCRIPTION
#
#   AC_CHECK_CC_OPT(-fvomit-frame,vomitframe) would show a message as like
#   "checking wether gcc accepts -fvomit-frame ... no" and sets the
#   shell-variable $vomitframe to either "-fvomit-frame" or (in this case)
#   just a simple "". In many cases you would then call
#   AC_SUBST(_fvomit_frame_,$vomitframe) to create a substitution that could
#   be fed as "CFLAGS = @_funsigned_char_@ @_fvomit_frame_@.
#
#   In consequence this function is much more general than their specific
#   counterparts like ac_cxx_rtti.m4 that will test for -fno-rtti
#   -fno-exceptions.
#
#   This macro will be obsolete in the very near future - there should be
#   two macros AX_CFLAGS_OPTION and AX_CXXFLAGS_OPTION that will add
#   directly to the CFLAGS/CXXFLAGS unless a ac_subst-variable was given.
#   Remind me of doing so if I forget about writing it all up - to use
#   $CC-cc directly in here instead of ac_compile macro is bad anyway.
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

AC_DEFUN([AC_CHECK_CC_OPT],
[AC_CACHE_CHECK(whether ${CC-cc} accepts [$1], [$2],
[AC_SUBST($2)
echo 'void f(){}' > conftest.c
if test -z "`${CC-cc} -c $1 conftest.c 2>&1`"; then
  $2="$1"
else
  $2=""
fi
rm -f conftest*
])])
