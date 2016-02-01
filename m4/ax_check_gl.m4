# ===========================================================================
#        http://www.gnu.org/software/autoconf-archive/ax_check_gl.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_GL
#
# DESCRIPTION
#
#   Check for an OpenGL implementation. If GL is found, the required
#   compiler and linker flags are included in the output variables
#   "GL_CFLAGS", "GL_LIBS", "GL_LDFLAGS", respectively. If no usable GL
#   implementation is found, "no_gl" is set to "yes".
#
#   You could disable OpenGL using --with-gl=no
#
#   You could choose a specific OpenGL libs using --with-gl=lib_name
#
#   Under darwin, cygwin and mingw target you could prefer the OpenGL
#   implementation that link with X setting --with-gl=x or without X support
#   with --with-gl=nox. Notes that this script try to guess the right
#   implementation.
#
#   If the header "GL/gl.h" is found, "HAVE_GL_GL_H" is defined. If the
#   header "OpenGL/gl.h" is found, HAVE_OPENGL_GL_H is defined. These
#   preprocessor definitions may not be mutually exclusive.
#
#   You should use something like this in your headers:
#
#     #if defined(HAVE_WINDOWS_H) && defined(_WIN32)
#     # include <windows.h>
#     #endif
#     #ifdef HAVE_GL_GL_H
#     # include <GL/gl.h>
#     #elif defined(HAVE_OPENGL_GL_H)
#     # include <OpenGL/gl.h>
#     #else
#     # error no gl.h
#     #endif
#
# LICENSE
#
#   Copyright (c) 2016 Felix Chern <idryman@gmail.com>
#   Copyright (c) 2009 Braden McDaniel <braden@endoframe.com>
#   Copyright (c) 2012 Bastien Roucaries <roucaries.bastien+autoconf@gmail.com>
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

#serial 17

m4_define([_AX_CHECK_GL_PROGRAM],
          [AC_LANG_PROGRAM([[
# if defined(HAVE_WINDOWS_H) && defined(_WIN32)
#   include <windows.h>
# endif
# ifdef HAVE_GL_GL_H
#   include <GL/gl.h>
# elif defined(HAVE_OPENGL_GL_H)
#   include <OpenGL/gl.h>
# else
#   error no gl.h
# endif
]],[[glBegin(0)]])])

dnl Default include : add windows.h
dnl see http://www.opengl.org/wiki/Platform_specifics:_Windows
dnl (acceded 20120801)
AC_DEFUN([_AX_CHECK_GL_INCLUDES_DEFAULT],dnl
[
  AC_INCLUDES_DEFAULT
  [
  # if defined(HAVE_WINDOWS_H) && defined(_WIN32)
  #   include <windows.h>
  # endif
  ]
])

m4_define([push_flag_with_prefix],[
m4_ifval([$2], [
_ax_[]m4_tolower($1)_saved_flag_[]m4_tolower(m4_car($2))="$m4_car($2)"
m4_car($2)="$$1_[]m4_car($2) $m4_car($2)"
$0($1, m4_cdr($2))
])])

m4_define([pop_flag_with_prefix],[
m4_ifval([$2], [
m4_car($2)="$_ax_[]m4_tolower($1)_saved_flag_[]m4_tolower(m4_car($2))"
$0($1, m4_cdr($2))])
])


AC_DEFUN([_AX_CHECK_GL_FLAGS_PUSH], [
 push_flag_with_prefix([GL],[$1])
 AC_LANG_PUSH([C])
])

AC_DEFUN([_AX_CHECK_GL_FLAGS_POP], [
 pop_flag_with_prefix([GL],[$1])
 AC_LANG_POP([C])
])

AC_DEFUN([_AX_CHECK_GL_COMPILE],
[dnl
 _AX_CHECK_GL_FLAGS_PUSH([CFLAGS])
 AC_COMPILE_IFELSE([_AX_CHECK_GL_PROGRAM],
                   [ax_check_gl_compile_opengl="yes"],
                   [ax_check_gl_compile_opengl="no"])
 _AX_CHECK_GL_FLAGS_POP([CFLAGS])
])

# compile the example program (cache)
AC_DEFUN([_AX_CHECK_GL_COMPILE_CV],
[dnl
 AC_CACHE_CHECK([for compiling a minimal OpenGL program],[ax_cv_check_gl_compile_opengl],
                [_AX_CHECK_GL_COMPILE()
                 ax_cv_check_gl_compile_opengl="${ax_check_gl_compile_opengl}"])
 ax_check_gl_compile_opengl="${ax_cv_check_gl_compile_opengl}"
])

# link the example program
AC_DEFUN([_AX_CHECK_GL_LINK],
[dnl
 _AX_CHECK_GL_FLAGS_PUSH([[CFLAGS],[LIBS]])
 AC_LINK_IFELSE([_AX_CHECK_GL_PROGRAM],
                [ax_check_gl_link_opengl="yes"],
                [ax_check_gl_link_opengl="no"])
 _AX_CHECK_GL_FLAGS_POP([[CFLAGS],[LIBS]])
])

# link the example program (cache)
AC_DEFUN([_AX_CHECK_GL_LINK_CV],
[dnl
 AC_CACHE_CHECK([for linking a minimal OpenGL program],[ax_cv_check_gl_link_opengl],
                [_AX_CHECK_GL_LINK()
                 ax_cv_check_gl_link_opengl="${ax_check_gl_link_opengl}"])
 ax_check_gl_link_opengl="${ax_cv_check_gl_link_opengl}"
])
#
# dnl try to found library (generic case)
# dnl $1 is set to the library to found
AC_DEFUN([_AX_CHECK_GL_MANUAL_LIBS_GENERIC], [
  AS_IF([test -n "$GL_LIBS"],[], [
    ax_check_gl_manual_libs_generic_extra_libs="$1"
    AS_IF([test "X$ax_check_gl_manual_libs_generic_extra_libs" = "X"],
          [AC_MSG_ERROR([AX_CHECK_GL_MANUAL_LIBS_GENERIC argument must no be empty])])

    _AX_CHECK_GL_FLAGS_PUSH([CFLAGS])
    AC_SEARCH_LIBS([glBegin],[$ax_check_gl_manual_libs_generic_extra_libs], [
                   ax_check_gl_lib_opengl="yes"
                   break
                   ])
    AS_IF([test "X$ax_check_gl_lib_opengl"="Xyes"],
          [GL_LIBS="${ac_cv_search_glBegin}"])
    _AX_CHECK_GL_FLAGS_POP([CFLAGS])
 ])
])

# setvar only when variable is unset
AC_DEFUN([_AX_GL_SETVAR], [
 AS_IF([test -n "$$1"], [], [$1=$2])])

AC_DEFUN_ONCE([_WITH_XQUARTZ_GL],[
  AC_ARG_WITH([xquartz],
   [AS_HELP_STRING([--with-xquartz@<:@=ARG@:>@],
                   [On Mac OSX, use opengl provided by X11 instead of built-in framework. @<:@ARG=no@:>@])],
   [],
   [with_xquartz=no]) dnl with-xquartz
])

AC_DEFUN([_AX_CHECK_DARWIN_GL], [ 
dnl TODO I think I can switch back to with-x
dnl opengl -> GL_CFLAGS += X_CFLAGS 
dnl           GL_LIBS += X_LIBS
dnl glut   -> use header GL/glut.h
dnl        -> use search lib -lglut
 AC_REQUIRE([_WITH_XQUARTZ_GL])
 AS_IF([test "x$with_xquartz" != "xno"],
       [_AX_GL_SETVAR([XQUARTZ_DIR],[/opt/X11])
        AC_MSG_CHECKING([OSX X11 path])
        AS_IF([test -e "$XQUARTZ_DIR"],
              dnl then
              [AC_MSG_RESULT(["$XQUARTZ_DIR"])
               _AX_GL_SETVAR([GL_CFLAGS],["-I$XQUARTZ_DIR/include"])
               _AX_GL_SETVAR([GL_LIBS],["-L$XQUARTZ_DIR/lib -lGL"])
              ],
              dnl else
              [AC_MSG_RESULT([no])
               AC_MSG_WARN([--with-xquartz was given, but test for X11 failed. Fallback to system framework])
              ]
             ) dnl XQUARTZ_DIR
       ]) dnl test xquartz
 _AX_GL_SETVAR([GL_LIBS],["-framework OpenGL"])
])


# AX_CHECK_GL_LIB([ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# ---------------------------------------------------------
#
# if ACTION-IF-FOUND is not provided, it will set CFLAGS and
# LIBS
AC_DEFUN([AX_CHECK_GL],
[AC_REQUIRE([AC_CANONICAL_HOST])
 AC_REQUIRE([PKG_PROG_PKG_CONFIG])
 AC_ARG_VAR([GL_CFLAGS],[C compiler flags for GL, overriding system check])
 AC_ARG_VAR([GL_LIBS],[linker flags for GL, overriding system check])
 AC_ARG_VAR([XQUARTZ_DIR],[XQuartz (X11) root on OSX @<:@/opt/X11@:>@])
 
 dnl --with-gl or not can be implemented outside of check-gl
 AS_CASE([${host}],
         [*-darwin*],[_AX_CHECK_DARWIN_GL],
         dnl some windows may support X11 opengl, and should be able to linked
         dnl by -lGL. However I have no machine to test it.
         [*-cygwin*|*-mingw*],[
          _AX_CHECK_GL_MANUAL_LIBS_GENERIC([opengl32 GL gl])
          AC_CHECK_HEADERS([windows.h])
          ],
         [PKG_PROG_PKG_CONFIG
          PKG_CHECK_MODULES([GL],[gl],
          [],
          [_AX_CHECK_GL_MANUAL_LIBS_GENERIC([GL gl])])
         ]) dnl host specific checks

 dnl this was cache
 _AX_CHECK_GL_FLAGS_PUSH([CFLAGS])
 AC_CHECK_HEADERS([GL/gl.h OpenGL/gl.h],
   [ax_check_gl_have_headers="yes";break])
 _AX_CHECK_GL_FLAGS_POP([CFLAGS])

 AS_IF([test "X$ax_check_gl_have_headers" = "Xyes"],
       [_AX_CHECK_GL_COMPILE_CV()],
       [no_gl=yes])
 AS_IF([test "X$ax_check_gl_compile_opengl" = "Xyes"],
       [_AX_CHECK_GL_LINK_CV()],
       [no_gl=yes])
 AS_IF([test "X$no_gl" = "X"],
   [m4_ifval([$1], 
     [$1],
     [CFLAGS="$GL_CFLAGS $CFLAGS"
      LIBS="$GL_LIBS $LIBS"])
   ],
   [$2])

])
