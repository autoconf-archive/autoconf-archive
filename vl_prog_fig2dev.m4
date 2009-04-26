# ===========================================================================
#            http://autoconf-archive.cryp.to/vl_prog_fig2dev.html
# ===========================================================================
#
# SYNOPSIS
#
#   VL_PROG_FIG2DEV
#
# DESCRIPTION
#
#   If `fig2dev' is found, sets the output variable `FIG2DEV' to `fig2dev',
#   and `FIG2DEV_ESPLANG' to the graphics language which can be used to
#   produce Encapsulated PostScript. Older versions of `fig2dev' produce EPS
#   with `-Lps' and new versions with `-Leps', this macro finds out the
#   correct language option automatically.
#
# LICENSE
#
#   Copyright (c) 2008 Ville Laurikari <vl@iki.fi>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([VL_PROG_FIG2DEV], [
  AC_CHECK_PROG(FIG2DEV, fig2dev, fig2dev)
  if test "x$FIG2DEV" != "x"; then
    AC_CACHE_CHECK(how to produce EPS with fig2dev,
                   vl_cv_sys_fig2dev_epslang, [
      if "$FIG2DEV" -Leps /dev/null 2>&1 | grep Unknown > /dev/null; then
        vl_cv_sys_fig2dev_epslang=ps
      else
        vl_cv_sys_fig2dev_epslang=eps
      fi
    ])
    FIG2DEV_EPSLANG=$vl_cv_sys_fig2dev_epslang
    AC_SUBST(FIG2DEV_EPSLANG)
  fi
])
