##### http://autoconf-archive.cryp.to/ax_boost_signals.html
#
# SYNOPSIS
#
#   AX_BOOST_SIGNALS
#
# DESCRIPTION
#
#   Test for Signals library from the Boost C++ libraries. The macro
#   requires a preceding call to AX_BOOST_BASE. Further documentation
#   is available at <http://randspringer.de/boost/index.html>.
#
#   This macro calls:
#
#     AC_SUBST(BOOST_SIGNALS_LIB)
#
#   And sets:
#
#     HAVE_BOOST_SIGNALS
#
# LAST MODIFICATION
#
#   2007-03-12
#
# COPYLEFT
#
#   Copyright (c) 2007 Thomas Porschberg <thomas@randspringer.de>
#   Copyright (c) 2007 Michael Tindal <mtindal@paradoxpoint.com>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AX_BOOST_SIGNALS],
[
	AC_ARG_WITH([boost-signals],
	AS_HELP_STRING([--with-boost-signals@<:@=special-lib@:>@],
                   [use the Signals library from boost - it is possible to specify a certain library for the linker
                        e.g. --with-boost-signals=boost_signals-gcc-mt-d ]),
        [
        if test "$withval" = "no"; then
			want_boost="no"
        elif test "$withval" = "yes"; then
            want_boost="yes"
            ax_boost_user_signals_lib=""
        else
		    want_boost="yes"
        	ax_boost_user_signals_lib="$withval"
		fi
        ],
        [want_boost="yes"]
	)

	if test "x$want_boost" = "xyes"; then
        AC_REQUIRE([AC_PROG_CC])
		CPPFLAGS_SAVED="$CPPFLAGS"
		CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
		export CPPFLAGS

		LDFLAGS_SAVED="$LDFLAGS"
		LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
		export LDFLAGS

        AC_CACHE_CHECK(whether the Boost::Signals library is available,
					   ax_cv_boost_signals,
        [AC_LANG_PUSH([C++])
		 AC_COMPILE_IFELSE(AC_LANG_PROGRAM([[@%:@include <boost/signal.hpp>
											]],
                                  [[boost::signal<void ()> sig;
                                    return 0;
                                  ]]),
                           ax_cv_boost_signals=yes, ax_cv_boost_signals=no)
         AC_LANG_POP([C++])
		])
		if test "x$ax_cv_boost_signals" = "xyes"; then
			AC_DEFINE(HAVE_BOOST_SIGNALS,,[define if the Boost::Signals library is available])
			BN=boost_signals
            if test "x$ax_boost_user_signals_lib" = "x"; then
				for ax_lib in $BN $BN-$CC $BN-$CC-mt $BN-$CC-mt-s $BN-$CC-s \
                              lib$BN lib$BN-$CC lib$BN-$CC-mt lib$BN-$CC-mt-s lib$BN-$CC-s \
                              $BN-mgw $BN-mgw $BN-mgw-mt $BN-mgw-mt-s $BN-mgw-s ; do
				    AC_CHECK_LIB($ax_lib, main, [BOOST_SIGNALS_LIB="-l$ax_lib"; AC_SUBST(BOOST_SIGNALS_LIB) link_signals="yes"; break],
                                 [link_signals="no"])
  				done
            else
               for ax_lib in $ax_boost_user_signals_lib $BN-$ax_boost_user_signals_lib; do
				      AC_CHECK_LIB($ax_lib, main,
                                   [BOOST_SIGNALS_LIB="-l$ax_lib"; AC_SUBST(BOOST_SIGNALS_LIB) link_signals="yes"; break],
                                   [link_signals="no"])
                  done

            fi
			if test "x$link_signals" = "xno"; then
				AC_MSG_ERROR(Could not link against $ax_lib !)
			fi
		fi

		CPPFLAGS="$CPPFLAGS_SAVED"
    	LDFLAGS="$LDFLAGS_SAVED"
	fi
])
