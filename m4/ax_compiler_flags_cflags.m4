# ============================================================================
#  http://www.gnu.org/software/autoconf-archive/ax_compiler_flags_cflags.html
# ============================================================================
#
# SYNOPSIS
#
#   AX_COMPILER_FLAGS_CFLAGS([VARIABLE], [IS-RELEASE], [EXTRA-BASE-FLAGS], [EXTRA-MINIMUM-FLAGS], [EXTRA-YES-FLAGS], [EXTRA-MAXIMUM-FLAGS], [EXTRA-ERROR-FLAGS])
#
# DESCRIPTION
#
#   Add warning flags for the C compiler to VARIABLE, which defaults to
#   WARN_CFLAGS.  VARIABLE is AC_SUBST-ed by this macro, but must be
#   manually added to the CFLAGS variable for each target in the code base.
#
#   This macro depends on the environment set up by AX_COMPILER_FLAGS.
#   Specifically, it uses the value of $ax_enable_compile_warnings to decide
#   which flags to enable.
#
# LICENSE
#
#   Copyright (c) 2014, 2015 Philip Withnall <philip@tecnocode.co.uk>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 3

AC_DEFUN([AX_COMPILER_FLAGS_CFLAGS],[
    AX_REQUIRE_DEFINED([AX_APPEND_COMPILE_FLAGS])
    AX_REQUIRE_DEFINED([AX_APPEND_FLAG])
    AX_REQUIRE_DEFINED([AX_CHECK_COMPILE_FLAG])

    # Variable names
    m4_define(ax_warn_cflags_variable,
              [m4_normalize(ifelse([$1],,[WARN_CFLAGS],[$1]))])

    # Always pass -Werror=unknown-warning-option to get Clang to fail on bad
    # flags, otherwise they are always appended to the warn_cflags variable, and
    # Clang warns on them for every compilation unit.
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
    ],ax_warn_cflags_variable,[$ax_compiler_flags_test])

    AS_IF([test "$ax_enable_compile_warnings" != "no"],[
        # "minimum" flags
        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wall dnl
            $4 dnl
        ],ax_warn_cflags_variable,[$ax_compiler_flags_test])
    ])
    AS_IF([test "$ax_enable_compile_warnings" != "no" -a \
                "$ax_enable_compile_warnings" != "minimum"],[
        # "yes" flags
        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wextra dnl
            -Wundef dnl
            -Wnested-externs dnl
            -Wwrite-strings dnl
            -Wpointer-arith dnl
            -Wmissing-declarations dnl
            -Wmissing-prototypes dnl
            -Wstrict-prototypes dnl
            -Wredundant-decls dnl
            -Wno-unused-parameter dnl
            -Wno-missing-field-initializers dnl
            -Wdeclaration-after-statement dnl
            -Wformat=2 dnl
            -Wold-style-definition dnl
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
            -Wimplicit-function-declaration dnl
            -Wreturn-type dnl
            $5 dnl
        ],ax_warn_cflags_variable,[$ax_compiler_flags_test])
    ])
    AS_IF([test "$ax_enable_compile_warnings" = "maximum" -o \
                "$ax_enable_compile_warnings" = "error"],[
        # "maximum" flags
        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wswitch-enum dnl
            -Wswitch-default dnl
            -Waggregate-return dnl
            $6 dnl
        ],ax_warn_cflags_variable,[$ax_compiler_flags_test])
    ])
    AS_IF([test "$ax_enable_compile_warnings" = "error"],[
        # "error" flags; -Werror has to be appended unconditionally because
        # it’s not possible to test for
        #
        # suggest-attribute=format is disabled because it gives too many false
        # positives
        AX_APPEND_FLAG([-Werror],ax_warn_cflags_variable)

        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wno-suggest-attribute=format dnl
            $7 dnl
        ],ax_warn_cflags_variable,[$ax_compiler_flags_test])
    ])

    # Substitute the variables
    AC_SUBST(ax_warn_cflags_variable)
])dnl AX_COMPILER_FLAGS
