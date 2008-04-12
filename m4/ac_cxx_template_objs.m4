# ===========================================================================
#          http://autoconf-archive.cryp.to/ac_cxx_template_objs.html
# ===========================================================================
#
# OBSOLETE MACRO
#
#   Unnecessary with recent versions of libtool.
#
# SYNOPSIS
#
#   AC_CXX_TEMPLATE_OBJS
#
# DESCRIPTION
#
#   NOTE: AC_CXX_TEMPLATE_OBJS macro is not needed anymore, recent versions
#   of libtool handle correctly these extra object files by recognizing the
#   SUN compiler "CC" and using it with the "-xar" switch to pack libraries
#   instead of using the more classical "ar" command. Using recent libtool
#   with the SUN compiler AND this macro does not work at all.
#
#   This macro tries to find the place where the objects files resulting
#   from templates instantiations are stored and the associated compiler
#   flags. This is particularly useful to include these files in libraries.
#   Currently only g++/egcs and SUN CC are supported (there is nothing to be
#   done for the formers while the latter uses directory ./Templates.DB if
#   you use the -ptr. flag). This macro sets the CXXFLAGS if needed, it also
#   sets the output variable TEMPLATES_OBJ. Note that if you use libtool,
#   this macro does work correctly with the SUN compilers ONLY while
#   building static libraries. Since there are sometimes problems with
#   exception handling with multiple levels of shared libraries even with
#   g++ on this platform, you may wish to enforce the usage of static
#   libraires there. You can do this by putting the following statements in
#   your configure.in file:
#
#      AC_CANONICAL_HOST
#      case x$host_os in
#        xsolaris*) AC_DISABLE_SHARED ;;
#      esac
#      AM_PROG_LIBTOOL
#
# LAST MODIFICATION
#
#   2008-04-12
#
# COPYLEFT
#
#   Copyright (c) 2008 Luc Maisonobe <luc@spaceroots.org>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved.

AC_DEFUN([AC_CXX_TEMPLATE_OBJS],
dnl
dnl This macro is OBSOLETE; do not use.
dnl
[AC_CACHE_CHECK(where template objects are stored, ac_cv_cxx_templobjs,
 [ ac_cv_cxx_templobjs='unknown'
   if test "$GXX" = yes; then
     ac_cv_cxx_templobjs='nowhere'
   else
     case $CXX in
       CC|*/CC)
        cat > conftest.cc <<EOF
template<class T> class A { public : A () {} };
template<class T> void f (const A<T>&) {}
main()
{ A<double> d;
  A<int> i;
  f (d);
  f (i);
  return 0;
}
EOF
        if test "$ac_cv_cxx_templobjs" = 'unknown' ; then
          if test -d Templates.DB ; then
            rm -fr Templates.DB
          fi
          if $CXX $CXXFLAGS -ptr. -c conftest.cc 1> /dev/null 2>&1; then
            if test -d Templates.DB ; then
#             this should be Sun CC <= 4.2
              CXXFLAGS="$CXXFLAGS -ptr."
              if test x"$LIBTOOL" = x ; then
                ac_cv_cxx_templobjs='Templates.DB/*.o'
              else
                ac_cv_cxx_templobjs='Templates.DB/*.lo'
              fi
              rm -fr Templates.DB
            fi
          fi
        fi
        if test "$ac_cv_cxx_templobjs" = 'unknown' ; then
          if test -d SunWS_cache ; then
            rm -fr SunWS_cache
          fi
          if $CXX $CXXFLAGS -c conftest.cc 1> /dev/null 2>&1; then
            if test -d SunWS_cache ; then
#             this should be Sun WorkShop C++ compiler 5.x
#             or Sun Forte C++ compiler >= 6.x
              if test x"$LIBTOOL" = x ; then
                ac_cv_cxx_templobjs='SunWS_cache/*/*.o'
              else
                ac_cv_cxx_templobjs='SunWS_cache/*/*.lo'
              fi
              rm -fr SunWS_cache
            fi
          fi
        fi
        rm -f conftest* ;;
     esac
   fi
   case "x$ac_cv_cxx_templobjs" in
     xunknown|xnowhere)
     TEMPLATE_OBJS="" ;;
     *)
     TEMPLATE_OBJS="$ac_cv_cxx_templobjs" ;;
   esac
   AC_SUBST(TEMPLATE_OBJS)])])
