##### http://autoconf-archive.cryp.to/peti_enable_dynamic_link.html
#
# OBSOLETE MACRO
#
#   Deprecated with the advent of GNU Libtool.
#
# SYNOPSIS
#
#   PETI_ENABLE_DYNAMIC_LINK
#
# DESCRIPTION
#
#   Add a command-line flag to enable/disable dynamic linking.
#
#   Calling this macro adds the flag "--enable-dynamic-link" to
#   command-line. When disabled, the compiler/linker flag "-static" is
#   added to "$LDFLAGS". The default is dynamic linkage.
#
# LAST MODIFICATION
#
#   2006-06-04
#
# COPYLEFT
#
#   Copyright (c) 2006 Peter Simons <simons@cryp.to>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([PETI_ENABLE_DYNAMIC_LINK], [
AC_MSG_CHECKING(what kind of binaries we shall create)
AC_ARG_ENABLE(dynamic-link,
[  --enable-dynamic-link   Create dynamically-linked binaries (default)],
if test "$enableval" = "yes"; then
    AC_MSG_RESULT(dynamically linked)
else
    LDFLAGS="$LDFLAGS -static"
    AC_MSG_RESULT(statically linked)
fi,
AC_MSG_RESULT(dynamically linked))
])dnl
