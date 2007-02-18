##### http://autoconf-archive.cryp.to/ac_auto_include_headers.html
#
# OBSOLETE MACRO
#
#   Superseded by AX_AUTO_INCLUDE_HEADERS.
#
# SYNOPSIS
#
#   AC_AUTO_INCLUDE_HEADERS (HEADER-FILE, INCLUDE-FILE ...)
#
# DESCRIPTION
#
#   Given a HEADER-FILE and a space-separated list of INCLUDE-FILEs,
#   AC_AUTO_INCLUDE_HEADERS will append to HEADER-FILE a conditional
#   #include for each INCLUDE-FILE. For instance, the following macro
#   call:
#
#      AC_AUTO_INCLUDE_HEADERS([config-inc.h], [sys/foobar.h])
#
#   will append the following text to config-inc.h:
#
#      #ifdef HAVE_SYS_FOOBAR_H
#      # include <sys/foobar.h>
#      #endif
#
#   AC_AUTO_INCLUDE_HEADERS makes it easy to auto-generate a single
#   header file that can then be #include'd by multiple files in a
#   project. Because the #ifdef's are appended to HEADER-FILE, it's
#   also convenient to include additional text in that file. For
#   instance:
#
#      cat <<\CIH_EOF > config-inc.h
#      /* This file was generated automatically by configure. */
#
#      #ifndef _CONFIG_INC_H_
#      #define _CONFIG_INC_H_
#
#      #include <stdio.h>
#
#      CIH_EOF
#      AC_AUTO_INCLUDE_HEADERS([config-inc.h], [arpa/inet.h dlfcn.h errno.h])
#      echo "#endif" >> config-inc.h
#
#   Here's an easy way to get a complete list of header files from
#   config.h:
#
#      cat config.h | perl -ane '/ HAVE_\S+_H / && do {$_=$F[$#F-1]; s/^HAVE_//; s/_H/.h/; s|_|/|g; tr/A-Z/a-z/; print "$_ "}'
#
#   You can then manually edit the resulting list.
#
# LAST MODIFICATION
#
#   2002-03-04
#
# COPYLEFT
#
#   Copyright (c) 2002 Scott Pakin <pakin@uiuc.edu>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AC_AUTO_INCLUDE_HEADERS],
[touch $1
for ac_auto_include_file in $2; do
  ac_auto_include_have=`echo $ac_auto_include_file | sed 'y%./*abcdefghijklmnopqrstuvwxyz%__PABCDEFGHIJKLMNOPQRSTUVWXYZ%;s%[^_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789]%_%g'`
  echo "#ifdef HAVE_$ac_auto_include_have" >> $1
  echo "# include <$ac_auto_include_file>" >> $1
  echo "#endif" >> $1
  echo "" >> $1
done])
