# ===========================================================================
#      https://www.gnu.org/software/autoconf-archive/ax_boost_asio.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_BOOST_ASIO
#
# DESCRIPTION
#
#   Test for Asio library from the Boost C++ libraries. The macro requires a
#   preceding call to AX_BOOST_BASE. Further documentation is available at
#   <http://randspringer.de/boost/index.html>.
#
#   This macro calls:
#
#     AC_SUBST(BOOST_ASIO_LIB)
#
#   And sets:
#
#     HAVE_BOOST_ASIO
#
# BUGS
#
#   (1) The automatic library search sets link_thread rather than link_asio.
#   If candidates exist but none links, the subsequent link_asio=no check
#   does not detect the failure and configure can continue without a usable
#   BOOST_ASIO_LIB. [Rating: minor]
#
#   (2) Private shell variables such as CPPFLAGS_SAVED, LDFLAGS_SAVED, and
#   BN lack an ax_ prefix. They share configure's shell namespace with
#   callers and other macros, so they may collide with variables of the same
#   name. These variables should use macro-specific ax_ names. [Rating:
#   minor]
#
# LICENSE
#
#   Copyright (c) 2008 Thomas Porschberg <thomas@randspringer.de>
#   Copyright (c) 2008 Pete Greenwell <pete@mu.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 21

dnl The test program, used for both the compile and the link check.
m4_define([_AX_BOOST_ASIO_PROGRAM], [AC_LANG_PROGRAM([[ @%:@include <boost/asio.hpp>
@%:@include <boost/version.hpp>
											]],
                                  [[

@%:@if BOOST_VERSION >= 106600
                                    boost::asio::io_context io;
                                    boost::asio::steady_timer t(io);
@%:@else
                                    boost::asio::io_service io;
                                    boost::asio::deadline_timer t(io);
@%:@endif
                                    boost::system::error_code timer_result;
                                    t.cancel();
                                    io.run_one();
									return 0;
                                   ]])])

AC_DEFUN([AX_BOOST_ASIO],
[
	AC_ARG_WITH([boost-asio],
	AS_HELP_STRING([--with-boost-asio@<:@=special-lib@:>@],
                   [use the ASIO library from boost - it is possible to specify a certain library for the linker
                        e.g. --with-boost-asio=boost_system-gcc41-mt-1_34 ]),
        [
        if test "$withval" = "no"; then
			want_boost="no"
        elif test "$withval" = "yes"; then
            want_boost="yes"
            ax_boost_user_asio_lib=""
        else
		    want_boost="yes"
		ax_boost_user_asio_lib="$withval"
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

        AC_CACHE_CHECK(whether the Boost::ASIO library is available,
					   ax_cv_boost_asio,
        [AC_LANG_PUSH([C++])
		 AC_COMPILE_IFELSE([_AX_BOOST_ASIO_PROGRAM],
                             ax_cv_boost_asio=yes, ax_cv_boost_asio=no)
         AC_LANG_POP([C++])
		])
		if test "x$ax_cv_boost_asio" = "xyes"; then
			AC_DEFINE(HAVE_BOOST_ASIO,,[define if the Boost::ASIO library is available])
			BN=boost_system
			BOOSTLIBDIR=`echo $BOOST_LDFLAGS | sed -e 's/@<:@^\/@:>@*//'`
            if test "x$ax_boost_user_asio_lib" = "x"; then
				for ax_lib in `ls $BOOSTLIBDIR/libboost_system*.so* $BOOSTLIBDIR/libboost_system*.dylib* $BOOSTLIBDIR/libboost_system*.a* 2>/dev/null | sed 's,.*/,,' | sed -e 's;^lib\(boost_system.*\)\.so.*$;\1;' -e 's;^lib\(boost_system.*\)\.dylib.*$;\1;' -e 's;^lib\(boost_system.*\)\.a.*$;\1;' ` ; do
				    AC_CHECK_LIB($ax_lib, main, [BOOST_ASIO_LIB="-l$ax_lib" AC_SUBST(BOOST_ASIO_LIB) link_thread="yes" break],
                                 [link_thread="no"])
				done
            else
               for ax_lib in $ax_boost_user_asio_lib $BN-$ax_boost_user_asio_lib; do
				      AC_CHECK_LIB($ax_lib, main,
                                   [BOOST_ASIO_LIB="-l$ax_lib" AC_SUBST(BOOST_ASIO_LIB) link_asio="yes" break],
                                   [link_asio="no"])
                  done

            fi
            if test "x$ax_lib" = "x"; then
                dnl Boost.System is header-only since Boost 1.69 and no longer
                dnl shipped as a library since 1.89; accept that if it links.
                AC_LANG_PUSH([C++])
                AC_LINK_IFELSE([_AX_BOOST_ASIO_PROGRAM],
                               [BOOST_ASIO_LIB=""
                                AC_SUBST(BOOST_ASIO_LIB)],
                               [AC_MSG_ERROR(Could not find a version of the Boost::Asio library!)])
                AC_LANG_POP([C++])
            fi
			if test "x$link_asio" = "xno"; then
				AC_MSG_ERROR(Could not link against $ax_lib !)
			fi
		fi

		CPPFLAGS="$CPPFLAGS_SAVED"
	LDFLAGS="$LDFLAGS_SAVED"
	fi
])
