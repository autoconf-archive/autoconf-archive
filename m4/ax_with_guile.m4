# ===========================================================================
#             http://autoconf-archive.cryp.to/ax_with_guile.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_WITH_GUILE([VALUE-IF-NOT-FOUND],[PATH])
#
# DESCRIPTION
#
#   Locates an installed Guile binary, placing the result in the precious
#   variable $GUILE. Accepts a present $GUILE, then --with-guile, and
#   failing that searches for guile in the given path (which defaults to the
#   system path). If guile is found, $GUILE is set to the full path of the
#   binary; if it is not found, $GUILE is set to VALUE-IF-NOT-FOUND, which
#   defaults to 'guile'.
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Francesco Salvestrini <salvestrini@users.sourceforge.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AX_WITH_GUILE],[
    AX_WITH_PROG(GUILE,guile)
])
