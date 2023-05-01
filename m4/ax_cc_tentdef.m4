# ===========================================================================
#      https://www.gnu.org/software/autoconf-archive/ax_cc_tentdef.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CC_TENTDEF
#
# DESCRIPTION
#
#   Determine whether the C compiler supports C tentative definitions. See
#   K&R book Appendix A10.2 on 'extern' and tentative definitions. Some
#   compilers use a 'strict definition-reference model' Traditionally most
#   UNIX C compilers support tentative definitions, whereas some compiler
#   such as Metrowerks or WATCOM C do not.
#
#   The $ac_cv_tentdef variable will be either no or yes, and can be
#   overridden on the command line using --with-tentdef
#
#   See also:  ax_cc_attrcommon.m4 for a __attribute__(( __common__)) test
#
# LICENSE
#
#   Copyright (c) 1996-2023 David Stes
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
#   with this program. If not, see <https://www.gnu.org/licenses/>.

#serial 4

AC_ARG_WITH(tentdef,
  [  --with-tentdef          use C tentative definitions],
  [ac_cv_tentdef=$withval]
)

AC_DEFUN([AX_CC_TENTDEF],
[
AC_MSG_CHECKING(whether compiler supports C tentative definitions)
AC_CACHE_VAL(ac_cv_tentdef,[
t1="x$$.c"
t2="y$$.c"
e1="x$$"
e2="y$$"
ac_clean_files="$e1 $e2 $t1 $t2"

# this is the traditional case for most compilers (K&R book Appendix A10.2)
# tentative definitions are resolved using 'common storage'
# this case is supported by setting CC to 'gcc -fcommon'
# which is since gcc 10 not the default (it defaults now to -fno-common)
cat >$t1 <<EOF
int a = 7;
EOF

cat >$t2 <<EOF
#include <stdio.h>
int a;
int main() { exit(a);return a; }
EOF

echo "$CC $t1 $t2 -o $e1" >&5
($CC $t1 $t2 -o $e1) 2>&5 1>&5
echo "$CC $t2 $t1 -o $e2" >&5
($CC $t2 $t1 -o $e2) 2>&5 1>&5

if test -x ./$e1 -a -x ./$e2
then
  echo -n "check whether $e1 returns '7'" >&5
  if ./$e1 != 7
  then
    echo " (no)" >&5
    ac_cv_tentdef=no;
  else
    echo " (yes)" >&5
    echo -n "check whether $e2 returns '7'" >&5
    if ./$e2 != 7
    then
     echo " (no)" >&5
     ac_cv_tentdef=no
    else
     echo " (yes)" >&5
     ac_cv_tentdef=yes;
    fi
  fi
else
  ac_cv_tentdef=no;
fi
rm -rf $ac_clean_files
],ac_cv_tentdef=no,ac_cv_tentdef=yes)
AC_MSG_RESULT($ac_cv_tentdef)
])
