# ===========================================================================
#       http://www.gnu.org/software/autoconf-archive/ax_check_glut.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_GLUT
#
# DESCRIPTION
#
#   Check for GLUT. If GLUT is found, the required compiler and linker flags
#   are included in the output variables "GLUT_CFLAGS" and "GLUT_LIBS",
#   respectively. If GLUT is not found, "no_glut" is set to "yes".
#
#   If the header "GL/glut.h" is found, "HAVE_GL_GLUT_H" is defined. If the
#   header "GLUT/glut.h" is found, HAVE_GLUT_GLUT_H is defined. These
#   preprocessor definitions may not be mutually exclusive.
#
#   You should use something like this in your headers:
#
#     # if HAVE_WINDOWS_H && defined(_WIN32)
#     #  include <windows.h>
#     # endif
#     # if defined(HAVE_GL_GLUT_H)
#     #  include <GL/glut.h>
#     # elif defined(HAVE_GLUT_GLUT_H)
#     #  include <GLUT/glut.h>
#     # else
#     #  error no glut.h
#     # endif
#
# LICENSE
#
#   Copyright (c) 2009 Braden McDaniel <braden@endoframe.com>
#   Copyright (c) 2013 Bastien Roucaries <roucaries.bastien+autoconf@gmail.com>
#   Copyright (c) 2016 Felix Chern <idryman@gmail.com>
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
#   Macro released by the Autoconf Archive. When you make and distribute a
#   modified version of the Autoconf Macro, you may extend this special
#   exception to the GPL to apply to your modified version as well.

#serial 14

AC_DEFUN([_AX_CHECK_GLUT_FLAGS_PUSH], [
 AX_SAVE_FLAGS_WITH_PREFIX([GLUT],[$1]) dnl defined in ax_check_gl
 AC_LANG_PUSH([C])
])

AC_DEFUN([_AX_CHECK_GLUT_FLAGS_POP], [
 AX_RESTORE_FLAGS_WITH_PREFIX([GLUT],[$1]) dnl defined in ax_check_gl
 AC_LANG_POP([C])
])

AC_DEFUN([_AX_CHECK_GLUT_SAVE_FLAGS], [
  AC_LANG_PUSH([C])
  ax_check_glut_saved_libs="${LIBS}"
  ax_check_glut_saved_cflags="${CFLAGS}"
])

dnl Default include : add windows.h
dnl see http://www.opengl.org/wiki/Platform_specifics:_Windows
dnl (acceded 20120801)
AC_DEFUN([_AX_CHECK_GLUT_INCLUDES_DEFAULT],dnl
[
  AC_INCLUDES_DEFAULT
  [
  # if defined(HAVE_WINDOWS_H) && defined(_WIN32)
  #   include <windows.h>
  # endif
  ]
])

m4_define([_AX_CHECK_GLUT_PROGRAM],
          [AC_LANG_PROGRAM([[
# if HAVE_WINDOWS_H && defined(_WIN32)
#   include <windows.h>
# endif
# ifdef HAVE_GL_GLUT_H
#   include <GL/glut.h>
# elif defined(HAVE_GLUT_GLUT_H)
#   include <GLUT/glut.h>
# else
#   error no glut.h
# endif]],
[[glutMainLoop()]])])


# dnl try to found library (generic case)
# dnl $1 is set to the library to found
AC_DEFUN([_AX_CHECK_GLUT_MANUAL_LIBS_GENERIC],
[dnl
 ax_check_glut_manual_libs_generic_extra_libs="$1"
 AS_IF([test "X$ax_check_glut_manual_libs_generic_extra_libs" = "X"],
       [AC_MSG_ERROR([AX_CHECK_GLUT_MANUAL_LIBS_GENERIC argument must no be empty])])

 _AX_CHECK_GLUT_FLAGS_PUSH([[CFLAGS],[LIBS]])
 AC_SEARCH_LIBS([glutMainLoop],[$ax_check_glut_manual_libs_generic_extra_libs],
                [ax_check_glut_lib_glut="yes"])
 AS_IF([test "X$ax_check_glut_lib_glut" = "Xyes"],
       [GLUT_LIBS="$ac_cv_search_glutMainLoop"])
 _AX_CHECK_GLUT_FLAGS_POP([[CFLAGS],[LIBS]])
])

# compile the example program
AC_DEFUN([_AX_CHECK_GLUT_COMPILE],
[dnl
 _AX_CHECK_GLUT_FLAGS_PUSH([CFLABS])
 AC_COMPILE_IFELSE([_AX_CHECK_GLUT_PROGRAM],
                   [ax_check_glut_compile_glut="yes"],
                   [ax_check_glut_compile_glut="no"])
 _AX_CHECK_GLUT_FLAGS_POP([CFLAGS])
])

# compile the example program (cache)
AC_DEFUN([_AX_CHECK_GLUT_COMPILE_CV],
[dnl
 AC_CACHE_CHECK([for compiling a minimal GLUT program],[ax_cv_check_glut_compile_glut],
                [_AX_CHECK_GLUT_COMPILE()
                 ax_cv_check_glut_compile_glut="${ax_check_glut_compile_glut}"])
 ax_check_glut_compile_glut="${ax_cv_check_glut_compile_glut}"
])

# link the example program
AC_DEFUN([_AX_CHECK_GLUT_LINK],
[dnl
 _AX_CHECK_GLUT_FLAGS_PUSH([[CFLAGS],[LIBS]])
 AC_LINK_IFELSE([_AX_CHECK_GLUT_PROGRAM],
                [ax_check_glut_link_glut="yes"],
                [ax_check_glut_link_glut="no"])
 _AX_CHECK_GLUT_FLAGS_POP([[CFLAGS],[LIBS]])
])

# link the example program (cache)
AC_DEFUN([_AX_CHECK_GLUT_LINK_CV],
[dnl
 AC_CACHE_CHECK([for linking a minimal GLUT program],[ax_cv_check_glut_link_glut],
                [_AX_CHECK_GLUT_LINK()
                 ax_cv_check_glut_link_glut="${ax_check_glut_link_glut}"])
 ax_check_glut_link_glut="${ax_cv_check_glut_link_glut}"
])


AC_DEFUN([_AX_CHECK_DARWIN_GLUT],
[AC_REQUIRE([_WITH_XQUARTZ_GL])
 AS_IF([test "x$with_xquartz" != "xno"],
       [XQUARTZ_DIR="${XQUARTZ_DIR:-/opt/X11}"
        AC_MSG_CHECKING([OSX X11 path])
        AS_IF([test -e "$XQUARTZ_DIR"], dnl then
              [AC_MSG_RESULT(["$XQUARTZ_DIR"])
               GLUT_CFLAGS="${GLUT_CFLAGS:--I$XQUARTZ_DIR/include}"
               GLUT_LIBS="${GLUT_LIBS:--L$XQUARTZ_DIR/lib -lGLUT}"
              ], dnl else
              [AC_MSG_RESULT([no])
               AC_MSG_WARN([--with-xquartz was given, but test for X11 failed. Fallback to system framework])
              ]
             ) dnl XQUARTZ_DIR
       ]) dnl test xquartz
 GLUT_LIBS="${GLUT_LIBS=--framework GLUT}"
])

AC_DEFUN([_AX_CHECK_GLUT_HEADER],[
  _AX_CHECK_GLUT_FLAGS_PUSH([CFLABS])
  AC_CHECK_HEADERS([$1],
                   [ax_check_glut_have_headers=yes])
  _AX_CHECK_GLUT_FLAGS_POP([CFLAGS])
])


AC_DEFUN([_AX_CHECK_GLUT_HEADER_GENERIC],[
  AC_REQUIRE([AC_CANONICAL_HOST])
  AS_CASE([${host}],
    [*-darwin*],[AS_IF([test "x$with_xquartz" = "xno"],
                       [_AX_CHECK_GLUT_HEADER([GLUT/glut.h])],
                       [_AX_CHECK_GLUT_HEADER([GL/glut.h])])],
    [_AX_CHECK_GLUT_HEADER([GL/glut.h])])
])


# AX_CHECK_GLUT_LIB([ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# ---------------------------------------------------------
#
# if ACTION-IF-FOUND is not provided, it will set CFLAGS and
# LIBS
AC_DEFUN([AX_CHECK_GLUT],
[AC_REQUIRE([AC_CANONICAL_HOST])
 AC_REQUIRE([PKG_PROG_PKG_CONFIG])
 AC_ARG_VAR([GLUT_CFLAGS],[C compiler flags for GLUT, overriding system check])
 AC_ARG_VAR([GLUT_LIBS],[linker flags for GLUT, overriding system check])
 AC_ARG_VAR([XQUARTZ_DIR],[XQuartz (X11) root on OSX @<:@/opt/X11@:>@])
 
 dnl --with-gl or not can be implemented outside of check-gl
 AS_CASE([${host}],
         [*-darwin*],[_AX_CHECK_DARWIN_GLUT],
         [*-cygwin*|*-mingw*],[
          GLUT_LIBS="${GLUT_LIBS:--lglut32}"
          AC_CHECK_HEADERS([windows.h])
          ],
         [_AX_CHECK_GLUT_MANUAL_LIBS_GENERIC([glut])
         ]) dnl host specific checks

 _AX_CHECK_GLUT_HEADER_GENERIC()

 AS_IF([test "X$ax_check_glut_have_headers" = "Xyes"],
       [_AX_CHECK_GLUT_COMPILE_CV()],
       [no_glut=yes])
 AS_IF([test "X$ax_check_glut_compile_glut" = "Xyes"],
       [_AX_CHECK_GLUT_LINK_CV()],
       [no_glut=yes])
 AS_IF([test "X$no_glut" = "X"],
   [m4_ifval([$1], 
     [$1],
     [CFLAGS="$GLUT_CFLAGS $CFLAGS"
      LIBS="$GLUT_LIBS $LIBS"])
   ],
   [$2])

])
