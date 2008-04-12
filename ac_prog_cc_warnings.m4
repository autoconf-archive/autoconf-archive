# ===========================================================================
#          http://autoconf-archive.cryp.to/ac_prog_cc_warnings.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Renamed to VL_PROG_CC_WARNINGS, or use AX_CFLAGS_WARN_ALL.
#
# SYNOPSIS
#
#   AC_PROG_CC_WARNINGS([ANSI])
#
# DESCRIPTION
#
#   Enables a reasonable set of warnings for the C compiler. Optionally, if
#   the first argument is nonempty, turns on flags which enforce and/or
#   enable proper ANSI C if such are known with the compiler used.
#
#   Currently this macro knows about GCC, Solaris C compiler, Digital Unix C
#   compiler, C for AIX Compiler, HP-UX C compiler, IRIX C compiler, NEC
#   SX-5 (Super-UX 10) C compiler, and Cray J90 (Unicos 10.0.0.8) C
#   compiler.
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Ville Laurikari <vl@iki.fi>
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
#   Macro released by the Autoconf Macro Archive. When you make and
#   distribute a modified version of the Autoconf Macro, you may extend this
#   special exception to the GPL to apply to your modified version as well.

AC_DEFUN([AC_PROG_CC_WARNINGS], [
  ansi=$1
  if test -z "$ansi"; then
    msg="for C compiler warning flags"
  else
    msg="for C compiler warning and ANSI conformance flags"
  fi
  AC_CACHE_CHECK($msg, ac_cv_prog_cc_warnings, [
    if test -n "$CC"; then
      cat > conftest.c <<EOF
int main(int argc, char **argv) { return 0; }
EOF

      dnl GCC
      if test "$GCC" = "yes"; then
        if test -z "$ansi"; then
          ac_cv_prog_cc_warnings="-Wall"
        else
          ac_cv_prog_cc_warnings="-Wall -ansi -pedantic"
        fi

      dnl Solaris C compiler
      elif $CC -flags 2>&1 | grep "Xc.*strict ANSI C" > /dev/null 2>&1 &&
           $CC -c -v -Xc conftest.c > /dev/null 2>&1 &&
           test -f conftest.o; then
        if test -z "$ansi"; then
          ac_cv_prog_cc_warnings="-v"
        else
          ac_cv_prog_cc_warnings="-v -Xc"
        fi

      dnl HP-UX C compiler
      elif $CC > /dev/null 2>&1 &&
           $CC -c -Aa +w1 conftest.c > /dev/null 2>&1 &&
           test -f conftest.o; then
        if test -z "$ansi"; then
          ac_cv_prog_cc_warnings="+w1"
        else
          ac_cv_prog_cc_warnings="+w1 -Aa"
        fi

      dnl Digital Unix C compiler
      elif $CC -c -verbose -w0 -warnprotos -std1 conftest.c > /dev/null 2>&1 &&
           test -f conftest.o; then
        if test -z "$ansi"; then
          ac_cv_prog_cc_warnings="-verbose -w0 -warnprotos"
        else
          ac_cv_prog_cc_warnings="-verbose -w0 -warnprotos -std1"
        fi

      dnl C for AIX Compiler
      elif $CC 2>&1 | grep AIX > /dev/null 2>&1 &&
           $CC -c -qlanglvl=ansi -qinfo=all conftest.c > /dev/null 2>&1 &&
           test -f conftest.o; then
        if test -z "$ansi"; then
          ac_cv_prog_cc_warnings="-qsrcmsg -qinfo=all:noppt:noppc:noobs:nocnd"
        else
          ac_cv_prog_cc_warnings="-qsrcmsg -qinfo=all:noppt:noppc:noobs:nocnd -qlanglvl=ansi"
        fi

      dnl IRIX C compiler
      elif $CC -c -fullwarn -ansi -ansiE conftest.c > /dev/null 2>&1 &&
           test -f conftest.o; then
        if test -z "$ansi"; then
          ac_cv_prog_cc_warnings="-fullwarn"
        else
          ac_cv_prog_cc_warnings="-fullwarn -ansi -ansiE"
        fi

      dnl The NEC SX-5 (Super-UX 10) C compiler
      elif $CC -c -pvctl[,]fullmsg -Xc conftest.c > /dev/null 2>&1 &&
           test -f conftest.o; then
        if test -z "$ansi"; then
          ac_cv_prog_cc_warnings="-pvctl[,]fullmsg"
        else
          ac_cv_prog_cc_warnings="-pvctl[,]fullmsg -Xc"
        fi

      dnl The Cray J90 (Unicos 10.0.0.8) C compiler
      elif $CC -c -h msglevel 2 conftest.c > /dev/null 2>&1 &&
           test -f conftest.o; then
        if test -z "$ansi"; then
          ac_cv_prog_cc_warnings="-h msglevel 2"
        else
          ac_cv_prog_cc_warnings="-h msglevel 2 -h conform"
        fi

      fi
      rm -f conftest.*
    fi
    if test -n "$ac_cv_prog_cc_warnings"; then
      CFLAGS="$CFLAGS $ac_cv_prog_cc_warnings"
    else
      ac_cv_prog_cc_warnings="unknown"
    fi
  ])
])
