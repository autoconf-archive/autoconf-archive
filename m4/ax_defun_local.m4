# ===========================================================================
#      https://www.gnu.org/software/autoconf-archive/ax_defun_local.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_DEFUN_LOCAL([namespace],[funcname],[function definition])
#
# DESCRIPTION
#
#   This simply defines a m4 macro using autoconf AC_DEFUN but prepending to
#   the function name a namespace prefix that should be uniquely defined.
#   Using the namespace one can write a set of function inside a macro file
#   that are visible with the provided funcion names only within the
#   AC_PUSH_LOCAL and AC_POP_LOCAL calls.
#
#   example:
#
#     AC_DEFUN([AX_TEST_LOCAL_NAMESPACE],[
#      AC_PUSH_LOCAL([my_unique_namespace_name])
#      PRINT_HELLO_WORLD
#      AC_POP_LOCAL([my_unique_namespace_name])
#     ])
#
#     AX_DEFUN_LOCAL([my_unique_namespace_name],[AS_BANNER],[
#                     AS_ECHO
#                     AS_BOX([// LOCAL!! $1 //////], [\/])
#                     AS_ECHO
#                    ])
#
#     AX_DEFUN_LOCAL([my_unique_namespace_name],[PRINT_HELLO],
#                    [AS_BANNER(["hello $1"])])
#
#     AX_DEFUN_LOCAL([my_unique_namespace_name],[PRINT_HELLO_WORLD],
#                    [PRINT_HELLO(world)])
#
# LICENSE
#
#   Copyright (c) 2016 Andrea Rigoni Garola <andrea.rigoni@igi.cnr.it>
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

#serial 1

AC_DEFUN([AX_DEFUN_LOCAL],
         [m4_defun([$1_$2],[$3])
          m4_append_uniq([$1_FUNCS],[[[$2]]],[,])])

AC_DEFUN([AX_PUSH_LOCAL],
         [m4_foreach([func],[$1_FUNCS],[m4_pushdef(func,m4_defn($1_[]func))])])

AC_DEFUN([AX_POP_LOCAL],
         [m4_foreach([func],[$1_FUNCS],[m4_popdef(func)])])
