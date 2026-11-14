# ===========================================================================
#   https://www.gnu.org/software/autoconf-archive/ax_python_config_var.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   This macro uses Python 2 syntax and the distutils module, so it does not
#   work with Python 3. Use AX_PYTHON_DEVEL instead.
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
#   configuration variable. PYTHON_VARIABLE is the name of the variable to
#   request from Python, and SHELL_VARIABLE is the name of the shell
#   variable into which the results should be deposited. If SHELL_VARIABLE
#   is not specified, the macro will prefix PY_ to the PYTHON_VARIABLE,
#   e.g., LIBS -> PY_LIBS.
#
#   SHELL_VARIABLE is AC_SUBST'd. No action is taken if an error occurs.
#   Note if $PYTHON is not set, AC_CHECK_PROG(PYTHON, python, python) will
#   be run.
#
#   Example:
#
#     AX_PYTHON_CONFIG_VAR(LINKFORSHARED, PY_LFS)
#
#   AX_PYTHON_CONFIG_H:
#
#   Using the Python module distutils.sysconfig[1], put the full pathname of
#   the config.h file used to compile Python into the shell variable
#   PY_CONFIG_H. PY_CONFIG_H is AC_SUBST'd. Note if $PYTHON is not set,
#   AC_CHECK_PROG(PYTHON, python, python) will be run.
#
#   AX_PYTHON_MAKEFILE:
#
#   Using the Python module distutils.sysconfig[1], put the full pathname of
#   the Makefile file used to compile Python into the shell variable
#   PY_MAKEFILE. PY_MAKEFILE is AC_SUBST'd. Note if $PYTHON is not set,
#   AC_CHECK_PROG(PYTHON, python, python) will be run.
#
#   [1]
#   http://www.python.org/doc/current/dist/module-distutils.sysconfig.html
#
# BUGS
#
#   (1) All three queries use Python 2 print statements. With Python 3 they
#   fail with SyntaxError, so the configuration values and paths cannot be
#   retrieved. [Rating: broken]
#
#   (2) The error paths in AX_PYTHON_CONFIG_H and AX_PYTHON_MAKEFILE use
#   py_error = "yes" instead of an assignment. The shell tries to execute
#   py_error and the macro can report a failed query as success. [Rating:
#   major]
#
#   (3) Private shell variables such as py_error and pyval lack an ax_
#   prefix. They share configure's shell namespace with callers and other
#   macros, so they may collide with variables of the same name. These
#   variables should use macro-specific ax_ names. [Rating: minor]
#
# LICENSE
#
#   Copyright (c) 2008 Dustin J. Mitchell <dustin@cs.uchicago.edu>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 14

AC_DEFUN([AX_PYTHON_CONFIG_VAR],
[
  m4_warn([obsolete], [$0 is obsolete: it does not work with Python 3; use AX_PYTHON_DEVEL instead])
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
  m4_warn([obsolete], [$0 is obsolete: it does not work with Python 3; use AX_PYTHON_DEVEL instead])
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
  m4_warn([obsolete], [$0 is obsolete: it does not work with Python 3; use AX_PYTHON_DEVEL instead])
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
