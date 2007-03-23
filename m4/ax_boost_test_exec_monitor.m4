##### http://autoconf-archive.cryp.to/ax_boost_test_exec_monitor.html
#
# SYNOPSIS
#
#   AX_BOOST_TEST_EXEC_MONITOR
#
# DESCRIPTION
#
#   Test for Test_Exec_Monitor library from the Boost C++ libraries.
#   The macro requires a preceding call to AX_BOOST_BASE. Further
#   documentation is available at
#   <http://randspringer.de/boost/index.html>.
#
#   This macro calls:
#
#     AC_SUBST(BOOST_TEST_EXEC_MONITOR_LIB)
#
#   And sets:
#
#     HAVE_BOOST_TEST_EXEC_MONITOR
#
# LAST MODIFICATION
#
#   2007-03-12
#
# COPYLEFT
#
#   Copyright (c) 2007 Dodji Seketeli <dodji@seketeli.org>
#   Copyright (c) 2007 Thomas Porschberg <thomas@randspringer.de>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AX_BOOST_TEST_EXEC_MONITOR],
[
	AC_ARG_WITH([boost-test-exec-monitor],
	AS_HELP_STRING([--with-boost-test-exec-monitor@<:@=special-lib@:>@],
                   [use the Test_Exec_Monitor library from boost - it is possible to specify a certain library for the linker
                        e.g. --with-boost-test-exec-monitor=boost_test_exec_monitor-gcc ]),
        [
        if test "$withval" = "no"; then
			want_boost="no"
        elif test "$withval" = "yes"; then
            want_boost="yes"
            ax_boost_user_test_exec_monitor_lib=""
        else
		    want_boost="yes"
        	ax_boost_user_test_exec_monitor_lib="$withval"
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

        AC_CACHE_CHECK(whether the Boost::Test_Exec_Monitor library is available,
					   ax_cv_boost_test_exec_monitor,
        [AC_LANG_PUSH([C++])
			 AC_COMPILE_IFELSE(AC_LANG_PROGRAM([[@%:@include <boost/test/test_tools.hpp>]],
                                    [[int i=1 ; BOOST_REQUIRE(i==1); ; return 0;]]),
                   ax_cv_boost_test_exec_monitor=yes, ax_cv_boost_test_exec_monitor=no)
         AC_LANG_POP([C++])
		])
		if test "x$ax_cv_boost_test_exec_monitor" = "xyes"; then
			AC_DEFINE(HAVE_BOOST_TEST_EXEC_MONITOR,,[define if the Boost::Test_Exec_Monitor library is available])
			BN=boost_test_exec_monitor
            if test "x$ax_boost_user_test_exec_monitor_lib" = "x"; then
         		saved_ldflags="${LDFLAGS}"
		    	for ax_lib in $BN $BN-$CC $BN-$CC-mt $BN-$CC-mt-s $BN-$CC-s \
                             lib$BN lib$BN-$CC lib$BN-$CC-mt lib$BN-$CC-mt-s lib$BN-$CC-s \
                             $BN-mgw $BN-mgw $BN-mgw-mt $BN-mgw-mt-s $BN-mgw-s ; do
                   LDFLAGS="${LDFLAGS} -l$ax_lib"
    			   AC_CACHE_CHECK(Boost::TestExecMonitor library linkage,
	      			    		   ax_cv_boost_test_exec_monitor_link,
						  [AC_LANG_PUSH([C++])
                   AC_LINK_IFELSE([AC_LANG_PROGRAM([[@%:@include <boost/test/test_tools.hpp>
                                                     int test_main(int argc, char * argv[]) {
                                                     BOOST_REQUIRE(1==1) ;
                                                     return 0;
                                                     }
                                                   ]],
                                 [[ return 0;]])],
                                 link_test_exec_monitor="yes",link_test_exec_monitor="no")
			      AC_LANG_POP([C++])
                  ])
                  LDFLAGS="${saved_ldflags}"

			      if test "x$link_test_exec_monitor" = "xyes"; then
                      BOOST_TEST_EXEC_MONITOR_LIB="-l$ax_lib"
                      AC_SUBST(BOOST_TEST_EXEC_MONITOR_LIB)
					  break
				  fi
                done
            else
         		saved_ldflags="${LDFLAGS}"
               for ax_lib in $ax_boost_user_test_exec_monitor_lib $BN-$ax_boost_user_test_exec_monitor_lib; do
                   LDFLAGS="${LDFLAGS} -l$ax_lib"
              			   AC_CACHE_CHECK(Boost::TestExecMonitor library linkage,
	      			    		   ax_cv_boost_test_exec_monitor_link,
						  [AC_LANG_PUSH([C++])
                           AC_LINK_IFELSE([AC_LANG_PROGRAM([[@%:@include <boost/test/test_tools.hpp>
                                                        int test_main( int argc, char * argv[] ) {
                                                        BOOST_REQUIRE(1==1) ;
                                                        return 0;
                                                        }
                                                   ]],
                                 [[ return 0;]])],
                                 link_test_exec_monitor="yes",link_test_exec_monitor="no")
			      AC_LANG_POP([C++])
                  ])
                  LDFLAGS="${saved_ldflags}"
			      if test "x$link_test_exec_monitor" = "xyes"; then
                      BOOST_TEST_EXEC_MONITOR_LIB="-l$ax_lib"
                      AC_SUBST(BOOST_TEST_EXEC_MONITOR_LIB)
					  break
				  fi
               done
            fi
			if test "x$link_test_exec_monitor" = "xno"; then
				AC_MSG_ERROR(Could not link against $ax_lib !)
			fi
		fi

		CPPFLAGS="$CPPFLAGS_SAVED"
    	LDFLAGS="$LDFLAGS_SAVED"
	fi
])
