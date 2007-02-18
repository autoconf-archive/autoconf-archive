##### http://autoconf-archive.cryp.to/peti_silent_mode.html
#
# OBSOLETE MACRO
#
#   Renamed to AX_SILENT_MODE.
#
# SYNOPSIS
#
#   PETI_SILENT_MODE(on|off)
#
# DESCRIPTION
#
#   Temporarily disable console output. For example:
#
#     PETI_SILENT_MODE(on)    dnl be silent
#     AC_PROG_CXX
#     PETI_SILENT_MODE(off)   dnl talk to me again
#     AC_PROG_RANLIB
#
#   Many thanks to Paolo Bonzini for proposing this macro.
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

AC_DEFUN([PETI_SILENT_MODE],
  [
  case "$1" in
    on)
      exec 6>/dev/null
      ;;
    off)
      exec 6>&1
      ;;
    *)
      AC_MSG_ERROR(Silent mode can only be switched "on" or "off".)
      ;;
  esac
  ])dnl
