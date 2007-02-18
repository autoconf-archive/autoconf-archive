##### http://autoconf-archive.cryp.to/ac_prog_perl_modules.html
#
# SYNOPSIS
#
#   AC_PROG_PERL_MODULES([MODULES], [ACTION-IF-TRUE], [ACTION-IF-FALSE])
#
# DESCRIPTION
#
#   Checks to see if the given perl modules are available. If true the
#   shell commands in ACTION-IF-TRUE are executed. If not the shell
#   commands in ACTION-IF-FALSE are run. Note if $PERL is not set (for
#   example by calling AC_CHECK_PROG, or AC_PATH_PROG),
#   AC_CHECK_PROG(PERL, perl, perl) will be run.
#
#   Example:
#
#     AC_CHECK_PERL_MODULES(Text::Wrap Net::LDAP, ,
#                           AC_MSG_WARN(Need some Perl modules)
#
# LAST MODIFICATION
#
#   2002-09-25
#
# COPYLEFT
#
#   Copyright (c) 2002 Dean Povey <povey@wedgetail.com>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AC_PROG_PERL_MODULES],[dnl
ac_perl_modules="$1"
# Make sure we have perl
if test -z "$PERL"; then
AC_CHECK_PROG(PERL,perl,perl)
fi

if test "x$PERL" != x; then
  ac_perl_modules_failed=0
  for ac_perl_module in $ac_perl_modules; do
    AC_MSG_CHECKING(for perl module $ac_perl_module)

    # Would be nice to log result here, but can't rely on autoconf internals
    $PERL "-M$ac_perl_module" -e exit > /dev/null 2>&1
    if test $? -ne 0; then
      AC_MSG_RESULT(no);
      ac_perl_modules_failed=1
   else
      AC_MSG_RESULT(ok);
    fi
  done

  # Run optional shell commands
  if test "$ac_perl_modules_failed" = 0; then
    :
    $2
  else
    :
    $3
  fi
else
  AC_MSG_WARN(could not find perl)
fi])dnl
