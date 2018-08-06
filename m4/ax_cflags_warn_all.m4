# ===========================================================================
#    https://www.gnu.org/software/autoconf-archive/ax_cflags_warn_all.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CFLAGS_WARN_ALL   [(shellvar [,default, [A/NA]])]
#   AX_CXXFLAGS_WARN_ALL [(shellvar [,default, [A/NA]])]
#   AX_FCFLAGS_WARN_ALL  [(shellvar [,default, [A/NA]])]
#
# DESCRIPTION
#
#   Try to find a compiler option that enables most reasonable warnings.
#
#   For the GNU compiler it will be -Wall (and -ansi -pedantic) The result
#   is added to the shellvar being CFLAGS, CXXFLAGS, or FCFLAGS by default.
#
#   Currently this macro knows about the GCC, Solaris, Digital Unix, AIX,
#   HP-UX, IRIX, NEC SX-5 (Super-UX 10), Cray J90 (Unicos 10.0.0.8), and
#   Intel compilers.  For a given compiler, the Fortran flags are much more
#   experimental than their C equivalents.
#
#    - $1 shell-variable-to-add-to : CFLAGS, CXXFLAGS, or FCFLAGS
#    - $2 add-value-if-not-found : nothing
#    - $3 action-if-found : add value to shellvariable
#    - $4 action-if-not-found : nothing
#
#   NOTE: These macros depend on AX_APPEND_FLAG.
#
# LICENSE
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#   Copyright (c) 2010 Rhys Ulerich <rhys.ulerich@gmail.com>
#   Copyright (c) 2018 John Zaitseff <J.Zaitseff@zap.org.au>
#
#   This program is free software; you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation; either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <https://www.gnu.org/licenses/>.
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
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 17

AC_DEFUN([AX_FLAGS_WARN_ALL], [
    AX_REQUIRE_DEFINED([AX_APPEND_FLAG])dnl
    AC_REQUIRE([AX_COMPILER_VENDOR])dnl

    AS_VAR_PUSHDEF([FLAGS], [m4_default($1,_AC_LANG_PREFIX[]FLAGS)])dnl
    AS_VAR_PUSHDEF([VAR],   [ac_cv_[]_AC_LANG_ABBREV[]flags_warn_all])dnl
    AS_VAR_PUSHDEF([FOUND], [ac_save_[]_AC_LANG_ABBREV[]flags_warn_all_found])dnl

    AC_CACHE_CHECK([FLAGS for most reasonable warnings], VAR, [
	FOUND="yes"
	dnl  Cases are listed in the order found in ax_compiler_vendor.m4
	AS_CASE("$ax_cv_[]_AC_LANG_ABBREV[]_compiler_vendor",
	    [intel],		[VAR="-warn all"],
	    [ibm],		[VAR="-qsrcmsg -qinfo=all:noppt:noppc:noobs:nocnd"],
	    [pathscale],	[VAR=""],
	    [clang],		[VAR="-Wall"],
	    [cray],		[VAR="-h msglevel 2"],
	    [fujitsu],		[VAR=""],
	    [sdcc],		[VAR=""],
	    [sx],		[VAR="-pvctl[,]fullmsg"],
	    [portland],		[VAR="-Wall"],
	    [gnu],		[VAR="-Wall"],
	    [sun],		[VAR="-v"],
	    [hp],		[VAR="+w1"],
	    [dec],		[VAR="-verbose -w0 -warnprotos"],
	    [borland],		[VAR=""],
	    [comeau],		[VAR=""],
	    [kai],		[VAR=""],
	    [lcc],		[VAR=""],
	    [sgi],		[VAR="-fullwarn"],
	    [microsoft],	[VAR=""],
	    [metrowerks],	[VAR=""],
	    [watcom],		[VAR=""],
	    [tcc],		[VAR=""],
	    [unknown],		[
				    VAR="$2"
				    FOUND="no"
				],
				[
				    AC_MSG_WARN([Unknown compiler vendor returned by [AX_COMPILER_VENDOR]])
				    VAR="$2"
				    FOUND="no"
				]
	)

	AS_IF([test "x$FOUND" = "xyes"], [dnl
	    m4_default($3, [AX_APPEND_FLAG([$VAR], [FLAGS])])
	], [dnl
	    m4_default($4, [m4_ifval($2, [AX_APPEND_FLAG([$VAR], [FLAGS])], [true])])
	])dnl
    ])dnl

    AS_VAR_POPDEF([FOUND])dnl
    AS_VAR_POPDEF([VAR])dnl
    AS_VAR_POPDEF([FLAGS])dnl
])dnl AX_FLAGS_WARN_ALL

AC_DEFUN([AX_CFLAGS_WARN_ALL], [dnl
    AC_LANG_PUSH([C])
    AX_FLAGS_WARN_ALL([$1], [$2], [$3], [$4])
    AC_LANG_POP([C])
])dnl

AC_DEFUN([AX_CXXFLAGS_WARN_ALL], [dnl
    AC_LANG_PUSH([C++])
    AX_FLAGS_WARN_ALL([$1], [$2], [$3], [$4])
    AC_LANG_POP([C++])
])dnl

AC_DEFUN([AX_FCFLAGS_WARN_ALL], [dnl
    AC_LANG_PUSH([Fortran])
    AX_FLAGS_WARN_ALL([$1], [$2], [$3], [$4])
    AC_LANG_POP([Fortran])
])dnl
