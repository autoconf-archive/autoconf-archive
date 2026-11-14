# ===========================================================================
#      https://www.gnu.org/software/autoconf-archive/ax_c_restrict.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   This macro does not actually test restrict support: depending on the
#   compiler, it always succeeds or always fails. Use Autoconf's
#   AC_C_RESTRICT instead.
#
# SYNOPSIS
#
#   AX_C_RESTRICT
#
# DESCRIPTION
#
#   This macro checks if the C99 restrict keyword is broken with the current
#   compiler and optimizations settings. If broken, it undefines restrict to
#   do no harm. As of 2019 gcc since 5.0 and clang since 6.0 (June 2017) are
#   known to be broken and not yet fixed. See
#   https://github.com/rust-lang/rust/issues/54878 with the links to the gcc
#   and clang tickets.
#
# BUGS
#
#   The test supplies complete function definitions, including main, as the
#   body argument of AC_LANG_PROGRAM, so they are nested inside another
#   main. Compilers without nested functions, such as Clang, and GCC with
#   -pedantic-errors reject this, so restrict is always defined away. GNU C
#   accepts the nested functions, but the outer main never calls them and
#   returns 0, so the check always succeeds without testing restrict.
#   [Rating: broken]
#
# LICENSE
#
#   Copyright (c) 2019 Reini Urban <rurban@cpan.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 5

AC_DEFUN([AX_C_RESTRICT],
[
  m4_warn([obsolete], [$0 is obsolete: it does not actually test restrict support; use AC_C_RESTRICT instead])
AC_CACHE_CHECK([for restrict usability],
  [ax_cv_c_restrict_usable],
  [AC_RUN_IFELSE([AC_LANG_PROGRAM([],
  [[
    void copy (int * restrict to, int * restrict from) {
    	*to = *from;
    }
    void test (int *a, int *b) {
    	for (int i = 0; i < 4; i++) {
    	    copy (&b[i & 1], &a[i & 1]);
    	}
    }
    int main (void) {
    	int ary[] = {0, 1, 2};
    	test (&ary[1], &ary[0]);
    	/* printf("%d %d %d\n", ary[0], ary[1], ary[2]);
            2 2 2 is correct
            1 2 2 wrong */
    	return ary[0] == 2 ? 0 : 1;
    }
  ]])],
  [ax_cv_c_restrict_usable=restrict],
  [ax_cv_c_restrict_usable=],
  [ax_cv_c_restrict_usable=])])

if test -z $ax_cv_c_restrict_usable; then
  AC_MSG_RESULT([no])
  AC_DEFINE_UNQUOTED(restrict, $ax_cv_c_restrict_usable,
    [If restrict is broken with this C compiler])
else
  AC_MSG_RESULT([yes])
fi
]) dnl AX_C_RESTRICT
