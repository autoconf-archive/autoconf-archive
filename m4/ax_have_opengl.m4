# ===========================================================================
#      http://www.gnu.org/software/autoconf-archive/ax_have_opengl.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Please use AX_CHECK_GL, AX_CHECK_GLU, AX_CHECK_GLUT, AX_CHECK_GLX
#   instead
#
# SYNOPSIS
#
#   AX_HAVE_OPENGL
#
# DESCRIPTION
#
#   Search for OpenGL. We search first for Mesa (a GPL'ed version of Mesa)
#   before a vendor's version of OpenGL, unless we were specifically asked
#   not to with `--with-Mesa=no' or `--without-Mesa'.
#
#   The four "standard" OpenGL libraries are searched for: "-lGL", "-lGLU",
#   "-lGLX" (or "-lMesaGL", "-lMesaGLU" as the case may be) and "-lglut".
#
#   All of the libraries that are found (since "-lglut" or "-lGLX" might be
#   missing) are added to the shell output variable "GL_LIBS", along with
#   any other libraries that are necessary to successfully link an OpenGL
#   application (e.g. the X11 libraries). Care has been taken to make sure
#   that all of the libraries in "GL_LIBS" are listed in the proper order.
#
#   Additionally, the shell output variable "GL_CFLAGS" is set to any flags
#   (e.g. "-I" flags) that are necessary to successfully compile an OpenGL
#   application.
#
#   The following shell variable (which are not output variables) are also
#   set to either "yes" or "no" (depending on which libraries were found) to
#   help you determine exactly what was found.
#
#     have_GL
#     have_GLU
#     have_GLX
#     have_glut
#
# LICENSE
#
#   Copyright (c) 2008 Matthew D. Langston
#   Copyright (c) 2008 Ahmet Inan <auto@ainan.org>
#   Copyright (c) 2013 Bastien Roucaries <roucaries.bastien+autoconf@gmail.com
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

#serial 8

AU_ALIAS([MDL_HAVE_OPENGL], [AX_HAVE_OPENGL])
AC_DEFUN([AX_HAVE_OPENGL],
[
  AC_REQUIRE([AX_CHECK_GL])
  AC_REQUIRE([AX_CHECK_GLU])
  AC_REQUIRE([AX_CHECK_GLUT])
  AC_REQUIRE([AX_CHECK_GLX])

  AC_OBSOLETE([$0], [;please use AX_CHECK_GL, AX_CHECK_GLU, AX_CHECK_GLUT, AX_CHECK_GLX instead])
  AC_MSG_WARN([[AX_HAVE_OPENGL is deprecated, please use AX_CHECK_GL, AX_CHECK_GLU, AX_CHECK_GLUT, AX_CHECK_GLX instead]])

  # override old flags: really ugly but needed for compatibility
  GL_CFLAGS="$GL_CFLAGS $GLU_CFLAGS $GLUT_CFLAGS $GLX_CFLAGS"
  GL_LIBS="$GL_LIBS $GLU_LIBS $GLUT_LIBS $GLX_LIBS"
])
