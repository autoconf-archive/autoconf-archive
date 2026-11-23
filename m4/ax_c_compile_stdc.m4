# ===========================================================================
#    https://www.gnu.org/software/autoconf-archive/ax_c_compile_stdc.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_C_COMPILE_STDC(VERSION, [ext|noext], [mandatory|optional])
#
# DESCRIPTION
#
#   Check for baseline language coverage in the compiler for the specified
#   version of the C standard.  If necessary, add switches to CC and CPP to
#   enable support.  VERSION may be '99', '11', '17', or '23' for the
#   respective C standard version.
#
#   The second argument, if specified, indicates whether you insist on an
#   extended mode, e.g. -std=gnu99, ('ext') or a strict conformance mode,
#   e.g. -std=c99 ('noext').  If neither is specified, you get whatever
#   works, with preference for no added switch, and then for an extended
#   mode.
#
#   The third argument, if specified 'mandatory' or if left unspecified,
#   indicates that baseline support for the specified C standard is required
#   and that the macro should error out if no mode with that support is
#   found. If specified 'optional', then configuration proceeds regardless,
#   after defining HAVE_C${VERSION} if and only if a supporting mode is
#   found.
#
#   Please note that this file supplements the 'AC_PROG_CC' macro, which
#   enables the latest C standard available for the compiler, possibly with
#   GNU extensions. Use this macro to require a minimum standard
#   ('mandatory') or a strict conformance mode ('noext').
#
# LICENSE
#
#   Copyright (c) 2008 Benjamin Kosnik <bkoz@redhat.com>
#   Copyright (c) 2012 Zack Weinberg <zackw@panix.com>
#   Copyright (c) 2013 Roy Stogner <roystgnr@ices.utexas.edu>
#   Copyright (c) 2014, 2015 Google Inc.; contributed by Alexey Sokolov <sokolov@google.com>
#   Copyright (c) 2015 Paul Norman <penorman@mac.com>
#   Copyright (c) 2015 Moritz Klammler <moritz@klammler.eu>
#   Copyright (c) 2016, 2018 Krzesimir Nowak <qdlacz@gmail.com>
#   Copyright (c) 2019,2026 Enji Cooper <yaneurabeya@gmail.com>
#   Copyright (c) 2020 Jason Merrill <jason@redhat.com>
#   Copyright (c) 2021, 2024 Jörn Heusipp <osmanx@problemloesungsmaschine.de>
#   Copyright (c) 2015, 2022, 2023, 2024 Olly Betts
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 1

dnl  This macro is based on the code from the AX_CXX_COMPILE_STDCXX macro
dnl  (serial version number 26).

AC_DEFUN([AX_C_COMPILE_STDC], [dnl
  m4_if([$1], [99], [ax_c_compile_alternatives="99"],
        [$1], [11], [ax_c_compile_alternatives="11"],
        [$1], [17], [ax_c_compile_alternatives="17"],
        [$1], [23], [ax_c_compile_alternatives="23"],
        [m4_fatal([invalid first argument "$1" to AX_C_COMPILE_STDC])])dnl
  m4_if([$2], [], [],
        [$2], [ext], [],
        [$2], [noext], [],
        [m4_fatal([invalid second argument "$2" to AX_C_COMPILE_STDC])])dnl
  m4_if([$3], [], [ax_c_compile_c$1_required=true],
        [$3], [mandatory], [ax_c_compile_c$1_required=true],
        [$3], [optional], [ax_c_compile_c$1_required=false],
        [m4_fatal([invalid third argument "$3" to AX_C_COMPILE_STDC])])
  AC_LANG_PUSH([C])dnl
  ac_success=no

  m4_if([$2], [], [dnl
    AC_CACHE_CHECK(whether $CC supports C$1 features by default,
             ax_cv_cc_compile_c$1,
      [AC_COMPILE_IFELSE([AC_LANG_SOURCE([_AX_C_COMPILE_STDC_testbody_$1])],
        [ax_cv_cc_compile_c$1=yes],
        [ax_cv_cc_compile_c$1=no])])
    if test x$ax_cv_cc_compile_c$1 = xyes; then
      ac_success=yes
    fi])

  m4_if([$2], [noext], [], [dnl
  if test x$ac_success = xno; then
    for alternative in ${ax_c_compile_alternatives}; do
      switch="-std=gnu${alternative}"
      cachevar=AS_TR_SH([ax_cv_cc_compile_c$1_$switch])
      AC_CACHE_CHECK(whether $CC supports C$1 features with $switch,
                     $cachevar,
        [ac_save_CC="$CC"
         CC="$CC $switch"
         AC_COMPILE_IFELSE([AC_LANG_SOURCE([_AX_C_COMPILE_STDC_testbody_$1])],
          [eval $cachevar=yes],
          [eval $cachevar=no])
         CC="$ac_save_CC"])
      if eval test x\$$cachevar = xyes; then
        CC="$CC $switch"
        if test -n "$CPP" ; then
          CPP="$CPP $switch"
        fi
        ac_success=yes
        break
      fi
    done
  fi])

  m4_if([$2], [ext], [], [dnl
  if test x$ac_success = xno; then
    for alternative in ${ax_c_compile_alternatives}; do
      for switch in -std=c${alternative} +std=c${alternative} \
                    "-h std=c${alternative}" MSVC; do
        if test x"$switch" = xMSVC; then
          switch=-std:c${alternative}
          cachevar=AS_TR_SH([ax_cv_cc_compile_c$1_${switch}_MSVC])
        else
          cachevar=AS_TR_SH([ax_cv_cc_compile_c$1_$switch])
        fi
        AC_CACHE_CHECK(whether $CC supports C$1 features with $switch,
                       $cachevar,
          [ac_save_CC="$CC"
           CC="$CC $switch"
           AC_COMPILE_IFELSE([
             AC_LANG_SOURCE([_AX_C_COMPILE_STDC_testbody_$1])],
             [eval $cachevar=yes],
             [eval $cachevar=no])
           CC="$ac_save_CC"])
        if eval test x\$$cachevar = xyes; then
          CC="$CC $switch"
          if test -n "$CPP" ; then
            CPP="$CPP $switch"
          fi
          ac_success=yes
          break
        fi
      done
      if test x$ac_success = xyes; then
        break
      fi
    done
  fi])
  AC_LANG_POP([C])
  if test x$ax_c_compile_c$1_required = xtrue; then
    if test x$ac_success = xno; then
      AC_MSG_ERROR(
        [*** A compiler with support for C$1 language features is required.])
    fi
  fi
  if test x$ac_success = xno; then
    HAVE_C$1=0
    AC_MSG_NOTICE([No compiler with C$1 support was found])
  else
    HAVE_C$1=1
    AC_DEFINE(HAVE_C$1,1,
              [define if the compiler supports basic C$1 syntax])
  fi
  AC_SUBST(HAVE_C$1)
])


dnl  Test body for checking C99 support

m4_define([_AX_C_COMPILE_STDC_testbody_99],
  [_AX_C_COMPILE_STDC_testbody_new_in_99]
)

dnl  Test body for checking C11 support

m4_define([_AX_C_COMPILE_STDC_testbody_11],
  [_AX_C_COMPILE_STDC_testbody_new_in_99
   _AX_C_COMPILE_STDC_testbody_new_in_11]
)

dnl  Test body for checking C17 (amended C11) support

m4_define([_AX_C_COMPILE_STDC_testbody_17],
  [_AX_C_COMPILE_STDC_testbody_new_in_99
   _AX_C_COMPILE_STDC_testbody_new_in_11
   _AX_C_COMPILE_STDC_testbody_new_in_17]
)

dnl  Test body for checking C23 support

m4_define([_AX_C_COMPILE_STDC_testbody_23],
  [_AX_C_COMPILE_STDC_testbody_new_in_99
   _AX_C_COMPILE_STDC_testbody_new_in_11
   _AX_C_COMPILE_STDC_testbody_new_in_17
   _AX_C_COMPILE_STDC_testbody_new_in_23]
)

dnl  Tests for new features in C99

m4_define([_AX_C_COMPILE_STDC_testbody_new_in_99], [[

#ifndef __STDC_VERSION__

#error "This is not a C compiler"

#elif __STDC_VERSION__ < 199901L

#error "This is not a C99 compiler"

#else

inline void type_declaration_in_for_loop(void)
{
    for (int i = 0; i < 1; i++)
        ;
}

#endif  /* __STDC_VERSION__ >= 199901L */

]])

dnl  Tests for new features in C11

m4_define([_AX_C_COMPILE_STDC_testbody_new_in_11], [[

#ifndef __STDC_VERSION__

#error "This is not a C compiler"

#elif __STDC_VERSION__ < 201112L

#error "This is not a C11 compiler"

#else

#include <assert.h>

enum letters {
    A = 0,
    B,
    C,
    D
};

void static_assert_comes_from_assert_header(void) {
    _Static_assert(A == 0, "didn't match (1)");
    static_assert(D == 3, "didn't match (2)");
}

#endif  /* __STDC_VERSION__ >= 201112L */

]])

dnl  Tests for new features in C17

m4_define([_AX_C_COMPILE_STDC_testbody_new_in_17], [[

#ifndef __STDC_VERSION__

#error "This is not a C compiler"

#elif __STDC_VERSION__ < 201710L

#error "This is not a C17 compiler"

#else

/*
 * Add C11 -> C17 conformance tests here.
 *
 * (C17 is basically C11 + corrections).
 */

#endif  /* __STDC_VERSION__ >= 201710L */

]])

dnl  Tests for new features in C23

m4_define([_AX_C_COMPILE_STDC_testbody_new_in_23], [[

#ifndef __STDC_VERSION__

#error "This is not a C compiler"

#elif __STDC_VERSION__ < 202311L

#error "This is not a C23 compiler"

#else

/* Test out #elif*def preprocessor directives added in C23. */

#ifdef __NOT_DEFINED

#elifdef __MAYBE_DEFINED

#error "How did '__MAYBE_DEFINED' get defined?"

#elifndef __REALLY_NOT_DEFINED

_Bool hit__REALLY_NOT_DEFINED = true;

#else

#error "This conditional should not have been triggered"

#endif

inline void elifdef_preprocessor_directives_check(void) {
    if (!hit__REALLY_NOT_DEFINED) {
        /* This should fail to compile if the conditional isn't hit. */
        ;
    }
}

extern void auto_assignment_callee1(const int);
extern void auto_assignment_callee2(int);
inline void auto_assignment_keyword_check(void) {
    auto i = (int)0;
    const auto j = (int)0;
    typeof(i) k = i;
    auto_assignment_callee1(j);
    auto_assignment_callee2(k);
}

extern void typeof_keyword_callee1(int*);
extern void typeof_keyword_callee2(int);
inline void typeof_keywords_checks(void) {
    int *const cpi = nullptr;
    int cpi2;

    [[maybe_unused]] typeof(cpi) cpi_1 = cpi;
    [[maybe_unused]] typeof_unqual(cpi) cpi_2 = cpi;
    typeof_keyword_callee1(cpi);
    typeof_keyword_callee1(cpi_1);
    typeof_keyword_callee1(cpi_2);

    /* Using "typeof_unqual" squashes the const from the lvalue. */
    [[maybe_unused]] typeof(cpi2) cpi2_1 = cpi2;
    [[maybe_unused]] typeof_unqual(cpi2) cpi2_2 = cpi2;
    typeof_keyword_callee2(cpi2);
    typeof_keyword_callee2(cpi2_1);
    typeof_keyword_callee2(cpi2_2);
}

inline void switch_fallthrough_attribute_check(int i) {
    switch (i) {
    case 0:
        [[fallthrough]];
    default:
        return;
    }
}

#include <stdlib.h>

[[noreturn]] inline void noreturn_attribute_check(int i) {
    abort();
}

#endif  /* __STDC_VERSION__ < 202311L */
]])

# vim: syntax=m4:expandtab:shiftwidth=4:softtabstop=4:textwidth=76
