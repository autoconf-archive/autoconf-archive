# ===========================================================================
#      https://www.gnu.org/software/autoconf-archive/ax_check_class.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_CLASS
#
# DESCRIPTION
#
#   AX_CHECK_CLASS tests the existence of a given Java class, either in a
#   jar or in a '.class' file.
#
#   *Warning*: its success or failure can depend on a proper setting of the
#   CLASSPATH env. variable.
#
#   Note: This is part of the set of autoconf M4 macros for Java programs.
#   It is VERY IMPORTANT that you download the whole set, some macros depend
#   on other. Unfortunately, the autoconf archive does not support the
#   concept of set of macros, so I had to break it for submission. The
#   general documentation, as well as the sample configure.in, is included
#   in the AX_PROG_JAVA macro.
#
# BUGS
#
#   (1) The cache check names ax_cv_class_CLASS, but the test writes
#   ac_cv_class_CLASS, so the result is never cached and the check runs
#   again every time. Since the caller's actions run inside the cache body,
#   fixing only the name would make cached runs skip them. [Rating: minor]
#
#   (2) HAVE_CLASS is assigned from ac_cv_class_yes or ac_cv_class_no
#   instead of from the class-specific result, so it is always empty. It is
#   not documented or used elsewhere; HAVE_LAST_CLASS is set correctly.
#   [Rating: minor]
#
#   (3) Private shell variables such as ac_var_name and ac_var_val lack an
#   ax_ prefix. They share configure's shell namespace with callers and
#   other macros, so they may collide with variables of the same name. These
#   variables should use macro-specific ax_ names. [Rating: minor]
#
# LICENSE
#
#   Copyright (c) 2008 Stephane Bortzmeyer <bortzmeyer@pasteur.fr>
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

#serial 13

AU_ALIAS([AC_CHECK_CLASS], [AX_CHECK_CLASS])
AC_DEFUN([AX_CHECK_CLASS],[
AC_REQUIRE([AX_PROG_JAVA])
ac_var_name=`echo $1 | sed 's/\./_/g'`
dnl Normally I'd use a AC_CACHE_CHECK here but since the variable name is
dnl dynamic I need an extra level of extraction
AC_MSG_CHECKING([for $1 class])
AC_CACHE_VAL(ax_cv_class_$ac_var_name, [
        AX_TRY_COMPILE_JAVA([$1], , [eval "ac_cv_class_$ac_var_name=yes"],
                [eval "ac_cv_class_$ac_var_name=no"])
eval "ac_var_val=$`eval echo ac_cv_class_$ac_var_name`"
eval "HAVE_$ac_var_name=$`echo ac_cv_class_$ac_var_val`"
HAVE_LAST_CLASS=$ac_var_val
if test x$ac_var_val = xyes; then
        ifelse([$2], , :, [$2])
else
        ifelse([$3], , :, [$3])
fi
])
dnl for some reason the above statement didn't fall though here?
dnl do scripts have variable scoping?
eval "ac_var_val=$`eval echo ac_cv_class_$ac_var_name`"
AC_MSG_RESULT($ac_var_val)
])
