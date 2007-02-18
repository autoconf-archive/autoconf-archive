##### http://autoconf-archive.cryp.to/ax_count_cpus.html
#
# SYNOPSIS
#
#   AX_COUNT_CPUS
#
# DESCRIPTION
#
#   Attempt to count the number of processors present on the machine.
#   If the detection fails, then a value of 1 is assumed.
#
#   The value is placed in the CPU_COUNT variable.
#
# LAST MODIFICATION
#
#   2006-10-13
#
# COPYLEFT
#
#   Copyright (c) 2006 Michael Paul Bailey <jinxidoru@byu.net>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AX_COUNT_CPUS], [
    AC_REQUIRE([AC_PROG_EGREP])
    AC_MSG_CHECKING( cpu count )
    CPU_COUNT="0"
    if test -e /proc/cpuinfo; then
        CPU_COUNT=`$EGREP -c '^processor' /proc/cpuinfo`
    fi
    if test "x$CPU_COUNT" = "x0"; then
        CPU_COUNT="1"
        AC_MSG_RESULT( [unable to detect (assuming 1)] )
    else
        AC_MSG_RESULT( $CPU_COUNT )
    fi
])
