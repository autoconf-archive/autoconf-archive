# ===========================================================================
#     http://www.gnu.org/software/autoconf-archive/ax_compiler_flags_gir.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_COMPILER_FLAGS_GIR([VARIABLE], [IS-RELEASE], [EXTRA-BASE-FLAGS], [EXTRA-MINIMUM-FLAGS], [EXTRA-YES-FLAGS], [EXTRA-MAXIMUM-FLAGS], [EXTRA-ERROR-FLAGS])
#
# DESCRIPTION
#
#   Add warning flags for the g-ir-scanner (from GObject Introspection) to
#   VARIABLE, which defaults to WARN_SCANNERFLAGS.  VARIABLE is AC_SUBST-ed by
#   this macro, but must be manually added to the SCANNERFLAGS variable for
#   each GIR target in the code base.
#
#   This macro depends on the environment set up by AX_COMPILER_FLAGS.
#   Specifically, it uses the value of $ax_enable_compile_warnings to decide
#   which flags to enable.
#
# LICENSE
#
#   Copyright (c) 2015 Philip Withnall <philip@tecnocode.co.uk>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.  This file is offered as-is, without any
#   warranty.

#serial 1

AC_DEFUN([AX_COMPILER_FLAGS_GIR],[
    AX_REQUIRE_DEFINED([AX_APPEND_FLAG])

    # Variable names
    m4_define(ax_warn_scannerflags_variable,
              [m4_normalize(ifelse([$1],,[WARN_SCANNERFLAGS],[$1]))])

    # Base flags
    AX_APPEND_FLAG([$3],ax_warn_scannerflags_variable)

    AS_IF([test "$ax_enable_compile_warnings" != "no"],[
        # "minimum" flags
        AX_APPEND_FLAG([ dnl
            --warn-all dnl
            $4 dnl
        ],ax_warn_scannerflags_variable)
    ])	
    AS_IF([test "$ax_enable_compile_warnings" != "no" -a \
                "$ax_enable_compile_warnings" != "minimum"],[
        # "yes" flags
        AX_APPEND_FLAG([$5],ax_warn_scannerflags_variable)
    ])
    AS_IF([test "$ax_enable_compile_warnings" = "maximum" -o \
                "$ax_enable_compile_warnings" = "error"],[
        # "maximum" flags
        AX_APPEND_FLAG([$6],ax_warn_scannerflags_variable)
    ])
    AS_IF([test "$ax_enable_compile_warnings" = "error"],[
        # "error" flags
        AX_APPEND_FLAG([ dnl
            --warn-error dnl
            $7 dnl
        ],ax_warn_scannerflags_variable)
    ])

    # Substitute the variables
    AC_SUBST(ax_warn_scannerflags_variable)
])dnl AX_COMPILER_FLAGS
