# ===========================================================================
#            http://autoconf-archive.cryp.to/etr_short_sleep.html
# ===========================================================================
#
# SYNOPSIS
#
#   ETR_SHORT_SLEEP
#
# DESCRIPTION
#
#   This macro searches for a "sleep" function that has 1/1000 of a second
#   accuracy. On some systems, this is known as nap() and on others usleep()
#   / 1000. There are probably other functions like this defined in other
#   system libraries, but we don't know how to search for them yet.
#   Contributions joyously accepted. :)
#
# LICENSE
#
#   Copyright (c) 2008 Warren Young <warren@etr-usa.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([ETR_SHORT_SLEEP],
[
        AC_MSG_CHECKING([for nap() in libc])
        AC_TRY_LINK([ extern "C" long nap(long ms); ], [ nap(42); ],
                [
                        etr_ss_found=yes
                        etr_ss_factor=1
                        AC_DEFINE(HAVE_NAP,1,
                                [Define to use the nap() system call for short sleeps])
                        AC_MSG_RESULT(yes)
                ],
                [
                        AC_MSG_RESULT(no)
                        etr_ss_found=no
                ])

        if test x"$etr_ss_found" = "xno"
        then
                AC_MSG_CHECKING([for usleep()])
                AC_TRY_LINK([ #include <unistd.h> ], [ usleep(42); ],
                        [
                                etr_ss_found=yes
                                etr_ss_factor=1000
                                AC_DEFINE(HAVE_USLEEP,1,
                                        [Define to use the usleep() system call for short sleeps])
                                AC_MSG_RESULT(yes)
                        ],
                        [
                                AC_MSG_RESULT(no)
                                etr_ss_found=no
                        ])
        fi

        if test x"$etr_ss_found" = "xno"
        then
                save_LIBS=$LIBS
                LIBS="$LIBS -lx"
                AC_MSG_CHECKING([for nap() in libx])
                AC_TRY_LINK([ extern "C" long nap(long ms); ], [ nap(42); ],
                        [
                                etr_ss_found=yes
                                etr_ss_factor=1
                                AC_DEFINE(HAVE_NAP,1,
                                        [Define to use the nap() system call for short sleeps])
                                AC_MSG_RESULT(yes)
                        ],
                        [
                                AC_MSG_RESULT(no)
                                etr_ss_found=no
                        ])

                LIBS=$save_LIBS
                ETR_SS_LIB=-lx
                AC_SUBST(ETR_SS_LIB)
        fi

        if test x"$etr_ss_found" = "xyes"
        then
                AC_DEFINE_UNQUOTED(SHORT_SLEEP_FACTOR, $etr_ss_factor,
                        [Multiply milliseconds by this to get the argument for the short sleep system call])
        else
                AC_MSG_ERROR([Could not find a "short sleep" system call.])
        fi
])dnl ETR_SHORT_SLEEP
