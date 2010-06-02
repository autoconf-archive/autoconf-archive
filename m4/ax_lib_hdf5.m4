# ===========================================================================
#        http://www.gnu.org/software/autoconf-archive/ax_lib_hdf5.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_LIB_HDF5
#
# DESCRIPTION
#
#   This macro provides tests of the availability of HDF5 library.
#
#   This --with-hdf5 option takes one of three possible values:
#
#     no   - do not check for the HDF5 library.
#     yes  - do check for HDF5 library in standard locations.
#     path - complete path to where lib/libhdf5* libraries and
#            include/H5* include files reside.
#
#   This macro calls:
#
#     AC_SUBST(HDF5_VERSION)
#     AC_SUBST(HDF5_CFLAGS)
#     AC_SUBST(HDF5_CPPFLAGS)
#     AC_SUBST(HDF5_LDFLAGS)
#     AC_DEFINE(HAVE_HDF5)
#
#   and sets
#
#     with_hdf5="yes"
#
#   if found other the calls are not made and sets "with_hdf5" to "no".
#
#   To use tho macro, one would write the following code in "configure.ac":
#
#     dnl Check for HDF5 support
#     AX_LIB_HDF5()
#
#     AC_OUTPUT
#     echo "HDF5 support:  $with_hdf5"
#
# LICENSE
#
#   Copyright (c) 2009 Timothy Brown <tbrown@freeshell.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 2

AC_DEFUN([AX_LIB_HDF5], [

dnl Add a default --with-hdf5 configuration option.
AC_ARG_WITH([hdf5],
  AS_HELP_STRING([--with-hdf5=],
                [location of h5cc or h5pcc, for HDF5 configuration]),
  [if test "$withval" = "no"; then
     with_hdf5="no"
   elif test "$withval" = "yes"; then
     with_hdf5="yes"
   else
     with_hdf5="yes"
     H5CC="$withval"
   fi],
   [with_hdf5="yes"]
)

dnl Set defaults to blank
HDf5_VERSION=""
HDF5_CFLAGS=""
HDF5_CPPFLAGS=""
HDF5_LDFLAGS=""

dnl Try and find hdf5 compiler tools and options.
if test "$with_hdf5" = "yes"; then
	dnl Search the default path
	if test -z "$H5CC" -o test; then
		dnl Check to see if H5CC is in the deault place.
		AC_PATH_PROGS([H5CC], [h5cc  h5pcc], [])
	fi
	AC_MSG_CHECKING([for HDF5 libraries])
	if test ! -x "$H5CC"; then
		AC_MSG_RESULT([no])
		AC_MSG_WARN([
Unable to locate HDF5 compiling helper scripts 'h5cc' or 'h5pcc'.
Please specify --with-hdf5=<LOCATION> As the full path to h5cc or h5pcc.
HDF5 support is being disabled (equivalent to --with-hdf5=no).
		])
		with_hdf5="no"
	else
		dnl h5cc provides both AM_ and non-AM_ options
		dnl depending on how it was compiled either one of
		dnl these are empty. Lets roll them both into one.

		dnl Look for "HDF5 Version: X.Y.Z"
		HDF5_VERSION=$(eval $H5CC -showconfig | grep 'HDF5 Version:' \
			| awk '{print $[]3}')

dnl A ideal situation would be where everything we needed was
dnl in the AM_* variables. However most systems are not like this
dnl and seem to have the values in the non-AM variables.
dnl
dnl We try the following to find the flags:
dnl (1) Look for "NAME:" tags
dnl (2) Look for "NAME/H5_NAME:" tags
dnl (3) Look for "AM_NAME:" tags
dnl
		dnl (1)
		dnl Look for "CFLAGS: "
		HDF5_CFLAGS=$(eval $H5CC -showconfig | grep '\bCFLAGS:'   \
			| awk -F: '{print $[]2}')
		dnl Look for "CPPFLAGS"
		HDF5_CPPFLAGS=$(eval $H5CC -showconfig | grep '\bCPPFLAGS:' \
			| awk -F: '{print $[]2}')
		dnl Look for "LD_FLAGS"
		HDF5_LDFLAGS=$(eval $H5CC -showconfig | grep '\bLDFLAGS:'   \
			| awk -F: '{print $[]2}')

		dnl (2)
		dnl CFLAGS/H5_CFLAGS: .../....
		dnl We could use sed with something like the following
		dnl 's/CFLAGS.*\/H5_CFLAGS.*[:]\(.*\)\/\(.*\)/\1/p'
		if test -z "$HDF5_CFLAGS"; then
			HDF5_CFLAGS=$(eval $H5CC -showconfig \
				| sed -n 's/CFLAGS.*[:]\(.*\)\/\(.*\)/\1/p')
		fi
		dnl Look for "CPPFLAGS"
		if test -z "$HDF5_CPPFLAGS"; then
			HDF5_CPPFLAGS=$(eval $H5CC -showconfig \
				| sed -n 's/CPPFLAGS.*[:]\(.*\)\/\(.*\)/\1/p')
		fi
		dnl Look for "LD_FLAGS"
		if test -z "$HDF5_LDFLAGS"; then
			HDF5_LDFLAGS=$(eval $H5CC -showconfig \
				| sed -n 's/LDFLAGS.*[:]\(.*\)\/\(.*\)/\1/p')
		fi

		dnl (3)
		dnl Check to see if these are not empty strings. If so
		dnl find the AM_ versions and use them.
		if test -z "$HDF5_CFLAGS"; then
			HDF5_CFLAGS=$(eval $H5CC -showconfig \
				| grep 'AM_CFLAGS:' | awk -F: '{print $[]2}')
		fi
		if test -z "$HDF5_CPPFLAGS"; then
			HDF5_CPPFLAGS=$(eval $H5CC -showconfig \
				| grep 'AM_CPPFLAGS:' | awk -F: '{print $[]2}')
		fi
		if test -z "$HDF5_LDFLAGS"; then
			HDF5_LDFLAGS=$(eval $H5CC -showconfig \
				| grep 'AM_LDFLAGS:' | awk -F: '{print $[]2}')
		fi

		dnl Add the library
		HDF5_LDFLAGS="$HDF5_LDFLAGS -lhdf5"

		dnl Look for and extra libraries we need to link too
		EXTRA_LIBS=$(eval $H5CC -showconfig | grep 'Extra libraries:'\
			| awk -F: '{print $[]2}')
		dnl Add the EXTRA_LIBS
		if test "$EXTRA_LIBS"; then
			HDF5_LDFLAGS="$HDF5_LDFLAGS $EXTRA_LIBS"
		fi

		AC_MSG_RESULT([yes (version $[HDF5_VERSION])])
	fi
	AC_SUBST([HDF5_VERSION])
	AC_SUBST([HDF5_CFLAGS])
	AC_SUBST([HDF5_CPPFLAGS])
	AC_SUBST([HDF5_LDFLAGS])
	AC_DEFINE([HAVE_HDF5], [1], [Defined if you have HDF5 support])
fi
])
