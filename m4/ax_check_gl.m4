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

dnl local save flags
AC_DEFUN([_AX_CHECK_GL_SAVE_FLAGS],
[dnl
ax_check_gl_saved_libs="${LIBS}"
ax_check_gl_saved_cflags="${CFLAGS}"
ax_check_gl_saved_cppflags="${CPPFLAGS}"
ax_check_gl_saved_ldflags="${LDFLAGS}"
])

dnl local restore flags
AC_DEFUN([_AX_CHECK_GL_RESTORE_FLAGS],
[dnl
LIBS="${ax_check_gl_saved_libs}"
CFLAGS="${ax_check_gl_saved_cflags}"
CPPFLAGS="${ax_check_gl_saved_cppflags}"
LDFLAGS="${ax_check_gl_saved_ldflags}"
])

dnl default switch case failure
AC_DEFUN([_AX_CHECK_MSG_FAILURE_ORDER],
[dnl
 AC_MSG_FAILURE([Order logic in ax_check_gl is buggy])
])

# set the varible ax_check_gl_need_x
# this variable determine if we need opengl that link with X
# value are default aka try the first library wether if it link or not with x
# yes that means we need a opengl with x
# no that means we do not need an opengl with x
AC_DEFUN([_AX_CHECK_GL_NEED_X],
[dnl
 # do not check if empty : allow a subroutine to modify the choice
 AS_IF([test "X$ax_check_gl_need_x" = "X"],
       [ax_check_gl_need_x="default"
        AS_IF([test "X$no_x" = "Xyes"],[ax_check_gl_need_x="no"])
        AS_IF([test "X$ax_check_gl_want_gl" = "Xnox"],[ax_check_gl_need_x="no"])
        AS_IF([test "X$ax_check_gl_want_gl" = "Xx"],[ax_check_gl_need_x="yes"])])
])

# compile the example program
AC_DEFUN([_AX_CHECK_GL_COMPILE],
[dnl
 AC_LANG_PUSH([C])
 _AX_CHECK_GL_SAVE_FLAGS()
 CFLAGS="${GL_CFLAGS} ${CFLAGS}"
 AC_COMPILE_IFELSE([_AX_CHECK_GL_PROGRAM],
                   [ax_check_gl_compile_opengl="yes"],
                   [ax_check_gl_compile_opengl="no"])
 _AX_CHECK_GL_RESTORE_FLAGS()
 AC_LANG_POP([C])
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
 AC_LANG_PUSH([C])
 _AX_CHECK_GL_SAVE_FLAGS()
 CFLAGS="${GL_CFLAGS} ${CFLAGS}"
 LIBS="${GL_LIBS} ${LIBS}"
 LDFLAGS="${GL_LDFLAGS} ${LDFLAGS}"
 AC_LINK_IFELSE([_AX_CHECK_GL_PROGRAM],
                [ax_check_gl_link_opengl="yes"],
                [ax_check_gl_link_opengl="no"])
 _AX_CHECK_GL_RESTORE_FLAGS()
 AC_LANG_POP([C])
])

# link the example program (cache)
AC_DEFUN([_AX_CHECK_GL_LINK_CV],
[dnl
 AC_CACHE_CHECK([for linking a minimal OpenGL program],[ax_cv_check_gl_link_opengl],
                [_AX_CHECK_GL_LINK()
                 ax_cv_check_gl_link_opengl="${ax_check_gl_link_opengl}"])
 ax_check_gl_link_opengl="${ax_cv_check_gl_link_opengl}"
])

dnl Check headers manually (default case)
AC_DEFUN([_AX_CHECK_GL_MANUAL_HEADERS_DEFAULT],
[AC_REQUIRE([AC_PATH_XTRA])
 AC_LANG_PUSH([C])
 _AX_CHECK_GL_SAVE_FLAGS()
 CFLAGS="${GL_CFLAGS} ${CFLAGS}"
 # see comment in _AX_CHECK_GL_INCLUDES_DEFAULT
 AC_CHECK_HEADERS([windows.h],[],[],[AC_INCLUDES_DEFAULT])
 # FIXME: use extra cflags
 AC_CHECK_HEADERS([GL/gl.h],[ax_check_gl_have_headers="yes"],
                            [ax_check_gl_have_headers_headers="no"],
			    [_AX_CHECK_GL_INCLUDES_DEFAULT()])
 # do not try darwin specific OpenGl/gl.h
 _AX_CHECK_GL_RESTORE_FLAGS()
 AC_LANG_POP([C])
])

# darwin headers without X
AC_DEFUN([_AX_CHECK_GL_MANUAL_HEADERS_DARWIN_NOX],[
 AC_LANG_PUSH([C])
 _AX_CHECK_GL_SAVE_FLAGS()
 AC_CHECK_HEADERS([OpenGL/gl.h],[ax_check_gl_have_headers="yes"],
                                [ax_check_gl_have_headers="no"],
			        [_AX_CHECK_GL_INCLUDES_DEFAULT()])
 _AX_CHECK_GL_RESTORE_FLAGS()
 AC_LANG_POP([C])
])

# check header for darwin
AC_DEFUN([_AX_CHECK_GL_MANUAL_HEADERS_DARWIN],
[AC_REQUIRE([_AX_CHECK_GL_NEED_X])
 AS_CASE(["$ax_check_gl_order"],
         # try to use framework
         ["gl"],[_AX_CHECK_GL_MANUAL_HEADERS_DARWIN_NOX()],
	 # try to use framework then mesa (X)
	 ["gl mesagl"],[
	   _AX_CHECK_GL_MANUAL_HEADERS_DARWIN_NOX()
	   AS_IF([test "X$ax_check_gl_have_headers" = "Xyes"],
	         [ax_check_gl_order="gl"
		  ax_check_gl_need_x="yes"],
		 [ax_check_gl_order="mesagl gl"
		  ax_check_gl_need_x="no"]
		  # retry with general test
		  _AX_CHECK_GL_MANUAL_HEADERS_DEFAULT())],
         ["mesagl gl"],[
	   _AX_CHECK_GL_MANUAL_HEADERS_DEFAULT()
	   AS_IF([test "X$ax_check_gl_have_headers" = "Xyes"],
	         [ax_check_gl_order="mesagl gl"
		  ax_check_gl_need_x="no"],
		 [ax_check_gl_order="gl"
		  ax_check_gl_need_x="yes"
		  # retry with framework
		  _AX_CHECK_GL_MANUAL_HEADERS_DARWIN_NOX()])],
        [_AX_CHECK_MSG_FAILURE_ORDER()])
])

dnl Check headers manually: subroutine must set ax_check_gl_have_headers={yes,no}
AC_DEFUN([_AX_CHECK_GL_MANUAL_HEADERS],
[AC_REQUIRE([AC_CANONICAL_HOST])
 AS_CASE([${host}],
         [*-darwin*],[_AX_CHECK_GL_MANUAL_HEADERS_DARWIN()],
	 [_AX_CHECK_GL_MANUAL_HEADERS_DEFAULT()])
 AC_CACHE_CHECK([for OpenGL headers],[ax_cv_check_gl_have_headers],
               	[ax_cv_check_gl_have_headers="${ax_check_gl_have_headers}"])
])

# dnl try to found library (generic case)
# dnl $1 is set to the library to found
AC_DEFUN([_AX_CHECK_GL_MANUAL_LIBS_GENERIC],
[dnl
 ax_check_gl_manual_libs_generic_extra_libs="$1"
 AS_IF([test "X$ax_check_gl_manual_libs_generic_extra_libs" = "X"],
       [AC_MSG_ERROR([AX_CHECK_GL_MANUAL_LIBS_GENERIC argument must no be empty])])

 AC_LANG_PUSH([C])
 _AX_CHECK_GL_SAVE_FLAGS()
 CFLAGS="${GL_CFLAGS} ${CFLAGS}"
 LIBS="${GL_LIBS} ${LIBS}"
 AC_SEARCH_LIBS([glBegin],[$ax_check_gl_manual_libs_generic_extra_libs],
                [ax_check_gl_lib_opengl="yes"],
                [ax_check_gl_lib_opengl="no"])
 AS_CASE([$ac_cv_search_glBegin],
         ["none required"],[],
 	 [no],[],
 	 [GL_LIBS="${ac_cv_search_glBegin} ${GL_LIBS}"])
  _AX_CHECK_GL_RESTORE_FLAGS()
  AC_LANG_PUSH([C])
])

# dnl try to found lib under darwin
# darwin opengl hack
# see http://web.archive.org/web/20090410052741/http://developer.apple.com/qa/qa2007/qa1567.html
# and http://web.eecs.umich.edu/~sugih/courses/eecs487/glut-howto/
dnl need to rewrite this whole thing
AC_DEFUN([_AX_CHECK_GL_MANUAL_LIBS_DARWIN],
[# ldhack list
 AC_CHECK_FILE([/System/Library/Frameworks/OpenGL.framework],
               [ax_check_gl_lib_opengl="yes"
                GL_LDFLAGS="-framework OpenGL ${GL_LDFLAGS}"],
               [ax_check_gl_lib_opengl="no"])

 dnl ldhack1="-Wl,-framework,OpenGL"
 dnl ldhack2="-Wl,-dylib_file,/System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGL.dylib:/System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGL.dylib"
 dnl ldhack3="$ldhack1,$ldhack2"

 dnl # select hack
 dnl AS_IF([test "X$ax_check_gl_need_x" = "Xno"],
 dnl       [# libs already set by -framework cflag
 dnl        darwinlibs=""
 dnl        ldhacks="$ldhack1 $ldhack2 $ldhack3"],
 dnl       [# do not use framework ldflags in case of x version
 dnl        darwinlibs="GL gl MesaGL"
 dnl        ldhacks="$ldhack2"])

 dnl ax_check_gl_link_opengl="no"
 dnl for extralibs in " " $darwinlibs; do
 dnl   for extraldflags in " " $ldhacks; do
 dnl       AC_LANG_PUSH([C])
 dnl        _AX_CHECK_GL_SAVE_FLAGS()
 dnl       CFLAGS="${GL_CFLAGS} ${CFLAGS}"
 dnl       LIBS="$extralibs ${GL_LIBS} ${LIBS}"
 dnl       LDFLAGS="$extraldflags ${GL_LDFLAGS} ${LDFLAGS}"
 dnl       AC_MSG_CHECKING([CFLAGS])
 dnl       AC_MSG_RESULT(["${CFLAGS}"])
 dnl       AC_MSG_CHECKING([LIBS])
 dnl       AC_MSG_RESULT(["${LIBS}"])
 dnl       AC_MSG_CHECKING([LDFLAGS])
 dnl       AC_MSG_RESULT(["${LDFLAGS}"])
 dnl       AC_LINK_IFELSE([_AX_CHECK_GL_PROGRAM],
 dnl                      [ax_check_gl_link_opengl="yes"
 dnl                       ax_check_gl_lib_opengl="yes"]
 dnl                      [ax_check_gl_link_opengl="no"
 dnl                       ax_check_gl_lib_opengl="no"])
 dnl       _AX_CHECK_GL_RESTORE_FLAGS()
 dnl       AC_LANG_POP([C])
 dnl       AS_IF([test "X$ax_check_gl_link_opengl" = "Xyes"],[
 dnl       AC_MSG_NOTICE([found linked gl])
 dnl       break])
 dnl   done;
 dnl   AS_IF([test "X$ax_check_gl_link_opengl" = "Xyes"],[break])
 dnl done;
 dnl GL_LIBS="$extralibs ${GL_LIBS}"
 dnl GL_LDFLAGS="$extraldflags ${GL_LDFLAGS}"
])

dnl Check library manually: subroutine must set
dnl $ax_check_gl_lib_opengl={yes,no}
AC_DEFUN([_AX_CHECK_GL_MANUAL_LIBS],
[AC_REQUIRE([AC_CANONICAL_HOST])
 AS_CASE([${host}],
         [*-darwin*],[_AX_CHECK_GL_MANUAL_LIBS_DARWIN()],
         # try first cygwin version
         [*-cygwin*|*-mingw*],[
	   AS_CASE(["$ax_check_gl_order"],
	           ["gl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([opengl32])],
		   ["gl mesagl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([opengl32 GL gl MesaGL])],
		   ["mesagl gl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([GL gl MesaGL opengl32])],
		   [_AX_CHECK_MSG_FAILURE_ORDER()])],
	 [AS_CASE(["$ax_check_gl_order"],
                  ["gl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([GL gl])],
		  ["gl mesagl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([GL gl MesaGL])],
		  ["mesagl gl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([MesaGL GL gl])],
		  [_AX_CHECK_MSG_FAILURE_ORDER()])]
		  )

 AC_CACHE_CHECK([for OpenGL libraries],[ax_cv_check_gl_lib_opengl],
               	[ax_cv_check_gl_lib_opengl="${ax_check_gl_lib_opengl}"])
 ax_check_gl_lib_opengl="${ax_cv_check_gl_lib_opengl}"
])

# manually check aka old way
AC_DEFUN([_AX_CHECK_GL_MANUAL],
[AC_REQUIRE([AC_CANONICAL_HOST])dnl
 AC_REQUIRE([AC_PATH_XTRA])dnl

 no_gl="yes"

 _AX_CHECK_GL_MANUAL_HEADERS()
 AS_IF([test "X$ax_check_gl_have_headers" = "Xyes"],
       [_AX_CHECK_GL_COMPILE_CV()],
       [ax_check_gl_compile_opengl=no])

 AS_IF([test "X$ax_check_gl_compile_opengl" = "Xyes"],
       [_AX_CHECK_GL_MANUAL_LIBS],
       [ax_check_gl_lib_opengl=no])

 AS_IF([test "X$ax_check_gl_lib_opengl" = "Xyes"],
       [_AX_CHECK_GL_LINK_CV()],
       [ax_check_gl_link_opengl=no])

 AS_IF([test "X$ax_check_gl_link_opengl" = "Xyes"],
       [no_gl="no"],
       [no_gl="yes"])
])dnl


# try to test using pkgconfig: set ax_check_gl_pkg_config=no if not found
AC_DEFUN([_AX_CHECK_GL_PKG_CONFIG],dnl
[dnl
 AC_REQUIRE([PKG_PROG_PKG_CONFIG])

 dnl First try mesagl
 AS_CASE(["$ax_check_gl_order"],
         ["gl"],[PKG_CHECK_MODULES([GL],[mesagl],
	                  [ax_check_gl_pkg_config=yes],
			  [ax_check_gl_pkg_config=no])],
	 ["gl mesagl"],[PKG_CHECK_MODULES([GL],[gl],
	                  [ax_check_gl_pkg_config=yes],
			  [PKG_CHECK_MODULES([GL],[mesagl],
	                         [ax_check_gl_pkg_config=yes],
				 [ax_check_gl_pkg_config=no])])],
	 ["mesagl gl"],[PKG_CHECK_MODULES([GL],[mesagl],
	                  [ax_check_gl_pkg_config=yes],
			  [PKG_CHECK_MODULES([GL],[gl],
	                         [ax_check_gl_pkg_config=yes],
				 [ax_check_gl_pkg_config=no])])],
	 [_AX_CHECK_MSG_FAILURE_ORDER])

 AS_IF([test "X$ax_check_gl_pkg_config" = "Xyes"],[
        # check headers
        AC_LANG_PUSH([C])
 	_AX_CHECK_GL_SAVE_FLAGS()
        CFLAGS="${GL_CFLAGS} ${CFLAGS}"
        AC_CHECK_HEADERS([windows.h],[],[],[AC_INCLUDES_DEFAULT])
        AC_CHECK_HEADERS([GL/gl.h OpenGL/gl.h],
                         [ax_check_gl_have_headers="yes";break],
                         [ax_check_gl_have_headers_headers="no"],
			 [_AX_CHECK_GL_INCLUDES_DEFAULT()])
        _AX_CHECK_GL_RESTORE_FLAGS()
	AC_LANG_POP([C])
	AC_CACHE_CHECK([for OpenGL headers],[ax_cv_check_gl_have_headers],
               	       [ax_cv_check_gl_have_headers="${ax_check_gl_have_headers}"])

        # pkgconfig library are suposed to work ...
        AS_IF([test "X$ax_cv_check_gl_have_headers" = "Xno"],
              [AC_MSG_ERROR("Pkgconfig detected OpenGL library has no headers!")])

	_AX_CHECK_GL_COMPILE_CV()
	AS_IF([test "X$ax_cv_check_gl_compile_opengl" = "Xno"],
              [AC_MSG_ERROR("Pkgconfig detected opengl library could not be used for compiling minimal program!")])

	_AX_CHECK_GL_LINK_CV()
	AS_IF([test "X$ax_cv_check_gl_link_opengl" = "Xno"],
              [AC_MSG_ERROR("Pkgconfig detected opengl library could not be used for linking minimal program!")])
  ],[ax_check_gl_pkg_config=no])
])

# test if gl link with X
AC_DEFUN([_AX_CHECK_GL_WITH_X],
[
 # try if opengl need X
 AC_LANG_PUSH([C])
 _AX_CHECK_GL_SAVE_FLAGS()
 CFLAGS="${GL_CFLAGS} ${CFLAGS}"
 LIBS="${GL_LIBS} ${LIBS}"
 LDFLAGS="${GL_LDFLAGS} ${LDFLAGS}"
 AC_LINK_IFELSE([AC_LANG_CALL([], [glXQueryVersion])],
                [ax_check_gl_link_implicitly_with_x="yes"],
   	        [ax_check_gl_link_implicitly_with_x="no"])
 _AX_CHECK_GL_RESTORE_FLAGS()
 AC_LANG_POP([C])
])

# internal routine: entry point if gl not disable
AC_DEFUN([_AX_CHECK_GL],[dnl
 AC_REQUIRE([PKG_PROG_PKG_CONFIG])
 AC_REQUIRE([AC_PATH_X])dnl

 # does we need X or not
 _AX_CHECK_GL_NEED_X()

 # try first pkgconfig
 AC_MSG_CHECKING([for a working OpenGL implementation by pkg-config])
 AS_IF([test "X${PKG_CONFIG}" = "X"],
       [ AC_MSG_RESULT([no])
         ax_check_gl_pkg_config=no],
       [ AC_MSG_RESULT([yes])
         _AX_CHECK_GL_PKG_CONFIG()])

 # if no pkgconfig or pkgconfig fail try manual way
 AS_IF([test "X$ax_check_gl_pkg_config" = "Xno"],
       [_AX_CHECK_GL_MANUAL()],
       [no_gl=no])

 # test if need to test X compatibility
 AS_IF([test $no_gl = no],
       [# test X compatibility
 	AS_IF([test X$ax_check_gl_need_x != "Xdefault"],
       	      [AC_CACHE_CHECK([wether OpenGL link implictly with X],[ax_cv_check_gl_link_with_x],
                              [_AX_CHECK_GL_WITH_X()
                               ax_cv_check_gl_link_with_x="${ax_check_gl_link_implicitly_with_x}"])
                               AS_IF([test "X${ax_cv_check_gl_link_with_x}" = "X${ax_check_gl_need_x}"],
                                     [no_gl="no"],
                                     [no_gl=yes])])
	     ])
])

# ax_check_gl entry point
AC_DEFUN([AX_CHECK_GL],
[AC_REQUIRE([AC_PATH_X])dnl
 AC_REQUIRE([AC_CANONICAL_HOST])

 AC_ARG_WITH([gl],
  [AS_HELP_STRING([--with-gl@<:@=ARG@:>@],
    [use opengl (ARG=yes),
     using the specific lib (ARG=<lib>),
     using the OpenGL lib that link with X (ARG=x),
     using the OpenGL lib that link without X (ARG=nox),
     or disable it (ARG=no)
     @<:@ARG=yes@:>@ ])],
    [
    AS_CASE(["$withval"],
            ["no"|"NO"],[ax_check_gl_want_gl="no"],
	    ["yes"|"YES"],[ax_check_gl_want_gl="yes"],
	    [ax_check_gl_want_gl="$withval"])
    ],
    [ax_check_gl_want_gl="yes"])

 dnl compatibility with AX_HAVE_OPENGL
 AC_ARG_WITH([Mesa],
    [AS_HELP_STRING([--with-Mesa@<:@=ARG@:>@],
    [Prefer the Mesa library over a vendors native OpenGL (ARG=yes except on mingw ARG=no),
     @<:@ARG=yes@:>@ ])],
    [
    AS_CASE(["$withval"],
            ["no"|"NO"],[ax_check_gl_want_mesa="no"],
	    ["yes"|"YES"],[ax_check_gl_want_mesa="yes"],
	    [AC_MSG_ERROR([--with-mesa flag is only yes no])])
    ],
    [ax_check_gl_want_mesa="default"])

 # check consistency of parameters
 AS_IF([test "X$have_x" = "Xdisabled"],
       [AS_IF([test X$ax_check_gl_want_gl = "Xx"],
              [AC_MSG_ERROR([You prefer OpenGL with X and asked for no X support])])])

 AS_IF([test "X$have_x" = "Xdisabled"],
       [AS_IF([test X$x_check_gl_want_mesa = "Xyes"],
              [AC_MSG_WARN([You prefer mesa but you disable X. Disable mesa because mesa need X])
	       ax_check_gl_want_mesa="no"])])

 # mesa default means yes except on mingw
 AC_MSG_CHECKING([wether we should prefer mesa for opengl implementation])
 AS_IF([test X$ax_check_gl_want_mesa = "Xdefault"],
       [AS_CASE([${host}],
                [*-mingw*],[ax_check_gl_want_mesa=no],
		[ax_check_gl_want_mesa=yes])])
 AC_MSG_RESULT($ax_check_gl_want_mesa)

 # set default guess order
 AC_MSG_CHECKING([for a working OpenGL order detection])
 AS_IF([test "X$no_x" = "Xyes"],
       [ax_check_gl_order="gl"],
       [AS_IF([test X$ax_check_gl_want_mesa = "Xyes"],
              [ax_check_gl_order="mesagl gl"],
	      [ax_check_gl_order="gl mesagl"])])
 AC_MSG_RESULT($ax_check_gl_order)

 # set flags
 no_gl="yes"
 have_GL="no"

 # now do the real testing
 AS_IF([test X$ax_check_gl_want_gl != "Xno"],
       [_AX_CHECK_GL()])

 AC_MSG_CHECKING([for a working OpenGL implementation])
 AS_IF([test "X$no_gl" = "Xno"],
       [have_GL="yes"
        AC_MSG_RESULT([yes])
        AC_MSG_CHECKING([for CFLAGS needed for OpenGL])
        AC_MSG_RESULT(["${GL_CFLAGS}"])
        AC_MSG_CHECKING([for LIBS needed for OpenGL])
        AC_MSG_RESULT(["${GL_LIBS}"])
        AC_MSG_CHECKING([for LDFLAGS needed for OpenGL])
        AC_MSG_RESULT(["${GL_LDFLAGS}"])],
       [AC_MSG_RESULT([no])
        GL_CFLAGS=""
        GL_LIBS=""
        GL_LDFLAGS=""])

 AC_SUBST([GL_CFLAGS])
 AC_SUBST([GL_LIBS])
 AC_SUBST([GL_LDFLAGS])
])
