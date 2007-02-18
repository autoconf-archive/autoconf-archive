##### http://autoconf-archive.cryp.to/ac_func_vsnprintf.html
#
# OBSOLETE MACRO
#
#   Use AC_FUNC_SNPRINTF.
#
# SYNOPSIS
#
#   AC_FUNC_VSNPRINTF
#
# DESCRIPTION
#
#   Check whether there is a reasonably sane vsnprintf() function
#   installed. "Reasonably sane" in this context means never clobbering
#   memory beyond the buffer supplied, and having a sensible return
#   value. It is explicitly allowed not to NUL-terminate the return
#   value, however.
#
# LAST MODIFICATION
#
#   2005-01-25
#
# COPYLEFT
#
#   Copyright (c) 2005 Gaute Strokkenes <gs234@cam.ac.uk>
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

AC_DEFUN([AC_FUNC_VSNPRINTF],
[AC_CACHE_CHECK(for working vsnprintf,
  ac_cv_func_vsnprintf,
[AC_TRY_RUN(
[#include <stdio.h>
#include <stdarg.h>

int
doit(char * s, ...)
{
  char buffer[32];
  va_list args;
  int r;

  buffer[5] = 'X';

  va_start(args, s);
  r = vsnprintf(buffer, 5, s, args);
  va_end(args);

  /* -1 is pre-C99, 7 is C99. */

  if (r != -1 && r != 7)
    exit(1);

  /* We deliberately do not care if the result is NUL-terminated or
     not, since this is easy to work around like this.  */

  buffer[4] = 0;

  /* Simple sanity check.  */

  if (strcmp(buffer, "1234"))
    exit(1);

  if (buffer[5] != 'X')
    exit(1);

  exit(0);
}

int
main(void)
{
  doit("1234567");
  exit(1);
}], ac_cv_func_vsnprintf=yes, ac_cv_func_vsnprintf=no, ac_cv_func_vsnprintf=no)])
dnl Note that the default is to be pessimistic in the case of cross compilation.
dnl If you know that the target has a sensible vsnprintf(), you can get around this
dnl by setting ac_func_vsnprintf to yes, as described in the Autoconf manual.
if test $ac_cv_func_vsnprintf = yes; then
  AC_DEFINE(HAVE_WORKING_VSNPRINTF, 1,
            [Define if you have a version of the `vsnprintf' function
             that honours the size argument and has a proper return value.])
fi
])# AC_FUNC_VSNPRINTF
