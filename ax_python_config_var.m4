##### http://autoconf-archive.cryp.to/ax_python_config_var.html
#
# SYNOPSIS
#
#   AX_PYTHON_CONFIG_VAR(PYTHON_VARIABLE, [SHELL_VARIABLE])
#   AX_PYTHON_CONFIG_H
#   AX_PYTHON_MAKEFILE
#
# DESCRIPTION
#
#   AX_PYTHON_CONFIG_VAR:
#
#   Using the Python module distutils.sysconfig[1], return a Python
#   configuration variable. PYTHON_VARIABLE is the name of the variable
#   to request from Python, and SHELL_VARIABLE is the name of the shell
#   variable into which the results should be deposited. If
#   SHELL_VARIABLE is not specified, the macro wil prefix PY_ to the
#   PYTHON_VARIABLE, e.g., LIBS -> PY_LIBS.
#
#   SHELL_VARIABLE is AC_SUBST'd. No action is taken if an error
#   occurs. Note if $PYTHON is not set, AC_CHECK_PROG(PYTHON, python,
#   python) will be run.
#
#   Example:
#
#     AX_PYTHON_CONFIG_VAR(LINKFORSHARED, PY_LFS)
#
#   AX_PYTHON_CONFIG_H:
#
#   Using the Python module distutils.sysconfig[1], put the full
#   pathname of the config.h file used to compile Python into the shell
#   variable PY_CONFIG_H. PY_CONFIG_H is AC_SUBST'd. Note if $PYTHON is
#   not set, AC_CHECK_PROG(PYTHON, python, python) will be run.
#
#   AX_PYTHON_MAKEFILE:
#
#   Using the Python module distutils.sysconfig[1], put the full
#   pathname of the Makefile file used to compile Python into the shell
#   variable PY_MAKEFILE. PY_MAKEFILE is AC_SUBST'd. Note if $PYTHON is
#   not set, AC_CHECK_PROG(PYTHON, python, python) will be run.
#
#   [1]
#   http://www.python.org/doc/current/dist/module-distutils.sysconfig.html
#
# LAST MODIFICATION
#
#   2005-01-22
#
# COPYLEFT
#
#   Copyright (c) 2005 Dustin Mitchell <dustin@cs.uchicago.edu>
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

AC_DEFUN([AX_PYTHON_CONFIG_VAR],
[
 AC_MSG_CHECKING(for Python config variable $1)
 if test -z "$PYTHON"
 then
   AC_CHECK_PROG(PYTHON,python,python)
 fi
 py_error="no"
 pyval=`$PYTHON -c "from distutils import sysconfig;dnl
print sysconfig.get_config_var('$1')"` || py_error="yes"
 if test "$py_error" = "yes"
 then
   AC_MSG_RESULT(no - an error occurred)
 else
   AC_MSG_RESULT($pyval)
   m4_ifval([$2],[$2],[PY_$1])="$pyval"
   AC_SUBST(m4_ifval([$2],[$2],[PY_$1]))
 fi
])

AC_DEFUN([AX_PYTHON_CONFIG_H],
[
 AC_MSG_CHECKING(location of Python's config.h)
 if test -z "$PYTHON"
 then
   AC_CHECK_PROG(PYTHON,python,python)
 fi
 py_error="no"
 PY_CONFIG_H=`$PYTHON -c "from distutils import sysconfig;dnl
print sysconfig.get_config_h_filename()"` || py_error = "yes"
 if test "$py_error" = "yes"
 then
   AC_MSG_RESULT(no - an error occurred)
 else
   AC_MSG_RESULT($PY_CONFIG_H)
   AC_SUBST(PY_CONFIG_H)
 fi
])

AC_DEFUN([AX_PYTHON_MAKEFILE],
[
 AC_MSG_CHECKING(location of Python's Makefile)
 if test -z "$PYTHON"
 then
   AC_CHECK_PROG(PYTHON,python,python)
 fi
 py_error="no"
 PY_MAKEFILE=`$PYTHON -c "from distutils import sysconfig;dnl
print sysconfig.get_makefile_filename()"` || py_error = "yes"
 if test "$py_error" = "yes"
 then
   AC_MSG_RESULT(no - an error occurred)
 else
   AC_MSG_RESULT($PY_MAKEFILE)
   AC_SUBST(PY_MAKEFILE)
 fi
])
