# ===========================================================================
#     http://www.gnu.org/software/autoconf-archive/ax_compiler_flags.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_COMPILER_FLAGS([CFLAGS-VARIABLE], [LDFLAGS-VARIABLE], [IS-RELEASE], [EXTRA-BASE-CFLAGS], [EXTRA-MINIMUM-CFLAGS], [EXTRA-YES-CFLAGS], [EXTRA-MAXIMUM-CFLAGS], [EXTRA-ERROR-CFLAGS], [EXTRA-BASE-LDFLAGS], [EXTRA-MINIMUM-LDFLAGS], [EXTRA-YES-LDFLAGS], [EXTRA-MAXIMUM-LDFLAGS], [EXTRA-ERROR-LDFLAGS])
#
# DESCRIPTION
#
#   Check for the presence of an --enable-compile-warnings option to
#   configure, defaulting to "error" in normal operation, or "yes" if
#   IS-RELEASE is equal to "yes".  Return the value in the variable
#   $ax_enable_compile_warnings.
#
#   Depending on the value of --enable-compile-warnings, different compiler
#   warnings are checked to see if they work with the current compiler and,
#   if so, are appended to CFLAGS-VARIABLE and LDFLAGS-VARIABLE.  This
#   allows a consistent set of baseline compiler warnings to be used across
#   a code base, irrespective of any warnings enabled locally by individual
#   developers.  By standardising the warnings used by all developers of a
#   project, the project can commit to a zero-warnings policy, using -Werror
#   to prevent compilation if new warnings are introduced.  This makes
#   catching bugs which are flagged by warnings a lot easier.
#
#   By providing a consistent --enable-compile-warnings argument across all
#   projects using this macro, continuous integration systems can easily be
#   configured the same for all projects.
#
#   --enable-compile-warnings can take the values:
#
#    * no:      Base compiler warnings only; not even -Wall.
#    * minimum: The above, plus minimal extra warnings such as -Wall.
#    * yes:     The above, plus a broad range of useful warnings.
#    * maximum: The above, plus additional warnings which enforce a particular
#               coding style
#    * error:   The above, plus -Werror so that all warnings are fatal.
#
#   The set of flags enabled at each level can be augmented using the
#   EXTRA-*-CFLAGS and EXTRA-*-LDFLAGS variables.  Flags should not be
#   disabled using these arguments, as the entire point of AX_COMPILER_FLAGS
#   is to enforce a consistent set of useful compiler warnings on code,
#   using warnings which have been chosen for low false positive rates.
#
#   IS-RELEASE can be used to disable -Werror when making a release, which
#   is useful for those hairy moments when you just want to get the release
#   done as quickly as possible.  Set it to "yes" to disable -Werror.
#
#   CFLAGS-VARIABLE defaults to WARN_CFLAGS, and LDFLAGS-VARIABLE defaults
#   to WARN_LDFLAGS.  Both variables are AC_SUBST-ed by this macro, but must
#   be manually added to the CFLAGS and LDFLAGS variables for each target in
#   the code base.
#
# LICENSE
#
#   Copyright (c) 2014 Philip Withnall <philip@tecnocode.co.uk>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 1

AC_DEFUN([AX_COMPILER_FLAGS],[
    AX_REQUIRE_DEFINED([AX_APPEND_COMPILE_FLAGS])
    AX_REQUIRE_DEFINED([AX_APPEND_FLAG])
    AX_REQUIRE_DEFINED([AX_CHECK_COMPILE_FLAG])

    AC_ARG_ENABLE([compile-warnings],
                  AS_HELP_STRING([--enable-compile-warnings=@<:@no/minimum/yes/maximum/error@:>@],
                                 [Enable different levels of compiler warnings]),,
                  [AS_IF([test "$3" = "yes"],
                         [enable_compile_warnings="yes"],
                         [enable_compile_warnings="error"])])

    # Variable names
    m4_define(ax_warn_cflags_variable,
              [m4_normalize(ifelse([$1],,[WARN_CFLAGS],[$1]))])
    m4_define(ax_warn_ldflags_variable,
              [m4_normalize(ifelse([$2],,[WARN_LDFLAGS],[$2]))])

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
        $4 dnl
    ],ax_warn_cflags_variable,[$ax_compiler_flags_test])
    AX_APPEND_COMPILE_FLAGS([ dnl
        -Wl,--no-as-needed dnl
        $9 dnl
    ],ax_warn_ldflags_variable,[$ax_compiler_flags_test])

    AS_IF([test "$enable_compile_warnings" != "no"],[
        # "minimum" flags
        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wall dnl
            $5 dnl
        ],ax_warn_cflags_variable,[$ax_compiler_flags_test])
        AX_APPEND_COMPILE_FLAGS([$10],
                                ax_warn_ldflags_variable,
                                [$ax_compiler_flags_test])
    ])
    AS_IF([test "$enable_compile_warnings" != "no" -a \
                "$enable_compile_warnings" != "minimum"],[
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
            $6 dnl
        ],ax_warn_cflags_variable,[$ax_compiler_flags_test])
        AX_APPEND_COMPILE_FLAGS([$11],
                                ax_warn_ldflags_variable,
                                [$ax_compiler_flags_test])
    ])
    AS_IF([test "$enable_compile_warnings" = "maximum" -o \
                "$enable_compile_warnings" = "error"],[
        # "maximum" flags
        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wswitch-enum dnl
            -Wswitch-default dnl
            -Waggregate-return dnl
            $7 dnl
        ],ax_warn_cflags_variable,[$ax_compiler_flags_test])
        AX_APPEND_COMPILE_FLAGS([$12],
                                ax_warn_ldflags_variable,
                                [$ax_compiler_flags_test])
    ])
    AS_IF([test "$enable_compile_warnings" = "error"],[
        # "error" flags; -Werror has to be appended unconditionally because
        # it’s not possible to test for
        #
        # suggest-attribute=format is disabled because it gives too many false
        # positives
        AX_APPEND_FLAG([-Werror],ax_warn_cflags_variable)

        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wno-suggest-attribute=format dnl
            $8 dnl
        ],ax_warn_cflags_variable,[$ax_compiler_flags_test])
        AX_APPEND_COMPILE_FLAGS([ dnl
            -Wl,--fatal-warnings dnl
            $13 dnl
        ],ax_warn_ldflags_variable,[$ax_compiler_flags_test])
    ])

    # Substitute the variables
    AC_SUBST(ax_warn_cflags_variable)
    AC_SUBST(ax_warn_ldflags_variable)

    # Return the user’s chosen warning level
    ax_enable_compile_warnings=$enable_compile_warnings
])dnl AX_COMPILER_FLAGS
