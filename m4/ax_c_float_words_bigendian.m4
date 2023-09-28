# ===============================================================================
#  https://www.gnu.org/software/autoconf-archive/ax_c_float_words_bigendian.html
# ===============================================================================
#
# SYNOPSIS
#
#   AX_C_FLOAT_WORDS_BIGENDIAN([ACTION-IF-TRUE], [ACTION-IF-FALSE], [ACTION-IF-UNKNOWN])
#
# DESCRIPTION
#
#   Checks the ordering of words within a multi-word float. This check is
#   necessary because on some systems (e.g. certain ARM systems), the float
#   word ordering can be different from the byte ordering. In a multi-word
#   float context, "big-endian" implies that the word containing the sign
#   bit is found in the memory location with the lowest address. This
#   implementation was inspired by the AC_C_BIGENDIAN macro in autoconf.
#
#   The endianness is detected by first compiling C code that contains a
#   special double float value, then grepping the resulting object file for
#   certain strings of ASCII values. The double is specially crafted to have
#   a binary representation that corresponds with a simple string. In this
#   implementation, the string "noonsees" was selected because the
#   individual word values ("noon" and "sees") are palindromes, thus making
#   this test byte-order agnostic. If grep finds the string "noonsees" in
#   the object file, the target platform stores float words in big-endian
#   order. If grep finds "seesnoon", float words are in little-endian order.
#   If neither value is found, the user is instructed to specify the
#   ordering.
#
#   Early versions of this macro (i.e., before serial 12) would not work
#   when interprocedural optimization (via link-time optimization) was
#   enabled. This would happen when, say, the GCC/clang "-flto" flag, or the
#   ICC "-ipo" flag was used, for example. The problem was that under these
#   conditions, the compiler did not allocate for and write the special
#   float value in the data segment of the object file, since doing so might
#   not prove optimal once more context was available. Thus, the special
#   value (in platform-dependent binary form) could not be found in the
#   object file, and the macro would fail.
#
#   The solution to the above problem was to:
#
#     1) Compile and link a whole test program rather than just compile an
#        object file. This ensures that we reach the point where even an
#        interprocedural optimizing compiler writes values to the data segment.
#
#     2) Add code that requires the compiler to write the special value to
#        the data segment, as opposed to "optimizing away" the variable's
#        allocation. This could be done via compiler keywords or options, but
#        it's tricky to make this work for all versions of all compilers with
#        all optimization settings. The chosen solution was to make the exit
#        code of the test program depend on the storing of the special value
#        in memory (in the data segment). Because the exit code can be
#        verified, any compiler that aspires to be correct will produce a
#        program binary that contains the value, which the macro can then find.
#
#   How does the exit code depend on the special value residing in memory?
#   Memory, unlike variables and registers, can be addressed indirectly at
#   run time. The exit code of this test program is a result of indirectly
#   reading and writing to the memory region where the special value is
#   supposed to reside. The actual memory addresses used and the values to
#   be written are derived from the the program input ("argv") and are
#   therefore not known at compile or link time. The compiler has no choice
#   but to defer the computation to run time, and to prepare by allocating
#   and populating the data segment with the special value. For further
#   details, refer to the source code of the test program.
#
#   Note that the test program is never meant to be run. It only exists to
#   host a double float value in a given platform's binary format. Thus,
#   error handling is not included.
#
# LICENSE
#
#   Copyright (c) 2008, 2023 Daniel Amelang <dan@amelang.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 13

AC_DEFUN([AX_C_FLOAT_WORDS_BIGENDIAN],
  [AC_CACHE_CHECK(whether float word ordering is bigendian,
                  ax_cv_c_float_words_bigendian, [

ax_cv_c_float_words_bigendian=unknown
AC_LINK_IFELSE([AC_LANG_SOURCE([[

#include <stdlib.h>

static double m[] = {9.090423496703681e+223, 0.0};

int main (int argc, char *argv[])
{
    m[atoi (argv[1])] += atof (argv[2]);
    return m[atoi (argv[3])] > 0.0;
}

]])], [

if grep noonsees conftest$EXEEXT >/dev/null ; then
  ax_cv_c_float_words_bigendian=yes
fi
if grep seesnoon conftest$EXEEXT >/dev/null ; then
  if test "$ax_cv_c_float_words_bigendian" = unknown; then
    ax_cv_c_float_words_bigendian=no
  else
    ax_cv_c_float_words_bigendian=unknown
  fi
fi

])])

case $ax_cv_c_float_words_bigendian in
  yes)
    m4_default([$1],
      [AC_DEFINE([FLOAT_WORDS_BIGENDIAN], 1,
                 [Define to 1 if your system stores words within floats
                  with the most significant word first])]) ;;
  no)
    $2 ;;
  *)
    m4_default([$3],
      [AC_MSG_ERROR([

Unknown float word ordering. You need to manually preset
ax_cv_c_float_words_bigendian=no (or yes) according to your system.

    ])]) ;;
esac

])# AX_C_FLOAT_WORDS_BIGENDIAN
