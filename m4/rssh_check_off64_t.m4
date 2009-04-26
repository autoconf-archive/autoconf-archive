# ===========================================================================
#           http://autoconf-archive.cryp.to/rssh_check_off64_t.html
# ===========================================================================
#
# SYNOPSIS
#
#   RSSH_CHECK_OFF64_T
#
# DESCRIPTION
#
#   Check if off64_t is defined. On true define HAVE_OFF64_T, also define
#   __LARGEFILE64_SOURCE where one is needed. (Note that an appropriative
#   entry must be in config.h.in.)
#
# LICENSE
#
#   Copyright (c) 2008 Ruslan Shevchenko <Ruslan@Shevchenko.Kiev.UA>
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU Lesser General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or (at
#   your option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
#   General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public License
#   along with this program. If not, see <http://www.gnu.org/licenses/>.

AC_DEFUN([RSSH_CHECK_OFF64_T], [
AC_REQUIRE([AC_SYS_LARGEFILE])dnl
AC_CHECK_HEADER(unistd.h)
AC_CACHE_CHECK([whether type off64_t support],
               [rssh_cv_check_off64_t],
 [
  AC_COMPILE_IFELSE(
AC_LANG_SOURCE([
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
extern off64_t x1;
])
,rssh_have_off64t=1)
  if test "x$rssh_have_off64t" = "x"
   then
  AC_COMPILE_IFELSE(
AC_LANG_SOURCE([
#define _LARGEFILE64_SOURCE
#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif
extern off64_t x1;
]),
 rssh_cv_check_off64_t="_LARGEFILE64_SOURCE",
 rssh_cv_check_off64_t="no"
)dnl

   else
    rssh_cv_check_off64_t=yes
   fi
 ])dnl

if test "x$rssh_cv_check_off64_t" = "x_LARGEFILE64_SOURCE"
then
 AC_DEFINE(_LARGEFILE64_SOURCE)
 AC_DEFINE(HAVE_OFF64_T)
elif test "x$rssh_cv_check_off64_t" = "xyes"
then
 AC_DEFINE(HAVE_OFF64_T)
fi
])dnl
