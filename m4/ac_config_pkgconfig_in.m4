# ===========================================================================
#         http://autoconf-archive.cryp.to/ac_config_pkgconfig_in.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Deprecated with the advent of pkg-config.
#
# SYNOPSIS
#
#   AC_CONFIG_PKGCONFIG_IN [(LIBRARY [, DESCRIPTION [, DESTINATION]])]
#
# DESCRIPTION
#
#   Creates a pkg-config meta-data file for a library with the following
#   fields: Name, Description, Requires, Conflicts, Version, Libs, and
#   Cflags.
#
#   This macro automates the construction of a pkg-config .pc meta-data
#   file; you don't even need to distribute one along. Place this macro in
#   your configure.ac, et voila, you got one that you want to install.
#
#   The options:
#
#    $1 = LIBRARY       e.g. gtk, ncurses
#    $2 = DESCRIPTION   one line description of library
#    $3 = DESTINATION   directory path
#
#   It is suggested that the following CFLAGS and LIBS variables are used in
#   your configure.ac. library_libs is *essential*. library_cflags is
#   important, but not always needed. If they do not exist, defaults will be
#   taken from LIBRARY_CFLAGS, LIBRARY_LIBS (should be -llibrary *only*) and
#   LIBRARY_LIBDEPS (-l options for libraries your library depends upon.
#   LIBLIBRARY_LIBS is simply $LIBRARY_LIBS $LIBRARY_LIBDEPS. NB. LIBRARY
#   and library are the name of your library, in upper and lower case
#   repectively e.g. GTK, gtk.
#
#    LIBRARY_CFLAGS:    cflags for compiling libraries and example progs
#    LIBRARY_LIBS:      libraries for linking programs
#    LIBRARY_LIBDEPS*:  libraries for linking libraries against (needed
#                       to link -static
#    LIBRARY_REQUIRES:  packages required by your library
#    LIBRARY_CONFLICTS: packages to conflict with your library
#    library_cflags*:   cflags to store in library.pc
#    library_libs*:     libs to store in library.pc
#    LIBLIBRARY_LIBS:   libs to link programs IN THIS PACKAGE ONLY against
#    LIBRARY_VERSION*:  the version of your library (x.y.z recommended)
#      *=required if you want sensible output, otherwise they will be
#        *guessed* (DWIM, but usually correct)
#
#   There is also an AC_SUBST(LIBRARY_PKGCONFIG) that will be set to the
#   name of the meta-data file. Use as:
#
#    install-data-local: install-pkgconfig
#    install-pkgconfig:
#       $(mkinstalldirs) $(DESTDIR)$(prefix)/lib/pkgconfig
#       $(INSTALL_DATA) @LIBRARY_PKGCONFIG@ $(DESTDIR)$(prefix)/lib/pkgconfig
#
#   Or, if using automake:
#
#    pkgconfigdatadir = $(prefix)/lib/pkgconfig
#    pkgconfigdata_DATA = @LIBRARY_PKGCONFIG@
#
#   Example usage:
#
#    GIMPPPRINT_LIBS="-lgimpprint"
#    AC_CHECK_LIB(m,pow,
#                 GIMPPRINT_DEPLIBS="${GIMPPRINT_DEPLIBS} -lm")
#    AC_CONFIG_PKGCONFIG_IN([gimpprint], [GIMP Print Top Quality Printer Drivers], [src/main])
#    AC_CONFIG_FILES(gimpprint.pc)
#
#    If using automake with the "--add-missing" option, the call to
#    AC_CONFIG_FILES will cause it to abort because it is looking for the
#    .pc.in file which has not yet been created (because configure itself
#    hasn't been run). To get around this, don't use AC_CONFIG_FILES to
#    generate it.  Instead, use this in Makefile.am:
#
#    @LIBRARY_PKGCONFIG@ : @LIBRARY_PKGCONFIG@.in
#    		./config-status --file=@LIBRARY_PKGCONFIG@
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Roger Leigh <roger@whinlatter.uklinux.net>
#   Copyright (c) 2008 Diab Jerius <djerius@cfa.harvard.edu>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

## AC_CONFIG_PKGCONFIG_IN(LIBRARY, DESCRIPTION, DESTINATION)
## ---------------------------------------------------------
## Create a pkg-config meta-data file for LIBRARY.  Include a one-line
## DESCRIPTION.  The meta-data file will be created in a DESTINATION
## directory.
AC_DEFUN([AC_CONFIG_PKGCONFIG_IN],
[# create a pkg-config meta-data file ($1.pc.in)
m4_pushdef([PKGCONFIG_DIR], [m4_if([$3], , , [$3/])])
PKGCONFIG_FILE_PC="PKGCONFIG_DIR[]$1.pc"
PKGCONFIG_FILE="$PKGCONFIG_FILE_PC[].in"
AC_SUBST(target)dnl
AC_SUBST(host)dnl
AC_SUBST(build)dnl
dnl create directory if it does not preexist
m4_if([$3], , , [AS_MKDIR_P([$3])])
AC_MSG_NOTICE([creating $PKGCONFIG_FILE])
dnl we're going to need uppercase, lowercase and user-friendly versions of the
dnl string `MODULE'
m4_pushdef([MODULE_UP], m4_translit([$1], [a-z], [A-Z]))dnl
m4_pushdef([MODULE_DOWN], m4_translit([$1], [A-Z], [a-z]))dnl
if test -z "$MODULE_DOWN[]_cflags" ; then
  if test -n "$MODULE_UP[]_CFLAGS" ; then
      MODULE_DOWN[]_cflags="$MODULE_UP[]_CFLAGS"
  else
dnl    AC_MSG_WARN([variable `MODULE_DOWN[]_cflags' undefined])
    MODULE_DOWN[]_cflags=''
  fi
fi
AC_SUBST(MODULE_DOWN[]_cflags)dnl
if test -z "$MODULE_DOWN[]_libs" ; then
  if test -n "$MODULE_UP[]_LIBS" ; then
    MODULE_DOWN[]_libs="$MODULE_UP[]_LIBS"
  else
    AC_MSG_WARN([variable `MODULE_DOWN[]_libs' and `MODULE_UP[]_LIBS' undefined])
    MODULE_DOWN[]_libs='-l$1'
  fi
  if test -n "$MODULE_UP[]_LIBDEPS" ; then
    MODULE_DOWN[]_libs="$MODULE_DOWN[]_libs $MODULE_UP[]_LIBDEPS"
  fi
fi
AC_SUBST(MODULE_DOWN[]_libs)dnl
AC_SUBST(MODULE_UP[]_REQUIRES)
AC_SUBST(MODULE_UP[]_CONFLICTS)
if test -z "$MODULE_UP[]_VERSION" ; then
  AC_MSG_WARN([variable `MODULE_UP[]_VERSION' undefined])
  MODULE_UP[]_VERSION="$VERSION"
fi
AC_SUBST(MODULE_UP[]_VERSION)dnl
echo 'prefix=@prefix@' >$PKGCONFIG_FILE
echo 'exec_prefix=@exec_prefix@' >>$PKGCONFIG_FILE
echo 'libdir=@libdir@' >>$PKGCONFIG_FILE
echo 'includedir=@includedir@' >>$PKGCONFIG_FILE
echo '' >>$PKGCONFIG_FILE
echo 'Name: @PACKAGE_NAME@' >>$PKGCONFIG_FILE
echo 'Description: $2' >>$PKGCONFIG_FILE
if test -n "$MODULE_UP[]_REQUIRES" ; then
  echo 'Requires: @MODULE_UP[]_REQUIRES@' >>$PKGCONFIG_FILE
fi
if test -n "$MODULE_UP[]_CONFLICTS" ; then
  echo 'Conflicts: @MODULE_UP[]_CONFLICTS@' >>$PKGCONFIG_FILE
fi
echo 'Version: @MODULE_UP[]_VERSION@' >>$PKGCONFIG_FILE
echo 'Libs: -L${libdir} @MODULE_DOWN[]_libs@' >>$PKGCONFIG_FILE
echo 'Cflags: -I${includedir} @MODULE_DOWN[]_cflags@' >>$PKGCONFIG_FILE
m4_pushdef([PKGCONFIG_UP], [m4_translit([$1], [a-z], [A-Z])])dnl
PKGCONFIG_UP[]_PKGCONFIG="$PKGCONFIG_FILE_PC"
AC_SUBST(PKGCONFIG_UP[]_PKGCONFIG)
m4_popdef([PKGCONFIG_UP])
m4_popdef([MODULE_DOWN])dnl
m4_popdef([MODULE_UP])dnl
m4_popdef([PKGCONFIG_DIR])dnl
])
