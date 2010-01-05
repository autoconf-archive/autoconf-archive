# ===========================================================================
#          http://www.nongnu.org/autoconf-archive/ax_with_ruby.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_WITH_RUBY([VALUE-IF-NOT-FOUND],[PATH])
#
# DESCRIPTION
#
#   Locates an installed Ruby binary, placing the result in the precious
#   variable $RUBY. Accepts a present $RUBY, then --with-ruby, and failing
#   that searches for ruby in the given path (which defaults to the system
#   path). If ruby is found, $RUBY is set to the full path of the binary; if
#   it is not found $RUBY is set to VALUE-IF-NOT-FOUND if provided,
#   unchanged otherwise.
#
#   A typical use could be the following one:
#
#     AX_WITH_RUBY
#
# LICENSE
#
#   Copyright (c) 2008 Francesco Salvestrini <salvestrini@users.sourceforge.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

AC_DEFUN([AX_WITH_RUBY],[
    AX_WITH_PROG(RUBY,ruby,$1,$2)
])
