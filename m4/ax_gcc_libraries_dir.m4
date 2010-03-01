# ===========================================================================
#   http://www.gnu.org/software/autoconf-archive/ax_gcc_libraries_dir.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_GCC_LIBRARIES_DIR(VARIABLE)
#
# DESCRIPTION
#
#   AX_GCC_LIBRARIES_DIR(VARIABLE) defines VARIABLE as the gcc libraries
#   directory. The libraries directory will be obtained using the gcc
#   -print-search-dirs option. This macro requires AX_GCC_OPTION macro.
#
#   Thanks to Alessandro Massignan for his helpful hints.
#
# LICENSE
#
#   Copyright (c) 2009 Francesco Salvestrini <salvestrini@users.sourceforge.net>
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

#serial 4

AC_DEFUN([AX_GCC_LIBRARIES_DIR], [
    AC_REQUIRE([AC_PROG_CC])
    AC_REQUIRE([AC_PROG_SED])

    AS_IF([test "x$GCC" = "xyes"],[
        AX_GCC_OPTION([-print-search-dirs],[],[],[
            AC_MSG_CHECKING([gcc libraries directory])
            ax_gcc_libraries_dir="`$CC -print-search-dirs | $SED -n -e 's,^libraries:[ \t]*=,,p'`"
            AC_MSG_RESULT([$ax_gcc_libraries_dir])
            $1="$ax_gcc_libraries_dir"
        ],[
            unset $1
        ])
    ],[
        AC_MSG_WARN([sorry, no gcc available])
        unset $1
    ])
])
