# ===========================================================================
#        http://autoconf-archive.cryp.to/ac_prompt_user_no_define.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_PROMPT_USER_NO_DEFINE(VARIABLENAME,QUESTION,[DEFAULT])
#
# DESCRIPTION
#
#   Asks a QUESTION and puts the results in VARIABLENAME with an optional
#   DEFAULT value if the user merely hits return.
#
# LICENSE
#
#   Copyright (c) 2008 Wes Hardaker <wjhardaker@ucdavis.edu>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_PROMPT_USER_NO_DEFINE],
dnl changequote(<<, >>) dnl
dnl <<
[
if test "x$defaults" = "xno"; then
echo $ac_n "$2 ($3): $ac_c"
read tmpinput
if test "$tmpinput" = "" -a "$3" != ""; then
  tmpinput="$3"
fi
eval $1=\"$tmpinput\"
else
tmpinput="$3"
eval $1=\"$tmpinput\"
fi
]
dnl >>
dnl changequote([, ])
) dnl done AC_PROMPT_USER
