##### http://autoconf-archive.cryp.to/ag_check_strftime.html
#
# SYNOPSIS
#
#   AG_CHECK_STRFTIME
#
# DESCRIPTION
#
#   Check for existence and functioning of strftime routine.
#
# LAST MODIFICATION
#
#   2001-12-01
#
# COPYLEFT
#
#   Copyright (c) 2001 Bruce Korb <bkorb@gnu.org>
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

AC_DEFUN([AG_CHECK_STRFTIME],[
  AC_MSG_CHECKING([whether strftime() works])
  AC_CACHE_VAL([ag_cv_strftime],[
  AC_TRY_RUN([#include <time.h>
char t_buf[ 64 ];
int main() {
  static const char z[] = "Thursday Aug 28 240";
  struct tm tm;
  tm.tm_sec   = 36;  /* seconds after the minute [0, 61]  */
  tm.tm_min   = 44;  /* minutes after the hour [0, 59] */
  tm.tm_hour  = 12;  /* hour since midnight [0, 23] */
  tm.tm_mday  = 28;  /* day of the month [1, 31] */
  tm.tm_mon   =  7;  /* months since January [0, 11] */
  tm.tm_year  = 86;  /* years since 1900 */
  tm.tm_wday  =  4;  /* days since Sunday [0, 6] */
  tm.tm_yday  = 239; /* days since January 1 [0, 365] */
  tm.tm_isdst =  1;  /* flag for daylight savings time */
  strftime( t_buf, sizeof( t_buf ), "%A %b %d %j", &tm );
  return (strcmp( t_buf, z ) != 0); }],[ag_cv_strftime=yes],[ag_cv_strftime=no],[ag_cv_strftime=no]
  ) # end of TRY_RUN]) # end of CACHE_VAL

  AC_MSG_RESULT([$ag_cv_strftime])
  if test x$ag_cv_strftime = xyes
  then
    AC_DEFINE(HAVE_STRFTIME, 1,
       [Define this if strftime() works])
  fi
]) # end of AC_DEFUN of AG_CHECK_STRFTIME
