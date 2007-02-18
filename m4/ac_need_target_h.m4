##### http://autoconf-archive.cryp.to/ac_need_target_h.html
#
# OBSOLETE MACRO
#
#   Superseded by AC_CREATE_TARGET_H.
#
# SYNOPSIS
#
#   AC_NEED_TARGET_H [(PREFIX, [HEADER-FILE])]
#
# DESCRIPTION
#
#   Create the header-file and let it contain '#defines' for the target
#   platform. This macro is used for libraries that have
#   platform-specific quirks. Instead of inventing a target-specific
#   target.h.in files, just let it create a header file from the
#   definitions of AC_CANONICAL_SYSTEM and put only 'ifdef's in the
#   installed header-files.
#
#   If the PREFIX is absent, [TARGET] is used. if the HEADER-FILE is
#   absent, [target.h] is used. the prefix can be the packagename. (`tr
#   a-z- A-Z_`)
#
#   The defines look like...
#
#    #ifndef TARGET_CPU_M68K
#    #define TARGET_CPU_M68K "m68k"
#    #endif
#
#    #ifndef TARGET_OS_LINUX
#    #define TARGET_OS_LINUX "linux-gnu"
#    #endif
#
#    #ifndef TARGET_OS_TYPE                     /* the string itself */
#    #define TARGET_OS_TYPE "linux-gnu"
#    #endif
#
#   Detail: In the case of hppa1.1, the three idents "hppa1_1" "hppa1"
#   and "hppa" are derived, for an m68k it just two, "m68k" and "m".
#
#   The NEED_TARGET_OS_H variant is almost the same function, but
#   everything is lowercased instead of uppercased, and there is a "__"
#   in front of each prefix, so it looks like...
#
#    #ifndef __target_os_linux
#    #define __target_os_linux "linux-gnulibc2"
#    #endif
#
#    #ifndef __target_os__                     /* the string itself */
#    #define __target_os__ "linux-gnulibc2"
#    #endif
#
#    #ifndef __target_cpu_i586
#    #define __target_cpu_i586 "i586"
#    #endif
#
#    #ifndef __target_arch_i386
#    #define __target_arch_i386 "i386"
#    #endif
#
#    #ifndef __target_arch__                   /* cpu family arch */
#    #define __target_arch__ "i386"
#    #endif
#
#   Other differences: The default string-define is "__" insteadof
#   "_TYPE" and the default filename is "target-os.h" instead of just
#   "target.h".
#
#   Personally I prefer the second variant (which had been the first in
#   the devprocess of this file but I assume people will often fallback
#   to the primary variant presented herein).
#
# LAST MODIFICATION
#
#   2006-10-13
#
# COPYLEFT
#
#   Copyright (c) 2006 Guido U. Draheim <guidod@gmx.de>
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
#   02111-1307, USA.
#
#   As a special exception, the respective Autoconf Macro's copyright
#   owner gives unlimited permission to copy, distribute and modify the
#   configure scripts that are the output of Autoconf when processing
#   the Macro. You need not follow the terms of the GNU General Public
#   License when using or distributing such scripts, even though
#   portions of the text of the Macro appear in them. The GNU General
#   Public License (GPL) does govern all other use of the material that
#   constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the
#   Autoconf Macro released by the Autoconf Macro Archive. When you
#   make and distribute a modified version of the Autoconf Macro, you
#   may extend this special exception to the GPL to apply to your
#   modified version as well.

AC_DEFUN([AC_NEED_TARGET_H],
[AC_REQUIRE([AC_CANONICAL_SYSTEM_ARCH])
ac_need_target_h_file=`echo ifelse($2, , target.h, $2)`
ac_need_target_h_prefix=`echo ifelse($1, , target, $1) | tr abcdefghijklmnopqrstuvwxyz- ABCDEFGHIJKLMNOPQRSTUVWXYZ_ | tr -dc ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_ `
AC_MSG_RESULT(creating $ac_need_target_h_file - to export target_os as $ac_need_target_h_prefix-defines)
#
changequote({, })dnl
#
target_os0=`echo "$target_os"  | tr abcdefghijklmnopqrstuvwxyz.- ABCDEFGHIJKLMNOPQRSTUVWXYZ__ | tr -dc ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_ `
target_os1=`echo "$target_os0" | sed -e 's:\([^0-9]*\).*:\1:' `
target_os2=`echo "$target_os0" | sed -e 's:\([^_]*\).*:\1:' `
target_os3=`echo "$target_os2" | sed -e 's:\([^0-9]*\).*:\1:' `
#
target_cpu0=`echo "$target_cpu"  | tr abcdefghijklmnopqrstuvwxyz.- ABCDEFGHIJKLMNOPQRSTUVWXYZ__ | tr -dc ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_`
target_cpu1=`echo "$target_cpu0" | sed -e 's:\([^0-9]*\).*:\1:' `
target_cpu2=`echo "$target_cpu0" | sed -e 's:\([^_]*\).*:\1:' `
target_cpu3=`echo "$target_cpu2" | sed -e 's:\([^0-9]*\).*:\1:' `
#
target_cpu_arch0=`echo "$target_cpu_arch" | tr abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ`
#
changequote([, ])dnl
#
echo /'*' automatically generated by $PACKAGE configure '*'/ >$ac_need_target_h_file
echo /'*' on `date` '*'/ >>$ac_need_target_h_file
dnl
old1=""
old2=""
for i in $target_os0 $target_os1 $target_os2 $target_os3 "TYPE"
do
  if test "$old1" != "$i"; then
  if test "$old2" != "$i"; then
   echo " " >>$ac_need_target_h_file
   echo "#ifndef "$ac_need_target_h_prefix"_OS_"$i >>$ac_need_target_h_file
   echo "#define "$ac_need_target_h_prefix"_OS_"$i '"'"$target_os"'"' >>$ac_need_target_h_file
   echo "#endif" >>$ac_need_target_h_file
  fi
  fi
  old2="$old1"
  old1="$i"
done
#
old1=""
old2=""
for i in $target_cpu0 $target_cpu1 $target_cpu2 $target_cpu3 "TYPE"
do
  if test "$old1" != "$i"; then
  if test "$old2" != "$i"; then
   echo " " >>$ac_need_target_h_file
   echo "#ifndef "$ac_need_target_h_prefix"_CPU_"$i >>$ac_need_target_h_file
   echo "#define "$ac_need_target_h_prefix"_CPU_"$i '"'"$target_cpu"'"' >>$ac_need_target_h_file
   echo "#endif" >>$ac_need_target_h_file
  fi
  fi
  old2="$old1"
  old1="$i"
done
#
old1=""
old2=""
for i in $target_cpu_arch0 "TYPE"
do
  if test "$old1" != "$i"; then
  if test "$old2" != "$i"; then
   echo " " >>$ac_need_target_h_file
   echo "#ifndef "$ac_need_target_h_prefix"_ARCH_"$i >>$ac_need_target_h_file
   echo "#define "$ac_need_target_h_prefix"_ARCH_"$i '"'"$target_cpu_arch"'"' >>$ac_need_target_h_file
   echo "#endif" >>$ac_need_target_h_file
  fi
  fi
  old2="$old1"
  old1="$i"
done
])

dnl
dnl ... the lowercase variant ...
dnl
AC_DEFUN([AC_NEED_TARGET_OS_H],
[AC_REQUIRE([AC_CANONICAL_SYSTEM_ARCH])
ac_need_target_h_file=`echo ifelse($2, , target-os.h, $2)`
ac_need_target_h_prefix=`echo ifelse($1, , target, $1) | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ- abcdefghijklmnopqrstuvwxyz_ | tr -dc abcdefghijklmnopqrstuvwxyz1234567890_`
AC_MSG_RESULT(creating $ac_need_target_h_file - to export target_os as __$ac_need_target_h_prefix-defines)
#
changequote({, })dnl
#
target_os0=`echo "$target_os"  | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ.- abcdefghijklmnopqrstuvwxyz__ | tr -dc abcdefghijklmnopqrstuvwxyz1234567890_ `
target_os1=`echo "$target_os0" | sed -e 's:\([^0-9]*\).*:\1:' `
target_os2=`echo "$target_os0" | sed -e 's:\([^_]*\).*:\1:' `
target_os3=`echo "$target_os2" | sed -e 's:\([^0-9]*\).*:\1:' `
#
target_cpu0=`echo "$target_cpu"  | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ.- abcdefghijklmnopqrstuvwxyz__ | tr -dc abcdefghijklmnopqrstuvwxyz1234567890_`
target_cpu1=`echo "$target_cpu0" | sed -e 's:\([^0-9]*\).*:\1:' `
target_cpu2=`echo "$target_cpu0" | sed -e 's:\([^_]*\).*:\1:' `
target_cpu3=`echo "$target_cpu2" | sed -e 's:\([^0-9]*\).*:\1:' `
#
target_cpu_arch0=`echo "$target_cpu_arch" | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz`
#
changequote([, ])dnl
#
echo /'*' automatically generated by $PACKAGE configure '*'/ >$ac_need_target_h_file
echo /'*' on `date` '*'/ >>$ac_need_target_h_file
dnl
old1=""
old2=""
for i in $target_os0 $target_os1 $target_os2 $target_os3 "_";
do
  if test "$old1" != "$i"; then
  if test "$old2" != "$i"; then
   echo " " >>$ac_need_target_h_file
   echo "#ifndef __"$ac_need_target_h_prefix"_os_"$i >>$ac_need_target_h_file
   echo "#define __"$ac_need_target_h_prefix"_os_"$i '"'"$target_os"'"' >>$ac_need_target_h_file
   echo "#endif" >>$ac_need_target_h_file
  fi
  fi
  old2="$old1"
  old1="$i"
done
#
old1=""
old2=""
for i in $target_cpu0 $target_cpu1 $target_cpu2 $target_cpu3 "_"
do
  if test "$old1" != "$i"; then
  if test "$old2" != "$i"; then
   echo " " >>$ac_need_target_h_file
   echo "#ifndef __"$ac_need_target_h_prefix"_cpu_"$i >>$ac_need_target_h_file
   echo "#define __"$ac_need_target_h_prefix"_cpu_"$i '"'"$target_cpu"'"' >>$ac_need_target_h_file
   echo "#endif" >>$ac_need_target_h_file
  fi
  fi
  old2="$old1"
  old1="$i"
done
#
old1=""
old2=""
for i in $target_cpu_arch0 "_"
do
  if test "$old1" != "$i"; then
  if test "$old2" != "$i"; then
   echo " " >>$ac_need_target_h_file
   echo "#ifndef __"$ac_need_target_h_prefix"_arch_"$i >>$ac_need_target_h_file
   echo "#define __"$ac_need_target_h_prefix"_arch_"$i '"'"$target_cpu_arch"'"' >>$ac_need_target_h_file
   echo "#endif" >>$ac_need_target_h_file
  fi
  fi
  old2="$old1"
  old1="$i"
done
])

dnl
dnl the instruction set architecture (ISA) has evolved for a small set
dnl of cpu types. So they often have specific names, e.g. sparclite,
dnl yet they share quite a few similarities. This macro will set the
dnl shell-var $target_cpu_arch to the basic type. Note that these
dnl names are often in conflict with their original 32-bit type name
dnl of these processors, just use them for directory-handling or add
dnl a prefix/suffix to distinguish them from $target_cpu
dnl
dnl this macros has been invented since config.guess is sometimes
dnl too specific about the cpu-type. I chose the names along the lines
dnl of linux/arch/ which is modelled after widespread arch-naming, IMHO.
dnl
AC_DEFUN([AC_CANONICAL_SYSTEM_ARCH],
[AC_REQUIRE([AC_CANONICAL_SYSTEM])
target_cpu_arch="unknown"
case $target_cpu in
 i386*|i486*|i586*|i686*|i786*) target_cpu_arch=i386 ;;
 power*)   target_cpu_arch=ppc ;;
 arm*)     target_cpu_arch=arm ;;
 sparc64*) target_cpu_arch=sparc64 ;;
 sparc*)   target_cpu_arch=sparc ;;
 mips64*)  target_cpu_arch=mips64 ;;
 mips*)    target_cpu_arch=mips ;;
 alpa*)    target_cpu_arch=alpha ;;
esac
])
