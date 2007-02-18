##### http://autoconf-archive.cryp.to/ac_cond_with.html
#
# OBSOLETE MACRO
#
#   Use AX_SUBST_WITH or AM_CONDITIONAL.
#
# SYNOPSIS
#
#   AC_COND_WITH(PACKAGE [,DEFAULT])
#
# DESCRIPTION
#
#   Actually used after an AC_ARG_WITH(PKG,...) option-directive, where
#   AC_ARG_WITH is a part of the standard autoconf to define a
#   `configure` --with-PKG option.
#
#   The AC_COND_WITH(PKG) will use the $with_PKG var to define WITH_PKG
#   and WITHOUT_PKG substitutions (AC_SUBST), that are either '' or '#'
#   - depending whether the var was "no" or not (probably 'yes', or a
#   value); it will also declare WITHVAL_PKG for use when someone
#   wanted to set a val other than just "yes". And there is a
#   WITHDEF_PKG that expands to a C-precompiler definition of the form
#   -DWITH_PKG or -DWITH_PKG=\"value\" (n.b.: the PKG *is* uppercased
#   if in lowercase and "-" translit to "_").
#
#   This macro is most handily in making Makefile.in/Makefile.am that
#   have a set of if-with declarations that can be defined as follows:
#
#    CFLAGS = -Wall @WITHOUT_FLOAT@ -msoft-float # --without-float
#    @WITH_FLOAT@ LIBS += -lm              # --with-float
#    DEFS += -DNDEBUG @WITHDEF_MY_PKG@     # --with-my-pkg="/usr/lib"
#    DEFS += @WITHVAL_DEFS@                # --with-defs="-DLOGLEVEL=6"
#
#   Example configure.in:
#
#    AC_ARG_WITH(float,
#    [ --with-float,       with float words support])
#    AC_COND_WITH(float,no)
#
#   Extened notes:
#
#   1. the idea comes from AM_CONDITIONAL but it is much easier to use,
#   and unlike automake's ifcond, the Makefile.am will work as a normal
#   $(MAKE) -f Makefile.am makefile.
#
#   2. the @VALS@ are parsed over by automake so automake will see all
#   the filenames and definitions that follow @WITH_FLOAT@, so that the
#   AC_COND_WITH user can see additional message if they apply.
#
#   3. in this m4-part, there's a AC_ARG_COND_WITH with the synopsis of
#   AC_ARG_WITH and an implicit following AC_COND_WITH =:-)
#
#   4. and there is an AC_ARG_COND_WITH_DEFINE that will emit an
#   implicit AC_DEFINE that is actually seen by autoheader, even
#   generated with the correct name and comment, for config.h.in
#
#   some non-autoconf coders tend to create "editable" Makefile where
#   they have out-commented lines with an example (additional)
#   definition. Each of these can be replaced with a three-liner in
#   configure.in as shown above. Starting to use AC_COND_WITH will soon
#   lead you to provide a dozen --with-option rules for the `configure`
#   user. Do it!
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

AC_DEFUN([AC_COND_WITH],
[dnl the names to be defined...
pushdef([WITH_VAR],    patsubst([with_$1], -, _))dnl
pushdef([VAR_WITH],    patsubst(translit([with_$1], [a-z], [A-Z]), -, _))dnl
pushdef([VAR_WITHOUT], patsubst(translit([without_$1], [a-z], [A-Z]), -, _))dnl
pushdef([VAR_WITHVAL], patsubst(translit([withval_$1], [a-z], [A-Z]), -, _))dnl
pushdef([VAR_WITHDEF], patsubst(translit([withdef_$1], [a-z], [A-Z]), -, _))dnl
AC_SUBST(VAR_WITH)
AC_SUBST(VAR_WITHOUT)
AC_SUBST(VAR_WITHVAL)
AC_SUBST(VAR_WITHDEF)
if test -z "$WITH_VAR" ; then WITH_VAR=`echo ifelse([$2], , no, [$2])` ; fi
if test "$WITH_VAR" != "no"; then
  VAR_WITH=    ; VAR_WITHOUT='#'
  case "$WITH_VAR" in
    [yes)]    VAR_WITHVAL=""
              VAR_WITHDEF="-D""VAR_WITH" ;;
    [*)]      VAR_WITHVAL=WITH_VAR
              VAR_WITHDEF="-D""VAR_WITH="'"'$WITH_VAR'"' ;;
  esac
else
  VAR_WITH='#' ;  VAR_WITHOUT=
  VAR_WITHVAL= ;  VAR_WITHDEF=
fi
popdef([VAR_WITH])dnl
popdef([VAR_WITHOUT])dnl
popdef([VAR_WITHVAL])dnl
popdef([VAR_WITHDEF])dnl
popdef([WITH_VAR])dnl
])

AC_DEFUN([AC_ARG_COND_WITH],
[dnl
AC_ARG_WITH([$1],[$2],[$3],[$4],[$5])
# done with AC_ARG_WITH, now do AC_COND_WITH (rather than AM_CONDITIONAL)
AC_COND_WITH([$1])
])

dnl and the same version as AC_COND_WITH but including the
dnl AC_DEFINE for WITH_PACKAGE

AC_DEFUN([AC_COND_WITH_DEFINE],
[dnl the names to be defined...
pushdef([WITH_VAR],    patsubst([with_$1], -, _))dnl
pushdef([VAR_WITH],    patsubst(translit([with_$1], [a-z], [A-Z]), -, _))dnl
pushdef([VAR_WITHOUT], patsubst(translit([without_$1], [a-z], [A-Z]), -, _))dnl
pushdef([VAR_WITHVAL], patsubst(translit([withval_$1], [a-z], [A-Z]), -, _))dnl
pushdef([VAR_WITHDEF], patsubst(translit([withdef_$1], [a-z], [A-Z]), -, _))dnl
AC_SUBST(VAR_WITH)
AC_SUBST(VAR_WITHOUT)
AC_SUBST(VAR_WITHVAL)
AC_SUBST(VAR_WITHDEF)
if test -z "$WITH_VAR" ; then WITH_VAR=`echo ifelse([$2], , no, [$2])` ; fi
if test "$WITH_VAR" != "no"; then
  VAR_WITH=    ; VAR_WITHOUT='#'
  case "$WITH_VAR" in
    [yes)]    VAR_WITHVAL=""
              VAR_WITHDEF="-D""VAR_WITH" ;;
    [*)]      VAR_WITHVAL=WITH_VAR
              VAR_WITHDEF="-D""VAR_WITH="'"'$WITH_VAR'"' ;;
  esac
else
  VAR_WITH='#' ;  VAR_WITHOUT=
  VAR_WITHVAL= ;  VAR_WITHDEF=
fi
if test "_$WITH_VAR" != "_no" ; then
      AC_DEFINE_UNQUOTED(VAR_WITH, "$WITH_VAR", "--with-$1")
fi dnl
popdef([VAR_WITH])dnl
popdef([VAR_WITHOUT])dnl
popdef([VAR_WITHVAL])dnl
popdef([VAR_WITHDEF])dnl
popdef([WITH_VAR])dnl
])
