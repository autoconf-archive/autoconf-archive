##### http://autoconf-archive.cryp.to/ax_boost_wserialization.html
#
# SYNOPSIS
#
#   AX_BOOST_WSERIALIZATION
#
# DESCRIPTION
#
#   Test for Serialization library from the Boost C++ libraries. The
#   macro requires a preceding call to AX_BOOST_BASE. Further
#   documentation is available at
#   <http://randspringer.de/boost/index.html>.
#
#   This macro calls:
#
#     AC_SUBST(BOOST_WSERIALIZATION_LIB)
#
#   And sets:
#
#     HAVE_BOOST_WSERIALIZATION
#
# LAST MODIFICATION
#
#   2007-03-12
#
# COPYLEFT
#
#   Copyright (c) 2007 Thomas Porschberg <thomas@randspringer.de>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AX_BOOST_WSERIALIZATION],
[
	AC_ARG_WITH([boost-wserialization],
	AS_HELP_STRING([--with-boost-wserialization@<:@=special-lib@:>@],
                   [use the WSerialization library from boost -  it is possible to specify a certain library for the linker
                        e.g. --with-boost-wserialization=boost_wserialization-gcc-mt-d-1_33_1 ]),
        [
        if test "$withval" = "no"; then
			want_boost="no"
        elif test "$withval" = "yes"; then
            want_boost="yes"
            ax_boost_user_wserialization_lib=""
        else
		    want_boost="yes"
        	ax_boost_user_wserialization_lib="$withval"
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

        AC_CACHE_CHECK(whether the Boost::WSerialization library is available,
					   ax_cv_boost_wserialization,
        [AC_LANG_PUSH([C++])
			 AC_COMPILE_IFELSE(AC_LANG_PROGRAM([[@%:@include <fstream>
												 @%:@include <boost/archive/text_oarchive.hpp>
                                                 @%:@include <boost/archive/text_iarchive.hpp>
												]],
                                   [[std::ofstream ofs("filename");
									boost::archive::text_oarchive oa(ofs);
									 return 0;
                                   ]]),
                   ax_cv_boost_wserialization=yes, ax_cv_boost_wserialization=no)
         AC_LANG_POP([C++])
		])
		if test "x$ax_cv_boost_wserialization" = "xyes"; then
			AC_DEFINE(HAVE_BOOST_WSERIALIZATION,,[define if the Boost::WSerialization library is available])
			BN=boost_wserialization
            if test "x$ax_boost_user_wserialization_lib" = "x"; then
				for ax_lib in $BN $BN-$CC $BN-$CC-mt $BN-$CC-mt-s $BN-$CC-s \
                              lib$BN lib$BN-$CC lib$BN-$CC-mt lib$BN-$CC-mt-s lib$BN-$CC-s \
                              $BN-mgw $BN-mgw $BN-mgw-mt $BN-mgw-mt-s $BN-mgw-s ; do
				    AC_CHECK_LIB($ax_lib, main,
                                 [BOOST_WSERIALIZATION_LIB="-l$ax_lib"; AC_SUBST(BOOST_WSERIALIZATION_LIB) link_wserialization="yes"; break],
                                 [link_wserialization="no"])
  				done
            else
               for ax_lib in $ax_boost_user_wserialization_lib $BN-$ax_boost_user_wserialization_lib; do
				      AC_CHECK_LIB($ax_lib, main,
                                   [BOOST_WSERIALIZATION_LIB="-l$ax_lib"; AC_SUBST(BOOST_WSERIALIZATION_LIB) link_wserialization="yes"; break],
                                   [link_wserialization="no"])
                  done

            fi
			if test "x$link_wserialization" = "xno"; then
				AC_MSG_ERROR(Could not link against $ax_lib !)
			fi
		fi

		CPPFLAGS="$CPPFLAGS_SAVED"
    	LDFLAGS="$LDFLAGS_SAVED"
	fi
])
