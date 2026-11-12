# ===========================================================================
#     https://www.gnu.org/software/autoconf-archive/ax_boost_process.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_BOOST_PROCESS
#
# DESCRIPTION
#
#   Test for Process library from the Boost C++ libraries. The macro
#   requires a preceding call to AX_BOOST_BASE. Further documentation is
#   available at <http://randspringer.de/boost/index.html>.
#
#   This macro calls:
#
#     AC_SUBST(BOOST_PROCESS_LIB)
#
#   And sets:
#
#     HAVE_BOOST_PROCESS
#
# LICENSE
#
#   Copyright (c) 2008 Thomas Porschberg <thomas@randspringer.de>
#   Copyright (c) 2008 Michael Tindal
#   Copyright (c) 2008 Daniel Casimiro <dan.casimiro@gmail.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 7

AC_DEFUN([_AX_BOOST_PROCESS_COMPILE_CHECK_V1],
[
	AS_ECHO(["Checking Boost.Process API v1"]) >&AS_MESSAGE_LOG_FD
	AC_COMPILE_IFELSE(
		[AC_LANG_PROGRAM(
			[[
				@%:@include <boost/version.hpp>
				@%:@if BOOST_VERSION < 108800
					@%:@include <boost/process.hpp>
					namespace bp = boost::process;
				@%:@else
					@%:@include <boost/process/v1.hpp>
					namespace bp = boost::process::v1;
				@%:@endif
			]],
			[[
				bp::child* child = new bp::child;
				delete child;
			]]
		)],
		[ax_cv_boost_process=yes],
		[ax_cv_boost_process=no]
	)
])

AC_DEFUN([_AX_BOOST_PROCESS_COMPILE_CHECK_V2],
[
	AS_ECHO(["Checking Boost.Process API v2"]) >&AS_MESSAGE_LOG_FD
	AC_COMPILE_IFELSE(
		[AC_LANG_PROGRAM(
			[[
				@%:@include <boost/asio/io_context.hpp>
				@%:@include <boost/process/v2/process.hpp>

				namespace bp = boost::process::v2;
			]],
			[[
				boost::asio::io_context ctx;
				bp::process* proc = new bp::process(ctx);
				delete proc;
			]]
		)],
		[ax_cv_boost_process=yes],
		[ax_cv_boost_process=no]
	)
])

AC_DEFUN([_AX_BOOST_PROCESS_LINK_CHECK_V1],
[
	AS_ECHO(["Checking Boost.Process linking v1"]) >&AS_MESSAGE_LOG_FD
	AC_LINK_IFELSE(
		[AC_LANG_PROGRAM(
			[[
				@%:@include <boost/version.hpp>
				@%:@if BOOST_VERSION < 108800
					@%:@include <boost/process.hpp>
					namespace bp = boost::process;
				@%:@else
					@%:@include <boost/process/v1.hpp>
					namespace bp = boost::process::v1;
				@%:@endif
			]],
			[[
				bp::child child("/bin/true");
				child.wait();
			]]
		)],
		[link_process=yes],
		[link_process=no]
	)
])

AC_DEFUN([_AX_BOOST_PROCESS_LINK_CHECK_V2],
[
	AS_ECHO(["Checking Boost.Process linking v2"]) >&AS_MESSAGE_LOG_FD
	AC_LINK_IFELSE(
		[AC_LANG_PROGRAM(
			[[
				@%:@include <string>
				@%:@include <vector>
				@%:@include <boost/asio/io_context.hpp>
				@%:@include <boost/process/v2/process.hpp>
				namespace bp = boost::process::v2;
			]],
			[[
				boost::asio::io_context ctx;
				bp::process proc(ctx, "/bin/true", std::vector<std::string>{});
				proc.wait();
			]]
		)],
		[link_process=yes],
		[link_process=no]
	)
])

AC_DEFUN([AX_BOOST_PROCESS],
[
	AC_ARG_WITH(
		[boost-process],
		AS_HELP_STRING(
			[--with-boost-process@<:@=special-lib@:>@],
			[for boost custom installations, you can specify the custom paths
				and the library you want to link to, e.g:
				./configure --with-boost=/opt/boost --with-boost-libdir=/opt/boost/lib
				--with-boost-process=boost_process-custom
			]
		),
		[
		if test "$withval" = "no"; then
			want_boost_process="no"
		elif test "$withval" = "yes"; then
			want_boost_process="yes"
			ax_boost_user_process_lib=""
		else
			want_boost_process="yes"
			ax_boost_user_process_lib="$withval"
		fi
		],
		[want_boost_process="yes"]
	)

	AC_ARG_WITH(
		[boost-process-api],
		AS_HELP_STRING(
			[--with-boost-process-api@<:@=API@:>@],
			[select Boost.Process API (auto, v1 or v2) @<:@default=auto@:>@]
		),
		[
			case "$withval" in
				yes|auto)
					boost_process_api=auto
					;;
				v1|v2)
					boost_process_api="$withval"
					;;
				*)
					AC_MSG_ERROR([Invalid Boost.Process API: $withval])
				;;
			esac
		],
		[boost_process_api=auto]
	)

	if test "x$want_boost_process" = "xyes"; then
		AC_REQUIRE([AC_PROG_CC])
		AC_REQUIRE([AC_CANONICAL_BUILD])
		CPPFLAGS_SAVED="$CPPFLAGS"
		CPPFLAGS="$CPPFLAGS $BOOST_CPPFLAGS"
		export CPPFLAGS

		LDFLAGS_SAVED="$LDFLAGS"
		LDFLAGS="$LDFLAGS $BOOST_LDFLAGS"
		export LDFLAGS

		AS_ECHO(["searching <boost/version.hpp> with CPPFLAGS=$CPPFLAGS"]) >&AS_MESSAGE_LOG_FD
		AC_LANG_PUSH([C++])
		AC_COMPUTE_INT(
			[boost_version],
			[BOOST_VERSION],
			[[
				@%:@include <boost/version.hpp>
			]],
			[AC_MSG_ERROR([Cannot determine Boost version])]
		)
		AC_LANG_POP([C++])

		AC_MSG_CHECKING([Boost version])
		AC_MSG_RESULT([$boost_version])

		AS_IF(
			[test "x$boost_process_api" = "xauto"],
			[
				AS_IF(
					[test "$boost_version" -lt 108800],
					[boost_process_api=v1],
					[boost_process_api=v2]
				)
			]
		)
		AC_MSG_CHECKING([Boost.Process API])
		AC_MSG_RESULT([$boost_process_api])

		AC_CACHE_CHECK(whether the Boost::Process library is available,
			ax_cv_boost_process,
			[
				AC_LANG_PUSH([C++])
				CXXFLAGS_SAVE=$CXXFLAGS
				CXXFLAGS=

				AS_CASE(
					[$boost_process_api],
					[v1], [_AX_BOOST_PROCESS_COMPILE_CHECK_V1],
					[v2], [_AX_BOOST_PROCESS_COMPILE_CHECK_V2],
					[*], [AC_MSG_ERROR([Unsupported Boost.Process API: $boost_process_api])]
				)

				CXXFLAGS=$CXXFLAGS_SAVE
				AC_LANG_POP([C++])
			]
		)
		if test "x$ax_cv_boost_process" = "xyes"; then
			AC_SUBST(BOOST_CPPFLAGS)
			AC_DEFINE(HAVE_BOOST_PROCESS,,[define if the Boost::Process library is available])

			AC_MSG_CHECKING([whether the Boost::Process library can be linked])
			LDFLAGS_SAVE="$LDFLAGS"
			LIBS_SAVE="$LIBS"

			AS_IF(
				[test "x$ax_boost_user_process_lib" = "x"],
				[ax_boost_process_lib=boost_process],
				[ax_boost_process_lib="$ax_boost_user_process_lib"]
			)

			BOOST_PROCESS_LIB="-l$ax_boost_process_lib"
			AC_SUBST([BOOST_PROCESS_LIB])

			link_process=no
			LIBS="$BOOST_PROCESS_LIB $LIBS"

			AC_LANG_PUSH([C++])

			AS_CASE(
				[$boost_process_api],
				[v1], [_AX_BOOST_PROCESS_LINK_CHECK_V1],
				[v2], [_AX_BOOST_PROCESS_LINK_CHECK_V2],
				[*], [AC_MSG_ERROR([Unsupported Boost.Process API: $boost_process_api])]
			)

			AC_LANG_POP([C++])

			AC_MSG_RESULT([$link_process])

			LDFLAGS="$LDFLAGS_SAVE"
			LIBS="$LIBS_SAVE"

			AS_IF(
				[test "x$link_process" != "xyes"],
				[AC_MSG_ERROR([Could not find a version of the Boost::Process library!])]
			)
		fi

		CPPFLAGS="$CPPFLAGS_SAVED"
		LDFLAGS="$LDFLAGS_SAVED"
	fi
])
