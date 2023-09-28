# ===============================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_func_which_gethostent_r.html
# ===============================================================================
#
# SYNOPSIS
#
#   AX_FUNC_WHICH_GETHOSTENT_R
#
# DESCRIPTION
#
#   Determines which historical variant of the gethostent_r() call (taking
#   two, four or five arguments) is available on the system and defines one
#   of the following macros accordingly:
#
#     HAVE_FUNC_GETHOSTENT_R_5
#     HAVE_FUNC_GETHOSTENT_R_4
#     HAVE_FUNC_GETHOSTENT_R_2
#
#   as well as
#
#     HAVE_GETHOSTENT_R
#
# LICENSE
#
#   Copyright (c) 2023 Bogdan Drozdowski <bogdro@users.sourceforge.net>
#   Copyright (c) 2008 Caolan McNamara <caolan@skynet.ie>
#   Copyright (c) 2008 Daniel Richard G. <skunk@iskunk.org>
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

#serial 2

AC_DEFUN([AX_FUNC_WHICH_GETHOSTENT_R], [

    AC_LANG_PUSH([C])
    AC_MSG_CHECKING([how many arguments gethostent_r() takes])

    AC_CACHE_VAL([ac_cv_func_which_gethostent_r], [

################################################################

ac_cv_func_which_gethostent_r=unknown

#
# ONE ARGUMENT (sanity check)
#

# This should fail, as there is no variant of gethostent_r() that takes
# a single argument. If it actually compiles, then we can assume that
# netdb.h is not declaring the function, and the compiler is thereby
# assuming an implicit prototype. In which case, we're out of luck.
#
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([#include <netdb.h>],
        [
            char *name = "www.gnu.org";
            (void)gethostent_r(name) /* ; */
        ])],
    [ac_cv_func_which_gethostent_r=no])

#
# FIVE ARGUMENTS
# (e.g. Linux)
#

if test "$ac_cv_func_which_gethostent_r" = "unknown"; then

AC_COMPILE_IFELSE([AC_LANG_PROGRAM([#include <netdb.h>],
        [
            struct hostent ret, *retp;
            char buf@<:@1024@:>@;
            int buflen = 1024;
            int my_h_errno;
            (void)gethostent_r(&ret, buf, buflen, &retp, &my_h_errno) /* ; */
        ])],
    [ac_cv_func_which_gethostent_r=five])

fi

#
# FOUR ARGUMENTS
# (e.g. Solaris)
#

if test "$ac_cv_func_which_gethostent_r" = "unknown"; then

AC_COMPILE_IFELSE([AC_LANG_PROGRAM([#include <netdb.h>],
        [
            struct hostent ret, *retp;
            char buf@<:@1024@:>@;
            int buflen = 1024;
            int my_h_errno;
            (void)gethostent_r(&ret, buf, buflen, &my_h_errno) /* ; */
        ])],
    [ac_cv_func_which_gethostent_r=four])

fi

#
# TWO ARGUMENTS
# (e.g. AIX)
#

if test "$ac_cv_func_which_gethostent_r" = "unknown"; then

AC_COMPILE_IFELSE([AC_LANG_PROGRAM([#include <netdb.h>],
        [
            struct hostent ret;
            struct hostent_data data;
            (void)gethostent_r(&ret, &data) /* ; */
        ])],
    [ac_cv_func_which_gethostent_r=two])

fi

################################################################

]) dnl end AC_CACHE_VAL

case "$ac_cv_func_which_gethostent_r" in
    five|four|two)
    AC_DEFINE([HAVE_GETHOSTENT_R], [1],
              [Define to 1 if you have some form of gethostent_r().])
    ;;
esac

case "$ac_cv_func_which_gethostent_r" in
    five)
    AC_MSG_RESULT([five])
    AC_DEFINE([HAVE_FUNC_GETHOSTENT_R_5], [1],
              [Define to 1 if you have the five-argument form of gethostent_r().])
    ;;

    four)
    AC_MSG_RESULT([four])
    AC_DEFINE([HAVE_FUNC_GETHOSTENT_R_4], [1],
              [Define to 1 if you have the four-argument form of gethostent_r().])
    ;;

    two)
    AC_MSG_RESULT([two])
    AC_DEFINE([HAVE_FUNC_GETHOSTENT_R_2], [1],
              [Define to 1 if you have the two-argument form of gethostent_r().])
    ;;

    no)
    AC_MSG_RESULT([cannot find function declaration in netdb.h])
    ;;

    unknown)
    AC_MSG_RESULT([unknown])
    ;;

    *)
    AC_MSG_ERROR([internal error])
    ;;
esac

AC_LANG_POP

]) dnl end AC_DEFUN
