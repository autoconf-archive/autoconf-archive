# ===========================================================================
#            http://autoconf-archive.cryp.to/ac_prog_javadoc.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_PROG_JAVADOC
#
# DESCRIPTION
#
#   AC_PROG_JAVADOC tests for an existing javadoc generator. It uses the
#   environment variable JAVADOC then tests in sequence various common
#   javadoc generator.
#
#   If you want to force a specific compiler:
#
#   - at the configure.in level, set JAVADOC=yourgenerator before calling
#   AC_PROG_JAVADOC
#
#   - at the configure level, setenv JAVADOC
#
#   You can use the JAVADOC variable in your Makefile.in, with @JAVADOC@.
#
#   Note: This macro depends on the autoconf M4 macros for Java programs. It
#   is VERY IMPORTANT that you download that whole set, some macros depend
#   on other. Unfortunately, the autoconf archive does not support the
#   concept of set of macros, so I had to break it for submission.
#
#   The general documentation of those macros, as well as the sample
#   configure.in, is included in the AC_PROG_JAVA macro.
#
# LICENSE
#
#   Copyright (c) 2008 Egon Willighagen <e.willighagen@science.ru.nl>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_PROG_JAVADOC],[
AC_REQUIRE([AC_EXEEXT])dnl
if test "x$JAVAPREFIX" = x; then
        test "x$JAVADOC" = x && AC_CHECK_PROGS(JAVADOC, javadoc$EXEEXT)
else
        test "x$JAVADOC" = x && AC_CHECK_PROGS(JAVADOC, javadoc, $JAVAPREFIX)
fi
test "x$JAVADOC" = x && AC_MSG_ERROR([no acceptable javadoc generator found in \$PATH])
AC_PROVIDE([$0])dnl
])
