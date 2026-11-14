# ===========================================================================
#    https://www.gnu.org/software/autoconf-archive/ax_define_sub_path.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   This macro has been broken for years without anyone noticing:
#   AX_DEFINE_SUB_PATHS lacks a closing done, and both macros define the
#   literal string $P instead of the computed path.
#
# SYNOPSIS
#
#   AX_DEFINE_SUB_PATH(DEFNAME, varname, description)
#
# DESCRIPTION
#
#   Look at varname and detect the subpath that it contains relative to
#   $prefix/$exec_prefix. If the path is indeed relative to
#   $prefix/$exec_prefix, then a single "./" (dotslash) is prepended,
#   otherwise it can be seen as an absolute path that cannot be moved, which
#   you possibly do for "/etc" files, or even those ending up in
#   "/lib/modules" or "/winnt/system".
#
#   This macro is not very intelligent, it's just a first try in this
#   direction. It does currently just look into the current patterns, and
#   replaces a ${prefix} with a simple dot. Amazingly, it works quite well
#   for most packages.
#
#   Example (configure.ac):
#
#     AX_DEFINE_DIR([EPREFIX], [exec_prefix], [--exec-prefix or default])
#     AX_DEFINE_SUB_PATH([PATH_LIBDIR], [libdir], [--bindir subdir])
#     AC_DEFINE_UNQUOTED([PACKAGE],"$PACKAGE", [Name of package])
#
#   Example (in C):
#
#     static const char _libdir[] = PATH_LIBDIR; /* configure default */
#     char* libdir;
#     char* eprefix = getenv (PACKAGE "DIR");
#     if (! eprefix) eprefix = EPREFIX; /* default */
#     if (*_libdir != '.') libdir = strdup(_libdir);
#     else {
#        libdir = malloc(strlen(eprefix) + strlen(_libdir) + 2);
#        strcpy(libdir, eprefix);
#        strcat(libdir, PATH_DELIMITER_STRING);
#        strcat(libdir, _libdir);
#     }
#     ...
#     free (libdir);
#
#   The AX_DEFINE_SUB_PATHS(varnames) macro looks for the given various
#   install-paths that largely depend on either ${prefix} or ${exec_prefix}.
#   Just cut out the prefix and ac_define the value. The value is uppercased
#   and PATH_ prepended ie. ax_define_sub_paths(bindir libdir pkgdatadir)
#   will create the defines PATH_BINDIR PATH_LIBDIR PATH_PKGDATADIR - see
#   posix' include/paths.h that creates _PATH_DEV and friends.
#
# BUGS
#
#   Private shell variables such as i, P, and V lack an ax_ prefix. They
#   share configure's shell namespace with callers and other macros, so they
#   may collide with variables of the same name. These variables should use
#   macro-specific ax_ names. [Rating: minor]
#
# LICENSE
#
#   Copyright (c) 2008 Guido U. Draheim <guidod@gmx.de>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 14

AU_ALIAS([AC_DEFINE_SUB_PATH], [AX_DEFINE_SUB_PATH])
AC_DEFUN([AX_DEFINE_SUB_PATH],
[dnl
  m4_warn([obsolete], [$0 is obsolete: it has been broken for years])
  test "_$prefix" = _NONE && prefix="$ac_default_prefix"
  test "_$exec_prefix" = _NONE && exec_prefix='${prefix}'
  P=`echo ifelse( $2, , [$]$1, [$]$2) | sed -e 's:^\${[a-z_]*prefix}:.:'`
  ifelse($3, ,
    AC_DEFINE($1, $P, [sub path $2]),
    AC_DEFINE($1, $P, $3))
])

AC_DEFUN([AX_DEFINE_SUB_PATHS],
[dnl
  m4_warn([obsolete], [$0 is obsolete: it has been broken for years])
  test "_$prefix" = _NONE && prefix="$ac_default_prefix"
  test "_$exec_prefix" = _NONE && exec_prefix='${prefix}'
  for i in $1 ; do
  P=`echo \$$i | sed -e 's:^\${[a-z_]*prefix}:.:'`
  V=`echo path_$i | sed -e 'y:abcdefghijklmnopqrstuvwxyz:ABCDEFGHIJKLMNOPQRSTUVWXYZ:'`
    AC_DEFINE($V, $P, [sub path $i]),
])
