##### http://autoconf-archive.cryp.to/ac_latex_package_fontenc.html
#
# OBSOLETE MACRO
#
#   Replaced by ACLTX_PACKAGE_FONTENC.
#
# SYNOPSIS
#
#   AC_LATEX_PACKAGE_FONTENC
#
# DESCRIPTION
#
#   This macro test if \usepackage[T1]{fontenc} works. If yes it set
#   $fontenc="T1" else if \usepackage[OT1]{fontenc} works, set
#   $fontenc="OT1" else ERROR
#
# LAST MODIFICATION
#
#   2006-07-16
#
# COPYLEFT
#
#   Copyright (c) 2006 Mathieu Boretti <boretti@eig.unige.ch>
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful, but
#   WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
#   02111-1307, USA.
#
#   As a special exception, the respective Autoconf Macro's copyright
#   owner gives unlimited permission to copy, distribute and modify the
#   configure scripts that are the output of Autoconf when processing
#   the Macro. You need not follow the terms of the GNU General Public
#   License when using or distributing such scripts, even though
#   portions of the text of the Macro appear in them. The GNU General
#   Public License (GPL) does govern all other use of the material that
#   constitutes the Autoconf Macro.
#
#   This special exception to the GPL applies to versions of the
#   Autoconf Macro released by the Autoconf Macro Archive. When you
#   make and distribute a modified version of the Autoconf Macro, you
#   may extend this special exception to the GPL to apply to your
#   modified version as well.

define(_AC_LATEX_PACKAGE_FONTENC_INTERNE,[
changequote(*, !)dnl
\documentclass{book}
\usepackage[$1]{fontenc}
\begin{document}
\end{document}
changequote([, ])dnl

])

AC_DEFUN([AC_LATEX_PACKAGE_FONTENC],[
    AC_LATEX_CLASS_BOOK
    AC_CACHE_CHECK([for fontenc],[ac_cv_latex_package_fontenc_opt],[
        _AC_LATEX_TEST([_AC_LATEX_PACKAGE_FONTENC_INTERNE(T1)],[ac_cv_latex_package_fontenc_opt])
        if test $ac_cv_latex_package_fontenc_opt = "yes" ;
        then
            ac_cv_latex_package_fontenc_opt="T1"; export ac_cv_latex_package_fontenc_opt;
        else
            _AC_LATEX_TEST([_AC_LATEX_PACKAGE_FONTENC_INTERNE(OT1)],[ac_cv_latex_package_fontenc_opt])
            if test $ac_cv_latex_package_fontenc_opt = "yes" ;
            then
                ac_cv_latex_package_fontenc_opt="OT1"; export ac_cv_latex_package_fontenc_opt;
            fi
        fi

    ])
    if test $ac_cv_latex_package_fontenc_opt = "no" ;
    then
        AC_MSG_ERROR([Unable to use fontenc with T1 nor OT1])
    fi
    fontenc=$ac_cv_latex_package_fontenc_opt ; export fontenc ;
    AC_SUBST(fontenc)
])
