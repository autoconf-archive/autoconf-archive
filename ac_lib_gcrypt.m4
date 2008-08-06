# ===========================================================================
#             http://autoconf-archive.cryp.to/ac_lib_gcrypt.html
# ===========================================================================
#
# SYNOPSIS
#
#   AC_LIB_GCRYPT([yes|no|auto])
#
# DESCRIPTION
#
#   Searches for the 'gcrypt' library with the --with... option.
#
#   If found, define HAVE_GCRYPT and macro GCRYPT_LIBS and GCRYPT_CFLAGS.
#   Also defines GCRYPT_WITH_<algo> for the algorithms found available.
#   Possible algorithms are: AES ARCFOUR BLOWFISH CAST5 DES IDEA RFC2268
#   SERPENT TWOFISH CRC HAVAL MD2 MD4 MD5 RMD160 SHA0 SHA1 SHA224 SHA256
#   SHA384 SHA512 TIGER WHIRLPOOL DSA ELGAMAL RSA
#
#   The argument is used if no --with...-gcrypt option is set. Value "yes"
#   requires the configuration by default. Value "no" does not require it by
#   default. Value "auto" configures the library only if available.
#
# LAST MODIFICATION
#
#   2008-08-06
#
# COPYLEFT
#
#   Copyright (c) 2008 Fabien Coelho <autoconf.archive@coelho.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

# AC_CHECK_GCRYPT_ALGO([algo])
# generate convenient defines for each algorithm
AC_DEFUN([AC_CHECK_GCRYPT_ALGO],[
  AC_REQUIRE([AC_PROG_EGREP])
  AC_MSG_CHECKING([for $1 in gcrypt])
  if echo $gcrypt_algos | $EGREP -i ":.*( $1 | $1$)" > /dev/null ; then
    AC_DEFINE([GCRYPT_WITH_$1],[1],[Algorithm $1 in gcrypt library])
    AC_MSG_RESULT([yes])
  else
    AC_MSG_RESULT([no])
  fi
])

AC_DEFUN([AC_LIB_GCRYPT],[
  AC_MSG_CHECKING([whether gcrypt is enabled])
  AC_ARG_WITH([gcrypt],[  --with-gcrypt           require gcrypt library
  --without-gcrypt        disable gcrypt library],[
    AC_MSG_RESULT([$withval])
    ac_with_gcrypt=$withval
  ],[
    AC_MSG_RESULT($1)
    ac_with_gcrypt=$1
  ])
  if test "$ac_with_gcrypt" = "yes" -o "$ac_with_gcrypt" = "auto" ; then
    AM_PATH_LIBGCRYPT([1.2.0],[
      AC_DEFINE([HAVE_GCRYPT],[1],[Gcrypt library is available])
      HAVE_GCRYPT=1
      # checking for available algorithms...
      gcrypt_algos=`$LIBGCRYPT_CONFIG --algorithms`
      # ciphers
      # this does not work with a "for" loop: nothing generated in config.h:-(
      AC_CHECK_GCRYPT_ALGO([AES])
      AC_CHECK_GCRYPT_ALGO([ARCFOUR])
      AC_CHECK_GCRYPT_ALGO([BLOWFISH])
      AC_CHECK_GCRYPT_ALGO([CAST5])
      AC_CHECK_GCRYPT_ALGO([DES])
      AC_CHECK_GCRYPT_ALGO([IDEA])
      AC_CHECK_GCRYPT_ALGO([RFC2268])
      AC_CHECK_GCRYPT_ALGO([SERPENT])
      AC_CHECK_GCRYPT_ALGO([TWOFISH])
      # digests
      AC_CHECK_GCRYPT_ALGO([CRC])
      AC_CHECK_GCRYPT_ALGO([HAVAL])
      AC_CHECK_GCRYPT_ALGO([MD2])
      AC_CHECK_GCRYPT_ALGO([MD4])
      AC_CHECK_GCRYPT_ALGO([MD5])
      AC_CHECK_GCRYPT_ALGO([RMD160])
      AC_CHECK_GCRYPT_ALGO([SHA0])
      AC_CHECK_GCRYPT_ALGO([SHA1])
      AC_CHECK_GCRYPT_ALGO([SHA224])
      AC_CHECK_GCRYPT_ALGO([SHA256])
      AC_CHECK_GCRYPT_ALGO([SHA384])
      AC_CHECK_GCRYPT_ALGO([SHA512])
      AC_CHECK_GCRYPT_ALGO([TIGER])
      AC_CHECK_GCRYPT_ALGO([WHIRLPOOL])
      # others
      AC_CHECK_GCRYPT_ALGO([DSA])
      AC_CHECK_GCRYPT_ALGO([ELGAMAL])
      AC_CHECK_GCRYPT_ALGO([RSA])
      # conclusion
      GCRYPT_CFLAGS=`$LIBGCRYPT_CONFIG --cflags`
      GCRYPT_LIBS=`$LIBGCRYPT_CONFIG --libs`
      AC_SUBST(GCRYPT_CFLAGS)
      AC_SUBST(GCRYPT_LIBS)
    ],[
      # complain only if explicitely required
      if test "$ac_with_gcrypt" = "yes" ; then
      	AC_MSG_ERROR([cannot configure required gcrypt library])
      fi
    ])
  fi
])
