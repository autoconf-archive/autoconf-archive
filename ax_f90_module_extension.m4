##### http://autoconf-archive.cryp.to/ax_f90_module_extension.html
#
# SYNOPSIS
#
#   AX_F90_MODULE_EXTENSION
#
# DESCRIPTION
#
#   Find Fortran 90 modules file extension. The module extension is
#   stored in the cached variable ax_f90_modext, or "unknown" if the
#   extension cannot be found.
#
# LAST MODIFICATION
#
#   2005-06-17
#
# COPYLEFT
#
#   Copyright (c) 2005 Luc Maisonobe <luc@spaceroots.org>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AX_F90_MODULE_EXTENSION],[
AC_CACHE_CHECK([fortran 90 modules extension],
ax_f90_modext,
[AC_LANG_PUSH(Fortran)
i=0
while test \( -f tmpdir_$i \) -o \( -d tmpdir_$i \) ; do
  i=`expr $i + 1`
done
mkdir tmpdir_$i
cd tmpdir_$i
AC_COMPILE_IFELSE([module conftest_module
   contains
   subroutine conftest_routine
   write(*,'(a)') 'gotcha!'
   end subroutine conftest_routine
   end module conftest_module
  ],
  [ax_f90_modext=`ls | sed -n 's,conftest_module\.,,p'`
   if test x$ax_f90_modext = x ; then
dnl Some F90 compilers put module filename in uppercase letters
     ax_f90_modext=`ls | sed -n 's,CONFTEST_MODULE\.,,p'`
     if test x$ax_f90_modext = x ; then
       ax_f90_modext=unknown
     fi
   fi
  ],
  [ax_f90_modext=unknown])
cd ..
rm -fr tmpdir_$i
AC_LANG_POP(Fortran)
])])
