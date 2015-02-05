# ==============================================================================
#  http://www.gnu.org/software/autoconf-archive/ax_compiler_flags_cxxflags.html
# ==============================================================================
#
# SYNOPSIS
#
#   AX_COMPILER_FLAGS_CXXFLAGS([VARIABLE], [IS-RELEASE], [EXTRA-BASE-FLAGS], [EXTRA-MINIMUM-FLAGS], [EXTRA-YES-FLAGS], [EXTRA-MAXIMUM-FLAGS], [EXTRA-ERROR-FLAGS])
#
# DESCRIPTION
#
#   Add warning flags for the C++ compiler to VARIABLE, which defaults to
#   WARN_CXXFLAGS.  VARIABLE is AC_SUBST-ed by this macro, but must be
#   manually added to the CXXFLAGS variable for each target in the code
#   base.
#
#   This macro depends on the environment set up by AX_COMPILER_FLAGS.
#   Specifically, it uses the value of $ax_enable_compile_warnings to decide
#   which flags to enable.
#
# LICENSE
#
#   Copyright (c) 2015 David King <amigadave@amigadave.com>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 1

AC_DEFUN([AX_COMPILER_FLAGS_CXXFLAGS],[
    AX_REQUIRE_DEFINED([AX_APPEND_COMPILE_FLAGS])
    AX_REQUIRE_DEFINED([AX_APPEND_FLAG])
    AX_REQUIRE_DEFINED([AX_CHECK_COMPILE_FLAG])

    # Variable names
    m4_define(ax_warn_cxxflags_variable,
              [m4_normalize(ifelse([$1],,[WARN_CXXFLAGS],[$1]))])

    AC_LANG_PUSH([C++])

    # Always pass -Werror=unknown-warning-option to get Clang to fail on bad
    # flags, otherwise they are always appended to the warn_cxxflags variable,
    # and Clang warns on them for every compilation unit.
    # If this is passed to GCC, it will explode, so the flag must be enabled
    # conditionally.
    AX_CHECK_COMPILE_FLAG([-Werror=unknown-warning-option],[
        ax_compiler_flags_test="-Werror=unknown-warning-option"
    ],[
        ax_compiler_flags_test=""
    ])

    # Base flags
    AX_APPEND_COMPILE_FLAGS([ dnl
        -fno-strict-aliasing dnl
        $3 dnl
    ],ax_warn_cxxflags_variable,[$ax_compiler_flags_test])

    AS_IF([test "$ax_enable_compile_warnings" != "no"],[
        # "minimum" flags
        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wall dnl
            $4 dnl
        ],ax_warn_cxxflags_variable,[$ax_compiler_flags_test])
    ])
    AS_IF([test "$ax_enable_compile_warnings" != "no" -a \
                "$ax_enable_compile_warnings" != "minimum"],[
        # "yes" flags
        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wextra dnl
            -Wundef dnl
            -Wwrite-strings dnl
            -Wpointer-arith dnl
            -Wmissing-declarations dnl
            -Wredundant-decls dnl
            -Wno-unused-parameter dnl
            -Wno-missing-field-initializers dnl
            -Wformat=2 dnl
            -Wcast-align dnl
            -Wformat-nonliteral dnl
            -Wformat-security dnl
            -Wsign-compare dnl
            -Wstrict-aliasing dnl
            -Wshadow dnl
            -Winline dnl
            -Wpacked dnl
            -Wmissing-format-attribute dnl
            -Wmissing-noreturn dnl
            -Winit-self dnl
            -Wredundant-decls dnl
            -Wmissing-include-dirs dnl
            -Wunused-but-set-variable dnl
            -Warray-bounds dnl
            -Wreturn-type dnl
            -Wno-overloaded-virtual dnl
            $5 dnl
        ],ax_warn_cxxflags_variable,[$ax_compiler_flags_test])
    ])
    AS_IF([test "$ax_enable_compile_warnings" = "maximum" -o \
                "$ax_enable_compile_warnings" = "error"],[
        # "maximum" flags
        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wswitch-enum dnl
            -Wswitch-default dnl
            $6 dnl
        ],ax_warn_cxxflags_variable,[$ax_compiler_flags_test])
    ])
    AS_IF([test "$ax_enable_compile_warnings" = "error"],[
        # "error" flags; -Werror has to be appended unconditionally because
        # it’s not possible to test for
        #
        # suggest-attribute=format is disabled because it gives too many false
        # positives
        AX_APPEND_FLAG([-Werror],ax_warn_cxxflags_variable)

        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wno-suggest-attribute=format dnl
            $7 dnl
        ],ax_warn_cxxflags_variable,[$ax_compiler_flags_test])
    ])

    AC_LANG_POP([C++])

    # Substitute the variables
    AC_SUBST(ax_warn_cxxflags_variable)
])dnl AX_COMPILER_FLAGS_CXXFLAGS
