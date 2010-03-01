# =================================================================================
#  http://www.gnu.org/software/autoconf-archive/ax_cflags_no_writable_strings.html
# =================================================================================
#
# SYNOPSIS
#
#   AX_CFLAGS_NO_WRITABLE_STRINGS [(shellvar [,default, [A/NA]])]
#
# DESCRIPTION
#
#   Try to find a compiler option that makes all string literals readonly.
#
#   The sanity check is done by looking at string.h which has a set of
#   strcpy definitions that should be defined with const-modifiers to not
#   emit a warning in all so many places.
#
#   For the GNU CC compiler it will be -fno-writable-strings -Wwrite-strings
#   The result is added to the shellvar being CFLAGS by default.
#
#   DEFAULTS:
#
#    - $1 shell-variable-to-add-to : CFLAGS
#    - $2 add-value-if-not-found : nothing
#    - $3 action-if-found : add value to shellvariable
#    - $4 action-if-not-found : nothing
#
# LICENSE
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
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

#serial 8

AC_DEFUN([AX_CFLAGS_NO_WRITABLE_STRINGS],[dnl
AS_VAR_PUSHDEF([FLAGS],[CFLAGS])dnl
AS_VAR_PUSHDEF([VAR],[ac_cv_cflags_no_writable_strings])dnl
AC_CACHE_CHECK([m4_ifval([$1],[$1],FLAGS) making strings readonly],
VAR,[VAR="no, unknown"
 AC_LANG_SAVE
 AC_LANG_C
 ac_save_[]FLAGS="$[]FLAGS"
# IRIX C compiler:
#      -use_readonly_const is the default for IRIX C,
#       puts them into .rodata, but they are copied later.
#       need to be "-G0 -rdatashared" for strictmode but
#       I am not sure what effect that has really.         - guidod
for ac_arg dnl
in "-pedantic % -fno-writable-strings -Wwrite-strings" dnl   GCC
   "-pedantic % -fconst-strings -Wwrite-strings" dnl newer  GCC
   "-v -Xc    % -xstrconst" dnl Solaris C - strings go into readonly segment
   "+w1 -Aa   % +ESlit"      dnl HP-UX C - strings go into readonly segment
   "-w0 -std1 % -readonly_strings" dnl Digital Unix - again readonly segment
   "-fullwarn -use_readonly_const %% ok, its the default" dnl IRIX C
   #
do FLAGS="$ac_save_[]FLAGS "`echo $ac_arg | sed -e 's,%%.*,,' -e 's,%,,'`
   AC_TRY_COMPILE([],[return 0;],
   [VAR=`echo $ac_arg | sed -e 's,.*% *,,'` ; break])
done
case ".$VAR" in
   .|.no|.no,*) ;;
   *) # sanity check - testing strcpy() from string.h
      cp config.log config.tmp
      AC_TRY_COMPILE([#include <string.h>],[
      char test[16];
      if (strcpy (test, "test")) return 1;],
      dnl the original did use test -n `$CC testprogram.c`
      [if test `diff config.log config.tmp | grep -i warning | wc -l` != 0
  then VAR="no, suppressed, string.h," ; fi],
      [VAR="no, suppressed, string.h"])
      rm config.tmp
   ;;
esac
   FLAGS="$ac_save_[]FLAGS"
   AC_LANG_RESTORE
])
case ".$VAR" in
     .ok|.ok,*) m4_ifvaln($3,$3) ;;
   .|.no|.no,*) m4_ifvaln($4,$4,[m4_ifval($2,[
        AC_RUN_LOG([: m4_ifval($1,$1,FLAGS)="$m4_ifval($1,$1,FLAGS) $2"])
                      m4_ifval($1,$1,FLAGS)="$m4_ifval($1,$1,FLAGS) $2"])]) ;;
   *) m4_ifvaln($3,$3,[
   if echo " $[]m4_ifval($1,$1,FLAGS) " | grep " $VAR " 2>&1 >/dev/null
   then AC_RUN_LOG([: m4_ifval($1,$1,FLAGS) does contain $VAR])
   else AC_RUN_LOG([: m4_ifval($1,$1,FLAGS)="$m4_ifval($1,$1,FLAGS) $VAR"])
                      m4_ifval($1,$1,FLAGS)="$m4_ifval($1,$1,FLAGS) $VAR"
   fi ]) ;;
esac
AS_VAR_POPDEF([VAR])dnl
AS_VAR_POPDEF([FLAGS])dnl
])

dnl the only difference - the LANG selection... and the default FLAGS

AC_DEFUN([AX_CXXFLAGS_NO_WRITABLE_STRINGS],[dnl
AS_VAR_PUSHDEF([FLAGS],[CXXFLAGS])dnl
AS_VAR_PUSHDEF([VAR],[ax_cv_cxxflags_no_writable_strings])dnl
AC_CACHE_CHECK([m4_ifval($1,$1,FLAGS) making strings readonly],
VAR,[VAR="no, unknown"
 AC_LANG_SAVE
 AC_LANG_CPLUSPLUS
 ac_save_[]FLAGS="$[]FLAGS"
# IRIX C compiler:
#      -use_readonly_const is the default for IRIX C,
#       puts them into .rodata, but they are copied later.
#       need to be "-G0 -rdatashared" for strictmode but
#       I am not sure what effect that has really.         - guidod
for ac_arg dnl
in "-pedantic -Werror % -fno-writable-strings -Wwrite-strings" dnl   GCC
   "-pedantic -Werror % -fconst-strings -Wwrite-strings" dnl newer  GCC
   "-pedantic % -fconst-strings %% no, const-strings is default" dnl newer  GCC
   "-v -Xc    % -xstrconst" dnl Solaris C - strings go into readonly segment
   "+w1 -Aa   % +ESlit"      dnl HP-UX C - strings go into readonly segment
   "-w0 -std1 % -readonly_strings" dnl Digital Unix - again readonly segment
   "-fullwarn -use_readonly_const %% ok, its the default" dnl IRIX C
   #
do FLAGS="$ac_save_[]FLAGS "`echo $ac_arg | sed -e 's,%%.*,,' -e 's,%,,'`
   AC_TRY_COMPILE([],[return 0;],
   [VAR=`echo $ac_arg | sed -e 's,.*% *,,'` ; break])
done
case ".$VAR" in
   .|.no|.no,*) ;;
   *) # sanity check - testing strcpy() from string.h
      cp config.log config.tmp
      AC_TRY_COMPILE([#include <string.h>],[
      char test[16];
      if (strcpy (test, "test")) return 1;],
      dnl the original did use test -n `$CC testprogram.c`
      [if test `diff config.log config.tmp | grep -i warning | wc -l` != 0
  then VAR="no, suppressed, string.h," ; fi],
      [VAR="no, suppressed, string.h"])
      rm config.tmp
   ;;
esac
 FLAGS="$ac_save_[]FLAGS"
 AC_LANG_RESTORE
])
case ".$VAR" in
     .ok|.ok,*) m4_ifvaln($3,$3) ;;
   .|.no|.no,*) m4_ifvaln($4,$4,[m4_ifval($2,[
        AC_RUN_LOG([: m4_ifval($1,$1,FLAGS)="$m4_ifval($1,$1,FLAGS) $VAR"])
                      m4_ifval($1,$1,FLAGS)="$m4_ifval($1,$1,FLAGS) $2"])]) ;;
   *) m4_ifvaln($3,$3,[
   if echo " $[]m4_ifval($1,$1,FLAGS) " | grep " $VAR " 2>&1 >/dev/null
   then AC_RUN_LOG([: m4_ifval($1,$1,FLAGS) does contain $VAR])
   else AC_RUN_LOG([: m4_ifval($1,$1,FLAGS)="$m4_ifval($1,$1,FLAGS) $VAR"])
                      m4_ifval($1,$1,FLAGS)="$m4_ifval($1,$1,FLAGS) $VAR"
   fi ]) ;;
esac
AS_VAR_POPDEF([VAR])dnl
AS_VAR_POPDEF([FLAGS])dnl
])
