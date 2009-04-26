# ===========================================================================
#            http://autoconf-archive.cryp.to/acltx_texmf_path.html
# ===========================================================================
#
# SYNOPSIS
#
#   ACLTX_TEXMF_PATH
#
# DESCRIPTION
#
#   This macros find a suitable path for the local texmf folder. It this
#   possible to set manually this path using texmfpath=... The variable
#   texmfpath contains the path found or. If configure is unable to locate
#   the path, configure exit with a error message.
#
# LICENSE
#
#   Copyright (c) 2008 Boretti Mathieu <boretti@eig.unige.ch>
#
#   This library is free software; you can redistribute it and/or modify it
#   under the terms of the GNU Lesser General Public License as published by
#   the Free Software Foundation; either version 2.1 of the License, or (at
#   your option) any later version.
#
#   This library is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
#   General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public License
#   along with this library. If not, see <http://www.gnu.org/licenses/>.

AC_DEFUN([ACLTX_TEXMF_PATH],[
AC_ARG_VAR(texmfpath,[specify default local texmf path (for example /usr/TeX/texmf-local/)])
AC_REQUIRE([ACLTX_PROG_LATEX])
AC_REQUIRE([AC_PROG_AWK])
AC_REQUIRE([ACLTX_CLASS_REPORT])
AC_CACHE_CHECK([for texmf local path],[ac_cv_texmfpath_value],[
if test "$ac_cv_env_texmfpath_set" = "set" ; then
    ac_cv_texmfpath_value="$ac_cv_env_texmfpath_value" ; export ac_cv_texmfpath_value;
else
    Base=`$kpsewhich report.cls` ; export Base ;
    Base=`echo $Base | $AWK -F / '{for(i=1;i<NF;i++) {if ($i=="texmf" || $i=="texmf-dist") break; OUT=OUT$i"/";} print OUT}'` ; export Base ;
    if test -x "$Base/texmf.local" ;
    then
        Base="$Base/texmf.local" ; export Base;
    else
        if test -x "$Base/texmf-local" ;
        then
            Base="$Base/texmf-local" ; export Base;
        else
            if test -x "$Base/texmf" ;
            then
                Base="$Base/texmf" ; export Base;
            else
                Base="no"; export Base;
            fi;
        fi;
    fi;
    ac_cv_texmfpath_value="$Base" ; export ac_cv_texmfpath_value;
fi
])
texmfpath=$ac_cv_texmfpath_value ; export texmfpath_value;
if test "$texmfpath" = "no" ;
then
    AC_MSG_ERROR([Unable to find a suitable local texmf folder. Use texmfpath=... to specify it])
fi
AC_SUBST(texmfpath)
])
