##### http://autoconf-archive.cryp.to/ac_need_stdint_h.html
#
# OBSOLETE MACRO
#
#   Superseded by AC_CREATE_STDINT_H.
#
# SYNOPSIS
#
#   AC_NEED_STDINT_H [( HEADER-TO-GENERATE [, HEDERS-TO-CHECK])]
#
# DESCRIPTION
#
#   The "ISO C9X: 7.18 Integer types <stdint.h>" section requires the
#   existence of an include file <stdint.h> that defines a set of
#   typedefs, especially uint8_t,int32_t,uintptr_t. Many older
#   installations will not provide this file, but some will have the
#   very same definitions in <inttypes.h>. In other enviroments we can
#   use the inet-types in <sys/types.h> which would define the typedefs
#   int8_t and u_int8_t respectivly.
#
#   This macros will create a local "stdint.h" if it cannot find the
#   global <stdint.h> (or it will create the headerfile given as an
#   argument). In many cases that file will just have a singular
#   "#include <inttypes.h>" statement, while in other environments it
#   will provide the set of basic stdint's defined:
#   int8_t,uint8_t,int16_t,uint16_t,int32_t,uint32_t,intptr_t,uintptr_t
#   int_least32_t.. int_fast32_t.. intmax_t which may or may not rely
#   on the definitions of other files, or using the
#   AC_COMPILE_CHECK_SIZEOF macro to determine the actual sizeof each
#   type.
#
#   If your header files require the stdint-types you will want to
#   create an installable file package-stdint.h that all your other
#   installable header may include. So if you have a library package
#   named "mylib", just use
#
#        AC_NEED_STDINT(zziplib-stdint.h)
#
#   in configure.in and go to install that very header file in
#   Makefile.am along with the other headers (mylib.h) - and the
#   mylib-specific headers can simply use "#include <mylib-stdint.h>"
#   to obtain the stdint-types.
#
#   Remember, if the system already had a valid <stdint.h>, the
#   generated file will include it directly. No need for fuzzy
#   HAVE_STDINT_H things...
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

AC_DEFUN([AC_NEED_STDINT_H],
[AC_MSG_CHECKING([for stdint-types])
 ac_cv_header_stdint="no-file"
 ac_cv_header_stdint_u="no-file"
 for i in $1 inttypes.h sys/inttypes.h sys/int_types.h stdint.h ; do
   AC_CHECK_TYPEDEF_(uint32_t, $i, [ac_cv_header_stdint=$i])
 done
 for i in $1 sys/types.h inttypes.h sys/inttypes.h sys/int_types.h ; do
   AC_CHECK_TYPEDEF_(u_int32_t, $i, [ac_cv_header_stdint_u=$i])
 done
 dnl debugging: __AC_MSG( !$ac_cv_header_stdint!$ac_cv_header_stdint_u! ...)

 ac_stdint_h=`echo ifelse($1, , stdint.h, $1)`
 if test "$ac_cv_header_stdint" != "no-file" ; then
   if test "$ac_cv_header_stdint" != "$ac_stdint_h" ; then
     AC_MSG_RESULT(found in $ac_cv_header_stdint)
     echo "#include <$ac_cv_header_stdint>" >$ac_stdint_h
     AC_MSG_RESULT(creating $ac_stdint_h - (just to include  $ac_cv_header_stdint) )
   else
     AC_MSG_RESULT(found in $ac_stdint_h)
   fi
   ac_cv_header_stdint_generated=false
 elif test "$ac_cv_header_stdint_u" != "no-file" ; then
   AC_MSG_RESULT(found u_types in $ac_cv_header_stdint_u)
   if test $ac_cv_header_stdint = "$ac_stdint_h" ; then
     AC_MSG_RESULT(creating $ac_stdint_h - includes $ac_cv_header_stdint, expect problems!)
   else
     AC_MSG_RESULT(creating $ac_stdint_h - (include inet-types in $ac_cv_header_stdint_u and re-typedef))
   fi
echo "#ifndef __AC_STDINT_H" >$ac_stdint_h
echo "#define __AC_STDINT_H" '"'$ac_stdint_h'"' >>$ac_stdint_h
echo "#ifndef _GENERATED_STDINT_H" >>$ac_stdint_h
echo "#define _GENERATED_STDINT_H" '"'$PACKAGE $VERSION'"' >>$ac_stdint_h
   cat >>$ac_stdint_h <<EOF

#include <stddef.h>
#include <$ac_cv_header_stdint_u>

/* int8_t int16_t int32_t defined by inet code */
typedef u_int8_t uint8_t;
typedef u_int16_t uint16_t;
typedef u_int32_t uint32_t;

/* it's a networkable system, but without any stdint.h */
/* hence it's an older 32-bit system... (a wild guess that seems to work) */
typedef u_int32_t uintptr_t;
typedef   int32_t  intptr_t;
EOF
   ac_cv_header_stdint_generated=true
 else
   AC_MSG_RESULT(not found, need to guess the types now... )
   AC_COMPILE_CHECK_SIZEOF(long, 32)
   AC_COMPILE_CHECK_SIZEOF(void*, 32)
   AC_MSG_RESULT( creating $ac_stdint_h - using detected values for sizeof long and sizeof void* )
echo "#ifndef __AC_STDINT_H" >$ac_stdint_h
echo "#define __AC_STDINT_H" '"'$ac_stdint_h'"' >>$ac_stdint_h
echo "#ifndef _GENERATED_STDINT_H" >>$ac_stdint_h
echo "#define _GENERATED_STDINT_H" '"'$PACKAGE $VERSION'"' >>$ac_stdint_h
   cat >>$ac_stdint_h <<EOF

/* ISO C 9X: 7.18 Integer types <stdint.h> */

#define __int8_t_defined
typedef   signed char    int8_t;
typedef unsigned char   uint8_t;
typedef   signed short  int16_t;
typedef unsigned short uint16_t;
EOF

   if test "$ac_cv_sizeof_long" = "64" ; then
     cat >>$ac_stdint_h <<EOF

typedef   signed int    int32_t;
typedef unsigned int   uint32_t;
typedef   signed long   int64_t;
typedef unsigned long  uint64_t;
#define  int64_t  int64_t
#define uint64_t uint64_t
EOF

   else
    cat >>$ac_stdint_h <<EOF

typedef   signed long   int32_t;
typedef unsigned long  uint32_t;
EOF

   fi
   if test "$ac_cv_sizeof_long" != "$ac_cv_sizeof_voidp" ; then
     cat >>$ac_stdint_h <<EOF

typedef   signed int   intptr_t;
typedef unsigned int  uintptr_t;
EOF
   else
     cat >>$ac_stdint_h <<EOF

typedef   signed long   intptr_t;
typedef unsigned long  uintptr_t;
EOF
     ac_cv_header_stdint_generated=true
   fi
 fi

 if "$ac_cv_header_stdint_generated" ; then
     cat >>$ac_stdint_h <<EOF

typedef  int8_t    int_least8_t;
typedef  int16_t   int_least16_t;
typedef  int32_t   int_least32_t;

typedef uint8_t   uint_least8_t;
typedef uint16_t  uint_least16_t;
typedef uint32_t  uint_least32_t;

typedef  int8_t    int_fast8_t;
typedef  int32_t   int_fast16_t;
typedef  int32_t   int_fast32_t;

typedef uint8_t   uint_fast8_t;
typedef uint32_t  uint_fast16_t;
typedef uint32_t  uint_fast32_t;

typedef long int       intmax_t;
typedef unsigned long uintmax_t;

 /* once */
#endif
#endif
EOF
  fi dnl
])
