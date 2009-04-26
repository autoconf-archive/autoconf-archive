# ===========================================================================
#              http://autoconf-archive.cryp.to/ac_lib_upnp.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_LIB_UPNP([ACTION-IF-TRUE], [ACTION-IF-FALSE])
#
# DESCRIPTION
#
#   This macro will check for the existence of libupnp
#   (http://upnp.sourceforge.net/). It does this by checking for the header
#   file upnp.h and the upnp library object file. A --with-libupnp option is
#   supported as well. The following output variables are set with AC_SUBST:
#
#     UPNP_CPPFLAGS
#     UPNP_LDFLAGS
#     UPNP_LIBS
#
#   You can use them like this in Makefile.am:
#
#     AM_CPPFLAGS = $(UPNP_CPPFLAGS)
#     AM_LDFLAGS = $(UPNP_LDFLAGS)
#     program_LDADD = $(UPNP_LIBS)
#
#   Additionally, the C preprocessor symbol HAVE_LIBUPNP will be defined
#   with AC_DEFINE if libupnp is available.
#
# LICENSE
#
#   Copyright (c) 2008 Oskar Liljeblad <oskar@osk.mine.nu>
#
#   This program is free software: you can redistribute it and/or modify it
#   under the terms of the GNU General Public License as published by the
#   Free Software Foundation, either version 3 of the License, or (at your
#   option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
#   Public License for more details.
#
#   You should have received a copy of the GNU General Public License along
#   with this program. If not, see <http://www.gnu.org/licenses/>.

AC_DEFUN([AC_LIB_UPNP], [
  AH_TEMPLATE([HAVE_LIBUPNP], [Define if libupnp is available])
  AC_ARG_WITH(libupnp, [  --with-libupnp=DIR      prefix for upnp library files and headers], [
    if test "$withval" = "no"; then
      ac_upnp_path=
      $2
    elif test "$withval" = "yes"; then
      ac_upnp_path=/usr
    else
      ac_upnp_path="$withval"
    fi
  ],[ac_upnp_path=/usr])
  if test "$ac_upnp_path" != ""; then
    saved_CPPFLAGS="$CPPFLAGS"
    CPPFLAGS="$CPPFLAGS -I$ac_upnp_path/include/upnp"
    AC_CHECK_HEADER([upnp.h], [
      saved_LDFLAGS="$LDFLAGS"
      LDFLAGS="$LDFLAGS -L$ac_upnp_path/lib"
      AC_CHECK_LIB(upnp, UpnpInit, [
        AC_SUBST(UPNP_CPPFLAGS, [-I$ac_upnp_path/include/upnp])
        AC_SUBST(UPNP_LDFLAGS, [-L$ac_upnp_path/lib])
        AC_SUBST(UPNP_LIBS, [-lupnp])
	AC_DEFINE([HAVE_LIBUPNP])
        $1
      ], [
	:
        $2
      ])
      LDFLAGS="$saved_LDFLAGS"
    ], [
      AC_MSG_RESULT([not found])
      $2
    ])
    CPPFLAGS="$saved_CPPFLAGS"
  fi
])
