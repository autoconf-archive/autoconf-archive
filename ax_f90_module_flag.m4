##### http://autoconf-archive.cryp.to/ax_f90_module_flag.html
#
# SYNOPSIS
#
#   AX_F90_MODULE_FLAG
#
# DESCRIPTION
#
#   Find Fortran 90 modules inclusion flag. The module inclusion flag
#   is stored in the cached variable ax_f90_modflag. An error is
#   triggered if the flag cannot be found. Supported are the -I GNU
#   compilers flag, the -M SUN compilers flag, the -p flag for Absoft
#   Pro Fortran compilers, and the -module flag for the PGI Fortran
#   compiler.
#
#   Note that on the PGI compiler the first directory specified with
#   -module is also the directory where any module files that are
#   produced will be written out. So if this flag is used and the first
#   directory specified does not have write permissions, an error will
#   occur. The most sensible thing to do is is to place
#   "$(ax_f90_modflag)." on the compile line first to put the current
#   directory at the front of the list before any other module file
#   directories.
#
# LAST MODIFICATION
#
#   2007-08-04
#
# COPYLEFT
#
#   Copyright (c) 2007 Luc Maisonobe <luc@spaceroots.org>
#   Copyright (c) 2007 Julian C. Cummings <cummings@cacr.caltech.edu>
#   Copyright (c) 2007 Alexander Pletzer <pletzer@txcorp.com>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AX_F90_MODULE_FLAG],[
AC_CACHE_CHECK([fortran 90 modules inclusion flag],
ax_f90_modflag,
[AC_LANG_PUSH(Fortran)
i=0
while test \( -f tmpdir_$i \) -o \( -d tmpdir_$i \) ; do
  i=`expr $i + 1`
done
mkdir tmpdir_$i
cd tmpdir_$i
AC_COMPILE_IFELSE([
!234567
      module conftest_module
      contains
      subroutine conftest_routine
      write(*,'(a)') 'gotcha!'
      end subroutine conftest_routine
      end module conftest_module
  ],[],[])
cd ..
ax_f90_modflag="not found"
for ax_flag in "-module " "-I " "-M" "-p"; do
  if test "$ax_f90_modflag" = "not found" ; then
    ax_save_FCFLAGS="$FCFLAGS"
    FCFLAGS="$ax_save_FCFLAGS ${ax_flag}tmpdir_$i"
    AC_COMPILE_IFELSE([
!234567
      program conftest_program
      use conftest_module
      call conftest_routine
      end program conftest_program
      ],[ax_f90_modflag="$ax_flag"],[])
    FCFLAGS="$ax_save_FCFLAGS"
  fi
done
rm -fr tmpdir_$i
if test "$ax_f90_modflag" = "not found" ; then
  AC_MSG_ERROR([unable to find compiler flag for modules inclusion])
fi
AC_LANG_POP(Fortran)
])])
