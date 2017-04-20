# ===========================================================================
#      http://www.gnu.org/software/autoconf-archive/ax_sanitizers.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_SANITIZERS([SANITIZERS], [ENABLED-BY-DEFAULT], [ACTION-SUCCESS])
#
# DESCRIPTION
#
#   Offers users to enable one or more sanitizers (see
#   https://github.com/google/sanitizers) with the corresponding
#   --enable-<sanitizer>-sanitizer option.
#
#   SANITIZERS is a whitespace-separated list of sanitizers to offer via
#   --enable-<sanitizer>-sanitizer options, e.g. "address memory" for the
#   address sanitizer and the memory sanitizer. If SANITIZERS is not specified,
#   all known sanitizers to AX_SANITIZERS will be offered, which at the time of
#   writing are TODO.
#
#   TODO: make this a list of enabled-by-default sanitizers because not all combinations are valid. e.g. address+memory does not work, but memory+undefined does.
#   ENABLED-BY-DEFAULT specifies whether offered SANITIZERS should be enabled
#   by default ("yes") or not (anything else). If ENABLED-BY-DEFAULT is
#   unspecified, sanitizers will not be enabled by default, because of the
#   slowdowns they cause.
#
#   ACTION-SUCCESS allows to specify shell commands to execute on success, i.e.
#   when one of the sanitizers was successfully enabled. This is a good place
#   to call AC_DEFINE for any precompiler constants you might need to make your
#   code play nice with sanitizers.
#
# EXAMPLES
#
#   AX_SANITIZERS([address])
#     dnl offer users to enable address sanitizer via --enable-address-sanitizer
#
#   is_debug_build=…
#   AX_SANITIZERS([address memory], [$is_debug_build])
#     dnl enable address sanitizer and memory sanitizer by default for debug
#     dnl builds, e.g. when building from git instead of a dist tarball.
#
#   AX_SANITIZERS(, [yes], [
#     AC_DEFINE([SANITIZERS_ENABLED],
#               [],
#               [At least one sanitizer was enabled])])
#     dnl enable all sanitizers known to AX_SANITIZERS by default and set the
#     dnl SANITIZERS_ENABLED precompiler constant.
#
# LICENSE
#
#   Copyright (c) 2016 Michael Stapelberg <michael@i3wm.org>
#
#   Copying and distribution of this file, with or without modification,
#   are permitted in any medium without royalty provided the copyright
#   notice and this notice are preserved.  This file is offered as-is,
#   without any warranty.

AC_DEFUN([AX_SANITIZERS],
[AX_REQUIRE_DEFINED([AX_CHECK_COMPILE_FLAG])
AX_REQUIRE_DEFINED([AX_CHECK_LINK_FLAG])
AX_REQUIRE_DEFINED([AX_APPEND_FLAG])
m4_foreach_w([mysan], m4_default([$1], [address memory undefined]), [
  AC_ARG_ENABLE(mysan[]-sanitizer,
    AS_HELP_STRING(
      [--enable-[]mysan[]-sanitizer],
      [enable -fsanitize=mysan]))

ax_sanitizer_enabled=no
AS_IF([test "x[]$2" = "xyes"],
      [dnl
  AS_IF([test "x$enable_[]mysan[]_sanitizer" != "xno"], [dnl
    ax_sanitizer_enabled=yes])],
      [dnl
  AS_IF([test "x$enable_[]mysan[]_sanitizer" = "xyes"], [dnl
    ax_sanitizer_enabled=yes])])
AS_IF([test "x$ax_sanitizer_enabled" = "xyes"], [
dnl Not using AX_APPEND_COMPILE_FLAGS and AX_APPEND_LINK_FLAGS because they
dnl lack the ability to specify ACTION-SUCCESS.
  AX_CHECK_COMPILE_FLAG([-fsanitize=[]mysan], [
    AX_CHECK_LINK_FLAG([-fsanitize=[]mysan], [
      AX_APPEND_FLAG([-fsanitize=[]mysan], [])
dnl If and only if libtool is being used, LDFLAGS needs to contain -Wc,-fsanitize=….
dnl See e.g. https://sources.debian.net/src/systemd/231-7/configure.ac/?hl=128#L135
dnl TODO: how can recognize that situation and add -Wc,?
      AX_APPEND_FLAG([-fsanitize=[]mysan], [LDFLAGS])
dnl TODO: add -fPIE -pie for memory
      # -fno-omit-frame-pointer results in nicer stack traces in error
      # messages, see http://clang.llvm.org/docs/AddressSanitizer.html#usage
      AX_CHECK_COMPILE_FLAG([-fno-omit-frame-pointer], [
        AX_APPEND_FLAG([-fno-omit-frame-pointer], [])])
dnl TODO: at least for clang, we should specify exactly -O1, not -O2 or -O0, so that performance is reasonable but stacktraces are not tampered with (due to inlining), see http://clang.llvm.org/docs/AddressSanitizer.html#usage
      m4_default([$3], :)
    ])
  ])
])
])dnl
])dnl AX_SANITIZERS
