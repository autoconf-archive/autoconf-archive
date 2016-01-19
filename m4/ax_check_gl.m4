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
])

dnl local restore flags
AC_DEFUN([_AX_CHECK_GL_RESTORE_FLAGS],
[dnl
LIBS="${ax_check_gl_saved_libs}"
CFLAGS="${ax_check_gl_saved_cflags}"
])

dnl default switch case failure
dnl AC_DEFUN([_AX_CHECK_MSG_FAILURE_ORDER],
dnl [dnl
dnl  AC_MSG_FAILURE([Order logic in ax_check_gl is buggy])
dnl ])
dnl 
dnl # set the varible ax_check_gl_need_x
dnl # this variable determine if we need opengl that link with X
dnl # value are default aka try the first library wether if it link or not with x
dnl # yes that means we need a opengl with x
dnl # no that means we do not need an opengl with x
dnl AC_DEFUN([_AX_CHECK_GL_NEED_X],
dnl [dnl
dnl  # do not check if empty : allow a subroutine to modify the choice
dnl  AS_IF([test "X$ax_check_gl_need_x" = "X"],
dnl        [ax_check_gl_need_x="default"
dnl         AS_IF([test "X$no_x" = "Xyes"],[ax_check_gl_need_x="no"])
dnl         AS_IF([test "X$ax_check_gl_want_gl" = "Xnox"],[ax_check_gl_need_x="no"])
dnl         AS_IF([test "X$ax_check_gl_want_gl" = "Xx"],[ax_check_gl_need_x="yes"])])
dnl ])
dnl 
dnl # compile the example program
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
dnl 
dnl dnl Check headers manually (default case)
dnl AC_DEFUN([_AX_CHECK_GL_MANUAL_HEADERS_DEFAULT],
dnl [AC_REQUIRE([AC_PATH_XTRA])
dnl  AC_LANG_PUSH([C])
dnl  _AX_CHECK_GL_SAVE_FLAGS()
dnl  CFLAGS="${GL_CFLAGS} ${CFLAGS}"
dnl  # see comment in _AX_CHECK_GL_INCLUDES_DEFAULT
dnl  AC_CHECK_HEADERS([windows.h],[],[],[AC_INCLUDES_DEFAULT])
dnl  # FIXME: use extra cflags
dnl  AC_CHECK_HEADERS([GL/gl.h],[ax_check_gl_have_headers="yes"],
dnl                             [ax_check_gl_have_headers_headers="no"],
dnl 			    [_AX_CHECK_GL_INCLUDES_DEFAULT()])
dnl  # do not try darwin specific OpenGl/gl.h
dnl  _AX_CHECK_GL_RESTORE_FLAGS()
dnl  AC_LANG_POP([C])
dnl ])
dnl 
dnl # darwin headers without X
dnl AC_DEFUN([_AX_CHECK_GL_MANUAL_HEADERS_DARWIN_NOX],[
dnl  AC_LANG_PUSH([C])
dnl  _AX_CHECK_GL_SAVE_FLAGS()
dnl  AC_CHECK_HEADERS([OpenGL/gl.h],[ax_check_gl_have_headers="yes"],
dnl                                 [ax_check_gl_have_headers="no"],
dnl 			        [_AX_CHECK_GL_INCLUDES_DEFAULT()])
dnl  _AX_CHECK_GL_RESTORE_FLAGS()
dnl  AC_LANG_POP([C])
dnl ])
dnl 
dnl # check header for darwin
dnl AC_DEFUN([_AX_CHECK_GL_MANUAL_HEADERS_DARWIN],
dnl [AC_REQUIRE([_AX_CHECK_GL_NEED_X])
dnl dnl Can use AC_CHECK_LIB([X11], [XOpenDisplay], [],[
dnl dnl          echo "X11 library is required for this program"
dnl dnl          exit -1])
dnl dnl          Giving a hint: On OSX try adding -I/opt/x11/include and -L/opt/x11/lib
dnl  AS_CASE(["$ax_check_gl_order"],
dnl          # try to use framework
dnl          ["gl"],[_AX_CHECK_GL_MANUAL_HEADERS_DARWIN_NOX()],
dnl 	 # try to use framework then mesa (X)
dnl 	 ["gl mesagl"],[
dnl 	   _AX_CHECK_GL_MANUAL_HEADERS_DARWIN_NOX()
dnl 	   AS_IF([test "X$ax_check_gl_have_headers" = "Xyes"],
dnl 	         [ax_check_gl_order="gl"
dnl 		  ax_check_gl_need_x="yes"],
dnl 		 [ax_check_gl_order="mesagl gl"
dnl 		  ax_check_gl_need_x="no"]
dnl 		  # retry with general test
dnl 		  _AX_CHECK_GL_MANUAL_HEADERS_DEFAULT())],
dnl          ["mesagl gl"],[
dnl 	   _AX_CHECK_GL_MANUAL_HEADERS_DEFAULT()
dnl 	   AS_IF([test "X$ax_check_gl_have_headers" = "Xyes"],
dnl 	         [ax_check_gl_order="mesagl gl"
dnl 		  ax_check_gl_need_x="no"],
dnl 		 [ax_check_gl_order="gl"
dnl 		  ax_check_gl_need_x="yes"
dnl 		  # retry with framework
dnl 		  _AX_CHECK_GL_MANUAL_HEADERS_DARWIN_NOX()])],
dnl         [_AX_CHECK_MSG_FAILURE_ORDER()])
dnl ])
dnl 
dnl dnl Check headers manually: subroutine must set ax_check_gl_have_headers={yes,no}
dnl AC_DEFUN([_AX_CHECK_GL_MANUAL_HEADERS],
dnl [AC_REQUIRE([AC_CANONICAL_HOST])
dnl  AS_CASE([${host}],
dnl          [*-darwin*],[_AX_CHECK_GL_MANUAL_HEADERS_DARWIN()],
dnl 	 [_AX_CHECK_GL_MANUAL_HEADERS_DEFAULT()])
dnl  AC_CACHE_CHECK([for OpenGL headers],[ax_cv_check_gl_have_headers],
dnl                	[ax_cv_check_gl_have_headers="${ax_check_gl_have_headers}"])
dnl ])
dnl 
dnl # dnl try to found library (generic case)
dnl # dnl $1 is set to the library to found
dnl AC_DEFUN([_AX_CHECK_GL_MANUAL_LIBS_GENERIC],
dnl [dnl
dnl  ax_check_gl_manual_libs_generic_extra_libs="$1"
dnl  AS_IF([test "X$ax_check_gl_manual_libs_generic_extra_libs" = "X"],
dnl        [AC_MSG_ERROR([AX_CHECK_GL_MANUAL_LIBS_GENERIC argument must no be empty])])
dnl 
dnl  AC_LANG_PUSH([C])
dnl  _AX_CHECK_GL_SAVE_FLAGS()
dnl  CFLAGS="${GL_CFLAGS} ${CFLAGS}"
dnl  LIBS="${GL_LIBS} ${LIBS}"
dnl  AC_SEARCH_LIBS([glBegin],[$ax_check_gl_manual_libs_generic_extra_libs],
dnl                 [ax_check_gl_lib_opengl="yes"],
dnl                 [ax_check_gl_lib_opengl="no"])
dnl  AS_CASE([$ac_cv_search_glBegin],
dnl          ["none required"],[],
dnl  	 [no],[],
dnl  	 [GL_LIBS="${ac_cv_search_glBegin} ${GL_LIBS}"])
dnl   _AX_CHECK_GL_RESTORE_FLAGS()
dnl   AC_LANG_PUSH([C])
dnl ])
dnl 
dnl # dnl try to found lib under darwin
dnl # darwin opengl hack
dnl # see http://web.archive.org/web/20090410052741/http://developer.apple.com/qa/qa2007/qa1567.html
dnl # and http://web.eecs.umich.edu/~sugih/courses/eecs487/glut-howto/
dnl dnl need to rewrite this whole thing
dnl AC_DEFUN([_AX_CHECK_GL_MANUAL_LIBS_DARWIN],
dnl [# ldhack list
dnl  AC_CHECK_FILE([/System/Library/Frameworks/OpenGL.framework],
dnl                [ax_check_gl_lib_opengl="yes"
dnl                 GL_LDFLAGS="-framework OpenGL ${GL_LDFLAGS}"],
dnl                [ax_check_gl_lib_opengl="no"])
dnl 
dnl  dnl ldhack1="-Wl,-framework,OpenGL"
dnl  dnl ldhack2="-Wl,-dylib_file,/System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGL.dylib:/System/Library/Frameworks/OpenGL.framework/Versions/A/Libraries/libGL.dylib"
dnl  dnl ldhack3="$ldhack1,$ldhack2"
dnl 
dnl  dnl # select hack
dnl  dnl AS_IF([test "X$ax_check_gl_need_x" = "Xno"],
dnl  dnl       [# libs already set by -framework cflag
dnl  dnl        darwinlibs=""
dnl  dnl        ldhacks="$ldhack1 $ldhack2 $ldhack3"],
dnl  dnl       [# do not use framework ldflags in case of x version
dnl  dnl        darwinlibs="GL gl MesaGL"
dnl  dnl        ldhacks="$ldhack2"])
dnl 
dnl  dnl ax_check_gl_link_opengl="no"
dnl  dnl for extralibs in " " $darwinlibs; do
dnl  dnl   for extraldflags in " " $ldhacks; do
dnl  dnl       AC_LANG_PUSH([C])
dnl  dnl        _AX_CHECK_GL_SAVE_FLAGS()
dnl  dnl       CFLAGS="${GL_CFLAGS} ${CFLAGS}"
dnl  dnl       LIBS="$extralibs ${GL_LIBS} ${LIBS}"
dnl  dnl       LDFLAGS="$extraldflags ${GL_LDFLAGS} ${LDFLAGS}"
dnl  dnl       AC_MSG_CHECKING([CFLAGS])
dnl  dnl       AC_MSG_RESULT(["${CFLAGS}"])
dnl  dnl       AC_MSG_CHECKING([LIBS])
dnl  dnl       AC_MSG_RESULT(["${LIBS}"])
dnl  dnl       AC_MSG_CHECKING([LDFLAGS])
dnl  dnl       AC_MSG_RESULT(["${LDFLAGS}"])
dnl  dnl       AC_LINK_IFELSE([_AX_CHECK_GL_PROGRAM],
dnl  dnl                      [ax_check_gl_link_opengl="yes"
dnl  dnl                       ax_check_gl_lib_opengl="yes"]
dnl  dnl                      [ax_check_gl_link_opengl="no"
dnl  dnl                       ax_check_gl_lib_opengl="no"])
dnl  dnl       _AX_CHECK_GL_RESTORE_FLAGS()
dnl  dnl       AC_LANG_POP([C])
dnl  dnl       AS_IF([test "X$ax_check_gl_link_opengl" = "Xyes"],[
dnl  dnl       AC_MSG_NOTICE([found linked gl])
dnl  dnl       break])
dnl  dnl   done;
dnl  dnl   AS_IF([test "X$ax_check_gl_link_opengl" = "Xyes"],[break])
dnl  dnl done;
dnl  dnl GL_LIBS="$extralibs ${GL_LIBS}"
dnl  dnl GL_LDFLAGS="$extraldflags ${GL_LDFLAGS}"
dnl ])
dnl 
dnl dnl Check library manually: subroutine must set
dnl dnl $ax_check_gl_lib_opengl={yes,no}
dnl AC_DEFUN([_AX_CHECK_GL_MANUAL_LIBS],
dnl [AC_REQUIRE([AC_CANONICAL_HOST])
dnl  AS_CASE([${host}],
dnl          [*-darwin*],[_AX_CHECK_GL_MANUAL_LIBS_DARWIN()],
dnl          # try first cygwin version
dnl          [*-cygwin*|*-mingw*],[
dnl 	   AS_CASE(["$ax_check_gl_order"],
dnl 	           ["gl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([opengl32])],
dnl 		   ["gl mesagl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([opengl32 GL gl MesaGL])],
dnl 		   ["mesagl gl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([GL gl MesaGL opengl32])],
dnl 		   [_AX_CHECK_MSG_FAILURE_ORDER()])],
dnl 	 [AS_CASE(["$ax_check_gl_order"],
dnl                   ["gl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([GL gl])],
dnl 		  ["gl mesagl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([GL gl MesaGL])],
dnl 		  ["mesagl gl"],[_AX_CHECK_GL_MANUAL_LIBS_GENERIC([MesaGL GL gl])],
dnl 		  [_AX_CHECK_MSG_FAILURE_ORDER()])]
dnl 		  )
dnl 
dnl  AC_CACHE_CHECK([for OpenGL libraries],[ax_cv_check_gl_lib_opengl],
dnl                	[ax_cv_check_gl_lib_opengl="${ax_check_gl_lib_opengl}"])
dnl  ax_check_gl_lib_opengl="${ax_cv_check_gl_lib_opengl}"
dnl ])
dnl 
dnl # manually check aka old way
dnl AC_DEFUN([_AX_CHECK_GL_MANUAL],
dnl [AC_REQUIRE([AC_CANONICAL_HOST])dnl
dnl  AC_REQUIRE([AC_PATH_XTRA])dnl
dnl 
dnl  no_gl="yes"
dnl 
dnl  _AX_CHECK_GL_MANUAL_HEADERS()
dnl  AS_IF([test "X$ax_check_gl_have_headers" = "Xyes"],
dnl        [_AX_CHECK_GL_COMPILE_CV()],
dnl        [ax_check_gl_compile_opengl=no])
dnl 
dnl  AS_IF([test "X$ax_check_gl_compile_opengl" = "Xyes"],
dnl        [_AX_CHECK_GL_MANUAL_LIBS],
dnl        [ax_check_gl_lib_opengl=no])
dnl 
dnl  AS_IF([test "X$ax_check_gl_lib_opengl" = "Xyes"],
dnl        [_AX_CHECK_GL_LINK_CV()],
dnl        [ax_check_gl_link_opengl=no])
dnl 
dnl  AS_IF([test "X$ax_check_gl_link_opengl" = "Xyes"],
dnl        [no_gl="no"],
dnl        [no_gl="yes"])
dnl ])dnl
dnl 
dnl 
dnl # try to test using pkgconfig: set ax_check_gl_pkg_config=no if not found
dnl AC_DEFUN([_AX_CHECK_GL_PKG_CONFIG],dnl
dnl [dnl
dnl  AC_REQUIRE([PKG_PROG_PKG_CONFIG])
dnl 
dnl  dnl First try mesagl
dnl  AS_CASE(["$ax_check_gl_order"],
dnl          ["gl"],[PKG_CHECK_MODULES([GL],[mesagl],
dnl 	                  [ax_check_gl_pkg_config=yes],
dnl 			  [ax_check_gl_pkg_config=no])],
dnl 	 ["gl mesagl"],[PKG_CHECK_MODULES([GL],[gl],
dnl 	                  [ax_check_gl_pkg_config=yes],
dnl 			  [PKG_CHECK_MODULES([GL],[mesagl],
dnl 	                         [ax_check_gl_pkg_config=yes],
dnl 				 [ax_check_gl_pkg_config=no])])],
dnl 	 ["mesagl gl"],[PKG_CHECK_MODULES([GL],[mesagl],
dnl 	                  [ax_check_gl_pkg_config=yes],
dnl 			  [PKG_CHECK_MODULES([GL],[gl],
dnl 	                         [ax_check_gl_pkg_config=yes],
dnl 				 [ax_check_gl_pkg_config=no])])],
dnl 	 [_AX_CHECK_MSG_FAILURE_ORDER])
dnl 
dnl  AS_IF([test "X$ax_check_gl_pkg_config" = "Xyes"],[
dnl         # check headers
dnl         AC_LANG_PUSH([C])
dnl  	_AX_CHECK_GL_SAVE_FLAGS()
dnl         CFLAGS="${GL_CFLAGS} ${CFLAGS}"
dnl         AC_CHECK_HEADERS([windows.h],[],[],[AC_INCLUDES_DEFAULT])
dnl         AC_CHECK_HEADERS([GL/gl.h OpenGL/gl.h],
dnl                          [ax_check_gl_have_headers="yes";break],
dnl                          [ax_check_gl_have_headers_headers="no"],
dnl 			 [_AX_CHECK_GL_INCLUDES_DEFAULT()])
dnl         _AX_CHECK_GL_RESTORE_FLAGS()
dnl 	AC_LANG_POP([C])
dnl 	AC_CACHE_CHECK([for OpenGL headers],[ax_cv_check_gl_have_headers],
dnl                	       [ax_cv_check_gl_have_headers="${ax_check_gl_have_headers}"])
dnl 
dnl         # pkgconfig library are suposed to work ...
dnl         AS_IF([test "X$ax_cv_check_gl_have_headers" = "Xno"],
dnl               [AC_MSG_ERROR("Pkgconfig detected OpenGL library has no headers!")])
dnl 
dnl 	_AX_CHECK_GL_COMPILE_CV()
dnl 	AS_IF([test "X$ax_cv_check_gl_compile_opengl" = "Xno"],
dnl               [AC_MSG_ERROR("Pkgconfig detected opengl library could not be used for compiling minimal program!")])
dnl 
dnl 	_AX_CHECK_GL_LINK_CV()
dnl 	AS_IF([test "X$ax_cv_check_gl_link_opengl" = "Xno"],
dnl               [AC_MSG_ERROR("Pkgconfig detected opengl library could not be used for linking minimal program!")])
dnl   ],[ax_check_gl_pkg_config=no])
dnl ])
dnl 
dnl # test if gl link with X
dnl AC_DEFUN([_AX_CHECK_GL_WITH_X],
dnl [
dnl  # try if opengl need X
dnl  AC_LANG_PUSH([C])
dnl  _AX_CHECK_GL_SAVE_FLAGS()
dnl  CFLAGS="${GL_CFLAGS} ${CFLAGS}"
dnl  LIBS="${GL_LIBS} ${LIBS}"
dnl  LDFLAGS="${GL_LDFLAGS} ${LDFLAGS}"
dnl  AC_LINK_IFELSE([AC_LANG_CALL([], [glXQueryVersion])],
dnl                 [ax_check_gl_link_implicitly_with_x="yes"],
dnl    	        [ax_check_gl_link_implicitly_with_x="no"])
dnl  _AX_CHECK_GL_RESTORE_FLAGS()
dnl  AC_LANG_POP([C])
dnl ])
dnl 
dnl m4_define([AH_CHECK_LIB],
dnl [AH_TEMPLATE(AS_TR_CPP([HAVE_LIB$1]),
dnl              [Define to 1 if you have the `$1' library (-l$1).])])
dnl 
dnl # internal routine: entry point if gl not disable
dnl AC_DEFUN([_AX_CHECK_GL],[dnl
dnl  [m4_ifval([$3], , [AH_TEMPLATE(AS_TR_CPP([HAVE_LIB$1]),
dnl        [Define to 1 if you have the `$1' library (-l$1).])])]
dnl 
dnl  AC_REQUIRE([PKG_PROG_PKG_CONFIG])
dnl  AC_REQUIRE([AC_PATH_X])dnl
dnl 
dnl  # does we need X or not
dnl  _AX_CHECK_GL_NEED_X()
dnl 
dnl  # try first pkgconfig
dnl  AC_MSG_CHECKING([for a working OpenGL implementation by pkg-config])
dnl  AS_IF([test "X${PKG_CONFIG}" = "X"],
dnl        [ AC_MSG_RESULT([no])
dnl          ax_check_gl_pkg_config=no],
dnl        [ AC_MSG_RESULT([yes])
dnl          _AX_CHECK_GL_PKG_CONFIG()])
dnl 
dnl  # if no pkgconfig or pkgconfig fail try manual way
dnl  AS_IF([test "X$ax_check_gl_pkg_config" = "Xno"],
dnl        [_AX_CHECK_GL_MANUAL()],
dnl        [no_gl=no])
dnl 
dnl  # test if need to test X compatibility
dnl  AS_IF([test $no_gl = no],
dnl        [# test X compatibility
dnl  	AS_IF([test X$ax_check_gl_need_x != "Xdefault"],
dnl        	      [AC_CACHE_CHECK([wether OpenGL link implictly with X],[ax_cv_check_gl_link_with_x],
dnl                               [_AX_CHECK_GL_WITH_X()
dnl                                ax_cv_check_gl_link_with_x="${ax_check_gl_link_implicitly_with_x}"])
dnl                                AS_IF([test "X${ax_cv_check_gl_link_with_x}" = "X${ax_check_gl_need_x}"],
dnl                                      [no_gl="no"],
dnl                                      [no_gl=yes])])
dnl 	     ])
dnl ])
dnl 
dnl # ax_check_gl entry point
dnl AC_DEFUN([AX_CHECK_GL],
dnl [AC_REQUIRE([AC_PATH_X])dnl
dnl  AC_REQUIRE([AC_CANONICAL_HOST])
dnl 
dnl  AC_ARG_WITH([gl],
dnl   [AS_HELP_STRING([--with-gl@<:@=ARG@:>@],
dnl     [use opengl (ARG=yes),
dnl      using the specific lib (ARG=<lib>),
dnl      using the OpenGL lib that link with X (ARG=x),
dnl      using the OpenGL lib that link without X (ARG=nox),
dnl      or disable it (ARG=no)
dnl      @<:@ARG=yes@:>@ ])],
dnl     [
dnl     AS_CASE(["$withval"],
dnl             ["no"|"NO"],[ax_check_gl_want_gl="no"],
dnl 	    ["yes"|"YES"],[ax_check_gl_want_gl="yes"],
dnl 	    [ax_check_gl_want_gl="$withval"])
dnl     ],
dnl     [ax_check_gl_want_gl="yes"])
dnl 
dnl  dnl compatibility with AX_HAVE_OPENGL
dnl  AC_ARG_WITH([Mesa],
dnl     [AS_HELP_STRING([--with-Mesa@<:@=ARG@:>@],
dnl     [Prefer the Mesa library over a vendors native OpenGL (ARG=yes except on mingw ARG=no),
dnl      @<:@ARG=yes@:>@ ])],
dnl     [
dnl     AS_CASE(["$withval"],
dnl             ["no"|"NO"],[ax_check_gl_want_mesa="no"],
dnl 	    ["yes"|"YES"],[ax_check_gl_want_mesa="yes"],
dnl 	    [AC_MSG_ERROR([--with-mesa flag is only yes no])])
dnl     ],
dnl     [ax_check_gl_want_mesa="default"])
dnl 
dnl  # check consistency of parameters
dnl  AS_IF([test "X$have_x" = "Xdisabled"],
dnl        [AS_IF([test X$ax_check_gl_want_gl = "Xx"],
dnl               [AC_MSG_ERROR([You prefer OpenGL with X and asked for no X support])])])
dnl 
dnl  AS_IF([test "X$have_x" = "Xdisabled"],
dnl        [AS_IF([test X$x_check_gl_want_mesa = "Xyes"],
dnl               [AC_MSG_WARN([You prefer mesa but you disable X. Disable mesa because mesa need X])
dnl 	       ax_check_gl_want_mesa="no"])])
dnl 
dnl  # mesa default means yes except on mingw
dnl  AC_MSG_CHECKING([wether we should prefer mesa for opengl implementation])
dnl  AS_IF([test X$ax_check_gl_want_mesa = "Xdefault"],
dnl        [AS_CASE([${host}],
dnl                 [*-mingw*],[ax_check_gl_want_mesa=no],
dnl 		[ax_check_gl_want_mesa=yes])])
dnl  AC_MSG_RESULT($ax_check_gl_want_mesa)
dnl 
dnl  # set default guess order
dnl  AC_MSG_CHECKING([for a working OpenGL order detection])
dnl  AS_IF([test "X$no_x" = "Xyes"],
dnl        [ax_check_gl_order="gl"],
dnl        [AS_IF([test X$ax_check_gl_want_mesa = "Xyes"],
dnl               [ax_check_gl_order="mesagl gl"],
dnl 	      [ax_check_gl_order="gl mesagl"])])
dnl  AC_MSG_RESULT($ax_check_gl_order)
dnl 
dnl  # set flags
dnl  no_gl="yes"
dnl  have_GL="no"
dnl 
dnl  # now do the real testing
dnl  AS_IF([test X$ax_check_gl_want_gl != "Xno"],
dnl        [_AX_CHECK_GL()])
dnl 
dnl  AC_MSG_CHECKING([for a working OpenGL implementation])
dnl  AS_IF([test "X$no_gl" = "Xno"],
dnl        [have_GL="yes"
dnl         AC_MSG_RESULT([yes])
dnl         AC_MSG_CHECKING([for CFLAGS needed for OpenGL])
dnl         AC_MSG_RESULT(["${GL_CFLAGS}"])
dnl         AC_MSG_CHECKING([for LIBS needed for OpenGL])
dnl         AC_MSG_RESULT(["${GL_LIBS}"])
dnl         AC_MSG_CHECKING([for LDFLAGS needed for OpenGL])
dnl         AC_MSG_RESULT(["${GL_LDFLAGS}"])],
dnl        [AC_MSG_RESULT([no])
dnl         GL_CFLAGS=""
dnl         GL_LIBS=""
dnl         GL_LDFLAGS=""])
dnl 
dnl  AC_SUBST([GL_CFLAGS])
dnl  AC_SUBST([GL_LIBS])
dnl  AC_SUBST([GL_LDFLAGS])
dnl ])

# setvar only when variable is unset
AC_DEFUN([_AX_GL_SETVAR], [
 AS_IF([test -n "$$1"], [], [$1=$2])])

AC_DEFUN([_AX_CHECK_DARWIN_GL],
[AC_ARG_WITH([xquartz],
 [AS_HELP_STRING([--with-xquartz@<:@=ARG@:>@],
                 [On Mac OSX, use opengl provided by X11 instead of built-in framework. @<:@ARG=no@:>@])],
 [],
 [with_xquartz=no]) dnl with-xquartz
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
AC_DEFUN([AX_CHECK_GL_LIB],
[AC_REQUIRE([AC_CANONICAL_HOST])
 AC_REQUIRE([PKG_PROG_PKG_CONFIG])
 AC_ARG_VAR([GL_CFLAGS],[C compiler flags for GL, overriding system check])
 AC_ARG_VAR([GL_LIBS],[linker flags for GL, overriding system check])
 AC_ARG_VAR([XQUARTZ_DIR],[XQuartz (X11) root on OSX @<:@/opt/X11@:>@])
 
 AS_CASE([${host}],
         [*-darwin*],[_AX_CHECK_DARWIN_GL],
         [*-cygwin*|*-mingw*],[_AX_GL_SETVAR([GL_LIBS],[-lopengl32])],
         [PKG_PROG_PKG_CONFIG
          PKG_CHECK_MODULES([GL],[gl])
         ]) dnl host specific checks

 AC_LANG_PUSH([C])
 _AX_CHECK_GL_SAVE_FLAGS()
 CFLAGS="${GL_CFLAGS} ${CFLAGS}"
 AC_CHECK_HEADERS([GL/gl.h OpenGL/gl.h],
   [ax_check_gl_have_headers="yes";break],
   [],
   [_AX_CHECK_GL_INCLUDES_DEFAULT()])
 _AX_CHECK_GL_RESTORE_FLAGS()
 AC_LANG_POP([C])

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
