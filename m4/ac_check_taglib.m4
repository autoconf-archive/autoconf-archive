# ===========================================================================
#            http://autoconf-archive.cryp.to/ac_check_taglib.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_CHECK_TAGLIB(version, action-if, action-if-not)
#
# DESCRIPTION
#
#   Defines and exports TAGLIB_LIBS, TAGLIB_CFLAGS. See taglib-config man
#   page.
#
# LICENSE
#
#   Copyright (c) 2008 Akos Maroy <darkeye@tyrell.hu>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_CHECK_TAGLIB], [
  succeeded=no

  if test -z "$TAGLIB_CONFIG"; then
    AC_PATH_PROG(TAGLIB_CONFIG, taglib-config, no)
  fi

  if test "$TAGLIB_CONFIG" = "no" ; then
    echo "*** The taglib-config script could not be found. Make sure it is"
    echo "*** in your path, and that taglib is properly installed."
    echo "*** Or see http://developer.kde.org/~wheeler/taglib.html"
  else
    TAGLIB_VERSION=`$TAGLIB_CONFIG --version`
    AC_MSG_CHECKING(for taglib >= $1)
        VERSION_CHECK=`expr $TAGLIB_VERSION \>\= $1`
        if test "$VERSION_CHECK" = "1" ; then
            AC_MSG_RESULT(yes)
            succeeded=yes

            AC_MSG_CHECKING(TAGLIB_CFLAGS)
            TAGLIB_CFLAGS=`$TAGLIB_CONFIG --cflags`
            AC_MSG_RESULT($TAGLIB_CFLAGS)

            AC_MSG_CHECKING(TAGLIB_LIBS)
            TAGLIB_LIBS=`$TAGLIB_CONFIG --libs`
            AC_MSG_RESULT($TAGLIB_LIBS)
        else
            TAGLIB_CFLAGS=""
            TAGLIB_LIBS=""
            ## If we have a custom action on failure, don't print errors, but
            ## do set a variable so people can do so.
            ifelse([$3], ,echo "can't find taglib >= $1",)
        fi

        AC_SUBST(TAGLIB_CFLAGS)
        AC_SUBST(TAGLIB_LIBS)
  fi

  if test $succeeded = yes; then
     ifelse([$2], , :, [$2])
  else
     ifelse([$3], , AC_MSG_ERROR([Library requirements (taglib) not met.]), [$3])
  fi
])
