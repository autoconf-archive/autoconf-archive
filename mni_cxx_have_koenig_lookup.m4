# ===========================================================================
#       http://autoconf-archive.cryp.to/mni_cxx_have_koenig_lookup.html
# ===========================================================================
#
# SYNOPSIS
#
#   mni_CXX_HAVE_KOENIG_LOOKUP
#
# DESCRIPTION
#
#   Define CXX_HAVE_KOENIG_LOOKUP if the C++ compiler has argument-dependent
#   name lookup (a.k.a. Koenig lookup).
#
# LICENSE
#
#   Copyright (c) 2008 Steve M. Robbins <smr@debian.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([mni_CXX_HAVE_KOENIG_LOOKUP],
    [AC_CACHE_CHECK(whether the compiler implements Koenig lookup,
                    ac_cv_cxx_have_koenig_lookup,
                    [AC_LANG_PUSH(C++)
                     AC_TRY_COMPILE([
    namespace N1 {
        class C {};
        void f1(const C& c) {}
    }

    namespace N2 {
        void f2() {
            N1::C x;
            f1(x);     // resolves to N1::f1() if we have Koenig lookup,
                       // otherwise this will fail to compile.
        }
    }
    ],[],
                     ac_cv_cxx_have_koenig_lookup=yes,
                     ac_cv_cxx_have_koenig_lookup=no)
                     AC_LANG_POP])
    if test "$ac_cv_cxx_have_koenig_lookup" = yes; then
        AC_DEFINE(CXX_HAVE_KOENIG_LOOKUP,1,
                  [define to 1 if the compiler implements Koenig lookup])
    fi
])
