##### http://autoconf-archive.cryp.to/ac_subst_dir.html
#
# OBSOLETE MACRO
#
#   The macro AC_DEFINE_DIR provides this functionality directly now.
#
# SYNOPSIS
#
#   AC_SUBST_DIR(VARNAME, [DIR])
#
# DESCRIPTION
#
#   This macro substitutes (with AC_SUBST) VARNAME with the expansion
#   of itself or the DIR variable if specified, taking care of fixing
#   up ${prefix} and such.
#
#   Side effect: VARNAME is replaced with the expansion.
#
#   AC_SUBST_DIR bases on Alexandre Oliva's AC_DEFINE_DIR macro.
#
#   Examples:
#
#      AC_SUBST_DIR(DATADIR)
#
# LAST MODIFICATION
#
#   2005-07-29
#
# COPYLEFT
#
#   Copyright (c) 2005 Stepan Kasal <kasal@ucw.cz>
#   Copyright (c) 2005 Mathias Hasselmann <mathias.hasselmann@gmx.de>
#
#   Copying and distribution of this file, with or without
#   modification, are permitted in any medium without royalty provided
#   the copyright notice and this notice are preserved.

AC_DEFUN([AC_SUBST_DIR], [
        ifelse($2,,,$1="[$]$2")
        $1=`(
            test "x$prefix" = xNONE && prefix="$ac_default_prefix"
            test "x$exec_prefix" = xNONE && exec_prefix="${prefix}"
            eval $1=\""[$]$1"\"
            eval echo \""[$]$1"\"
        )`
        AC_SUBST($1)
])
