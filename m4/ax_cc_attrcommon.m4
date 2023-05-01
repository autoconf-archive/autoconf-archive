# ===========================================================================
#     https://www.gnu.org/software/autoconf-archive/ax_cc_attrcommon.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CC_ATTRCOMMON
#
# DESCRIPTION
#
#   Determine whether the C compiler supports C tentative definitions with
#   __attribute((__common__)) See K&R book Appendix A10.2 on 'extern' and
#   tentative definitions. Some compilers use a 'strict definition-reference
#   model' Traditionally most UNIX C compilers support C tentative
#   definitions. GCC 10 switched from default fcommon to fnocommon and will
#   need __attribute__ ((__common__)) for tentative definitions.
#
#   The $ac_cv_attrcommon variable will be either yes or no, and can be
#   overridden on the command line with using --with-attrcommon
#
#   See also:  ax_cc_tentdef.m4 for a test on C tentative definitions
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

AC_ARG_WITH(attrcommon,
  [  --with-attrcommon       use __attribute__ for C tentative definitions],
  [ac_cv_attrcommon=$withval]
)

AC_DEFUN([AX_CC_ATTRCOMMON],
[
AC_MSG_CHECKING(whether compiler supports __attribute__((__common__)))
AC_CACHE_VAL(ac_cv_attrcommon,[
t1="ac$$.c"
o1="ac$$.o"
ac_clean_files="$t1 $o1"
cat >$t1 <<EOF
__attribute__((__common__)) int a = 7;
EOF
# tentative definitions are resolved using 'common storage'
# this is the traditional case for most C compilers (K&R book Appendix A10.2)
# this case is supported by setting CC to 'gcc -fcommon'
# which is since gcc 10 not the default (it defaults now to -fno-common)
echo "$CC -c $t1" >&5
if $CC -c $t1 2>&5 1>&5
  then
    echo " (no)" >&5
    ac_cv_attrcommon=yes;
  else
    echo " (yes)" >&5
    ac_cv_attrcommon=no;
fi
rm -rf $ac_clean_files
],ac_cv_attrcommon=yes,ac_cv_attrcommon=no)
AC_MSG_RESULT($ac_cv_attrcommon)
])
