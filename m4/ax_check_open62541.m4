# ===========================================================================
#    http://www.gnu.org/software/autoconf-archive/ax_check_open62541.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_OPEN62541_H([HEADERS = `...see_below...'], [ACTION-IF-FOUND],
#                        [ACTION-IF-NOT-FOUND])
#   AX_CHECK_OPEN62541_LIB([STATIC-FIRST = `no'], [ACTION-IF-FOUND],
#                          [ACTION-IF-NOT-FOUND])
#
# DESCRIPTION
#
#   Searches for the header and library files for the open62541 library [1].
#
#   The open62541 library is a cmake-based project, that supplies both a
#   shared and a static library (with different names) and provides its
#   header files in one of two layouts:
#
#     1) As individual files, e.g. ua_config.h, ua_server.h, ua_types.h, ...
#     2) As a single amalgamation file open62541.h
#
#   The second case is enabled when configuring open62541 with the options
#   "-D UA_ENABLE_AMALGAMATION=true to" cmake, which seems to be preferred.
#   Code using the library can distinguish which layout is used by checking
#   for the macro "UA_NO_AMALGAMATION": if it is defined, the first layout
#   is used.
#
#   The AX_CHECK_OPEN62541_H macro checks first for the amalgamation and, if
#   that is not found, for the individual headers. It defines
#   "UA_NO_AMALGAMATION" if necessary.
#
#   The individual headers to check for if no amalgamation is found can be
#   provided as a space-separated list in the first argument. If that is
#   empty, it defaults to all files known to be contained in the
#   amalgamation:
#
#     * logger_stdout.h
#     * networklayer_tcp.h
#     * ua_client.h
#     * ua_client_highlevel.h
#     * ua_config.h
#     * ua_config_standard.h
#     * ua_connection.h
#     * ua_constants.h
#     * ua_job.h
#     * ua_log.h
#     * ua_nodeids.h
#     * ua_server.h
#     * ua_server_external_ns.h
#     * ua_types.h
#     * ua_types_generated.h
#
#   The AX_CHECK_OPEN62541_LIB macro searches for the library and adds it to
#   the LIBS Makefile variable. It can search for the shared or static
#   library in either order (first found is used). The user can select which
#   one to search first with the --with-open62541-shared or
#   --with-open62541-static options. An option can be disabled completely
#   with --without-open62541-shared or --without-open62541-static. The
#   default if the user specifies nothing can be set with the first macro
#   argument STATIC-FIRST, which defaults to "no" (shared library if
#   available).
#
#   The open62541 library is often not installed on the system but provided
#   via its source and build directories. In that case, the location of
#   several directories need to be added to the pre-processor and linker
#   search paths:
#
#     * -Isrc/include
#     * -Isrc/plugins
#     * -Ibuild/src_generated
#     * -Ibuild
#     * -Lbuild
#
#   Both macros monitor the configure option --with-open62541: if it is set
#   to "no", the ACTION-IF-NOT-FOUND is executed. If it is set to a value
#   other than "yes", this is assumed to be the path to the source directory
#   ("src" above). In that case, the above directories are added to the
#   search paths. The option --with-open62541-build may also be specified,
#   which gives "build" above and defaults to "${src}/build". The
#   AX_CHECK_OPEN62541_H macro handles the preprocessor search path and the
#   AX_CHECK_OPEN62541_LIB macro handles the linker search path.
#
#   [1]: <http://open62541.org/>
#
# LICENSE
#
#   Copyright (c) 2016 Olaf Mandel <olaf@mandel.name>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 1

# _AX_CHECK_OPEN62541_get_paths()
# -------------------------------
# Declares --with-open62541 and --with-open62541-build and stores the
# results. Writes a fatal error message if the latter is given without
# the former. If paths are given, they are stripped of trailing slashes.
# Can be called multiple times without bad effect.
# Global variables defined:
# - _AX_CHECK_OPEN62541_have_paths
# Shell variables defined:
# - with_open62541
# - with_open62541_build
m4_define([_AX_CHECK_OPEN62541_get_paths],
[m4_ifndef([_AX_CHECK_OPEN62541_have_paths],
[AC_ARG_WITH([open62541],
             [AS_HELP_STRING([--with-open62541=dir],
    [set the open62541 library source location])],
             [], [with_open62541=no])dnl
AC_ARG_WITH([open62541-build],
             [AS_HELP_STRING([--with-open62541-build=dir],
    [set location of the open62541 build dir (@<:@default=$src/build@:>@)])],
             [], [with_open62541_build=no])dnl
[with_open62541=${with_open62541%/}]
AS_IF([test "x$with_open62541_build" == xyes],
      [AC_MSG_FAILURE([--with-open62541-build needs an argument])],
      [test "x$with_open62541" == xno -a "x$with_open62541_build" != xno],
      [AC_MSG_FAILURE([--with-open62541-build without --with-open62541])],
      [test "x$with_open62541" != xno -a "x$with_open62541_build" == xno],
      [[with_open62541_build=$with_open62541/build]])
[with_open62541_build=${with_open62541_build%/}]
define([_AX_CHECK_OPEN62541_have_paths], 1)dnl
])dnl
])# _AX_CHECK_OPEN62541_get_paths

# AX_CHECK_OPEN62541_H([HEADERS], [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
# -------------------------------------------------------------------------
AC_DEFUN([AX_CHECK_OPEN62541_H],
[m4_pushdef([headers], m4_normalize([$1]))dnl
m4_ifblank(m4_defn([headers]), [m4_define([headers],
 [logger_stdout.h]dnl
 [networklayer_tcp.h]dnl
 [ua_client.h]dnl
 [ua_client_highlevel.h]dnl
 [ua_config.h]dnl
 [ua_config_standard.h]dnl
 [ua_connection.h]dnl
 [ua_constants.h]dnl
 [ua_job.h]dnl
 [ua_log.h]dnl
 [ua_nodeids.h]dnl
 [ua_server.h]dnl
 [ua_server_external_ns.h]dnl
 [ua_types.h]dnl
 [ua_types_generated.h])])dnl
dnl ua_server_external_ns.h depends on ua_server.h but fails to include it:
dnl so specify the includes:
pushdef([includes],
[#ifdef HAVE_UA_SERVER_H
#    include <ua_server.h>
#endif])dnl
dnl
_AX_CHECK_OPEN62541_get_paths()dnl
AS_IF([test "x$with_open62541" != xno -a "x$with_open62541" != xyes],
      [CPPFLAGS="$CPPFLAGS${CPPFLAGS:+ }-I$with_open62541/include]dnl
[ -I$with_open62541/plugins -I$with_open62541_build/src_generated]dnl
[ -I$with_open62541_build"])
AS_IF([test "x$with_open62541" != xno],
      [AC_CHECK_HEADERS([open62541.h], [$2],
          [AC_CHECK_HEADERS(m4_defn([headers]), [$2]dnl
[AC_DEFINE([UA_NO_AMALGAMATION], [1],
           [Use individual open62541 headers instead of the amalgamation.])],
                            [$3],
                            [m4_defn([includes])])],
                        [AC_INCLUDES_DEFAULT])],
      [$3])
m4_popdef([headers], [includes])dnl
])# AX_CHECK_OPEN62541_H


# _AX_CHECK_OPEN62541_check_lib([SHARED-STATIC], [ACTION-IF-FOUND],
#                               [ACTION-IF-NOT-FOUND])
-------------------------------------------------------------------
# Checks for the desired library if not forbidden by
# with_open62541_(shared|static) shell variables.
m4_define([_AX_CHECK_OPEN62541_check_lib],
[m4_pushdef([lib], m4_if([$1], [shared], [open62541],
                         [$1], [static], [open62541-static]))dnl
AS_IF([test "x$with_open62541_$1" != xno],
      [AC_CHECK_LIB(m4_defn([lib]), [UA_Server_new], [$2], [$3])],
      [$3])
m4_popdef([lib])dnl
])# _AX_CHECK_OPEN62541_check_lib


# AX_CHECK_OPEN62541_LIB([STATIC-FIRST], [ACTION-IF-FOUND],
#                        [ACTION-IF-NOT-FOUND])
# -----------------------------------------------------------
AC_DEFUN([AX_CHECK_OPEN62541_LIB],
[m4_pushdef([staticfirst], m4_normalize([$1]))dnl
m4_bmatch(m4_defn([staticfirst]),
          [^\([Nn][Oo]?\|0\)$], [m4_define([staticfirst], [])])dnl
m4_ifnblank(m4_defn([staticfirst]), [m4_define([staticfirst], 1)])dnl
dnl
_AX_CHECK_OPEN62541_get_paths()dnl
AS_IF([test "x$with_open62541_build" != xno],
      [LDFLAGS="$LDFLAGS${LDFLAGS:+ }-L$with_open62541_build"])
AC_ARG_WITH([open62541-shared],
            [AS_HELP_STRING([--without-open62541-shared],
                            [skip search for the shared open62541 library])],
            [], [with_open62541_shared=yes])dnl
AC_ARG_WITH([open62541-static],
            [AS_HELP_STRING([--without-open62541-static],
                            [skip search for the static open62541 library])],
            [], [with_open62541_static=yes])dnl
AS_IF([test "x$with_open62541" != xno],
      [m4_ifblank(m4_defn([staticfirst]),
          [_AX_CHECK_OPEN62541_check_lib([shared], [$2],
              [_AX_CHECK_OPEN62541_check_lib([static], [$2], [$3])])],
          [_AX_CHECK_OPEN62541_check_lib([static], [$2],
              [_AX_CHECK_OPEN62541_check_lib([shared], [$2], [$3])])])],
      [$3])dnl
m4_popdef([staticfirst])dnl
])# AX_CHECK_OPEN62541_LIB
