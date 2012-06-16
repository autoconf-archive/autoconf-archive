# ===========================================================================
#        http://www.gnu.org/software/autoconf-archive/ax_have_qt.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_HAVE_QT [--with-Qt-dir=DIR] [--with-Qt-lib-dir=DIR] [--with-Qt-lib=LIB]
#   AX_HAVE_QT [--with-Qt-include-dir=DIR] [--with-Qt-bin-dir=DIR] [--with-Qt-lib-dir=DIR] [--with-Qt-lib=LIB]
#
# DESCRIPTION
#
#   Searches common directories for Qt include files, libraries and Qt
#   binary utilities. The macro supports several different versions of the
#   Qt framework being installed on the same machine. Without options, the
#   macro is designed to look for the latest library, i.e., the highest
#   definition of QT_VERSION in qglobal.h. By use of one or more options a
#   different library may be selected. There are two different sets of
#   options. Both sets contain the option --with-Qt-lib=LIB which can be
#   used to force the use of a particular version of the library file when
#   more than one are available. LIB must be in the form as it would appear
#   behind the "-l" option to the compiler. Examples for LIB would be
#   "qt-mt" for the multi-threaded version and "qt" for the regular version.
#   In addition to this, the first set consists of an option
#   --with-Qt-dir=DIR which can be used when the installation conforms to
#   Trolltech's standard installation, which means that header files are in
#   DIR/include, binary utilities are in DIR/bin and the library is in
#   DIR/lib. The second set of options can be used to indicate individual
#   locations for the header files, the binary utilities and the library
#   file, in addition to the specific version of the library file.
#
#   The following shell variable is set to either "yes" or "no":
#
#     have_qt
#
#   Additionally, the following variables are exported:
#
#     QT_CXXFLAGS
#     QT_LIBS
#     QT_MOC
#     QT_UIC
#     QT_LRELEASE
#     QT_LUPDATE
#     QT_DIR
#
#   which respectively contain an "-I" flag pointing to the Qt include
#   directory (and "-DQT_THREAD_SUPPORT" when LIB is "qt-mt"), link flags
#   necessary to link with Qt and X, the name of the meta object compiler
#   and the user interface compiler both with full path, and finaly the
#   variable QTDIR as Trolltech likes to see it defined (if possible).
#
#   Example lines for Makefile.in:
#
#     CXXFLAGS = @QT_CXXFLAGS@
#     MOC      = @QT_MOC@
#
#   After the variables have been set, a trial compile and link is performed
#   to check the correct functioning of the meta object compiler. This test
#   may fail when the different detected elements stem from different
#   releases of the Qt framework. In that case, an error message is emitted
#   and configure stops.
#
#   No common variables such as $LIBS or $CFLAGS are polluted.
#
#   Options:
#
#   --with-Qt-dir=DIR: DIR is equal to $QTDIR if you have followed the
#   installation instructions of Trolltech. Header files are in DIR/include,
#   binary utilities are in DIR/bin and the library is in DIR/lib.
#
#   --with-Qt-include-dir=DIR: Qt header files are in DIR.
#
#   --with-Qt-bin-dir=DIR: Qt utilities such as moc and uic are in DIR.
#
#   --with-Qt-lib-dir=DIR: The Qt library is in DIR.
#
#   --with-Qt-lib=LIB: Use -lLIB to link with the Qt library.
#
#   If some option "=no" or, equivalently, a --without-Qt-* version is given
#   in stead of a --with-Qt-*, "have_qt" is set to "no" and the other
#   variables are set to the empty string.
#
# LICENSE
#
#   Copyright (c) 2008 Bastiaan Veelo <Bastiaan@Veelo.net>
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 10

dnl Calls AX_PATH_QT_DIRECT (contained in this file) as a subroutine.
AU_ALIAS([BNV_HAVE_QT], [AX_HAVE_QT])
AC_DEFUN([AX_HAVE_QT],
[
  AC_REQUIRE([AC_PROG_CXX])
  AC_REQUIRE([AC_PATH_X])
  AC_REQUIRE([AC_PATH_XTRA])

  AC_MSG_CHECKING(for Qt)

  AC_ARG_WITH([Qt-dir],
              AS_HELP_STRING([--with-Qt-dir=DIR],
                             [DIR is equal to $QTDIR if you have followed the
                              installation instructions of Trolltech. Header
                              files are in DIR/include, binary utilities are
                              in DIR/bin. The library is in DIR/lib, unless
                              --with-Qt-lib-dir is also set.]))
  AC_ARG_WITH([Qt-include-dir],
              AS_HELP_STRING([--with-Qt-include-dir=DIR],
                             [Qt header files are in DIR]))
  AC_ARG_WITH([Qt-bin-dir],
              AS_HELP_STRING([--with-Qt-bin-dir=DIR],
                             [Qt utilities such as moc and uic are in DIR]))
  AC_ARG_WITH([Qt-lib-dir],
              AS_HELP_STRING([--with-Qt-lib-dir=DIR],
                             [The Qt library is in DIR]))
  AC_ARG_WITH([Qt-lib],
              AS_HELP_STRING([--with-Qt-lib=LIB],
                             [Use -lLIB to link with the Qt library]))
  if test x"$with_Qt_dir" = x"no" ||
     test x"$with_Qt_include-dir" = x"no" ||
     test x"$with_Qt_bin_dir" = x"no" ||
     test x"$with_Qt_lib_dir" = x"no" ||
     test x"$with_Qt_lib" = x"no"; then
    # user disabled Qt. Leave cache alone.
    have_qt="User disabled Qt."
  else
    # "yes" is a bogus option
    if test x"$with_Qt_dir" = xyes; then
      with_Qt_dir=
    fi
    if test x"$with_Qt_include_dir" = xyes; then
      with_Qt_include_dir=
    fi
    if test x"$with_Qt_bin_dir" = xyes; then
      with_Qt_bin_dir=
    fi
    if test x"$with_Qt_lib_dir" = xyes; then
      with_Qt_lib_dir=
    fi
    if test x"$with_Qt_lib" = xyes; then
      with_Qt_lib=
    fi
    # No Qt unless we discover otherwise
    have_qt=no
    # Check whether we are requested to link with a specific version
    if test x"$with_Qt_lib" != x; then
      ax_qt_lib="$with_Qt_lib"
    fi
    # Check whether we were supplied with an answer already
    if test x"$with_Qt_dir" != x; then
      have_qt=yes
      ax_qt_dir="$with_Qt_dir"
      ax_qt_include_dir="$with_Qt_dir/include"
      ax_qt_bin_dir="$with_Qt_dir/bin"
      ax_qt_lib_dir="$with_Qt_dir/lib"
      # Only search for the lib if the user did not define one already
      if test x"$ax_qt_lib" = x; then
        ax_qt_lib="`ls $ax_qt_lib_dir/libqt* | sed -n 1p |
                     sed s@$ax_qt_lib_dir/lib@@ | [sed s@[.].*@@]`"
      fi
      ax_qt_LIBS="-L$ax_qt_lib_dir -l$ax_qt_lib $X_PRE_LIBS $X_LIBS -lX11 -lXext -lXmu -lXt -lXi $X_EXTRA_LIBS"
    else
      # Use cached value or do search, starting with suggestions from
      # the command line
      AC_CACHE_VAL(ax_cv_have_qt,
      [
        # We are not given a solution and there is no cached value.
        ax_qt_dir=NO
        ax_qt_include_dir=NO
        ax_qt_lib_dir=NO
        if test x"$ax_qt_lib" = x; then
          ax_qt_lib=NO
        fi
        AX_PATH_QT_DIRECT
        if test "$ax_qt_dir" = NO ||
           test "$ax_qt_include_dir" = NO ||
           test "$ax_qt_lib_dir" = NO ||
           test "$ax_qt_lib" = NO; then
          # Problem with finding complete Qt.  Cache the known absence of Qt.
          ax_cv_have_qt="have_qt=no"
        else
          # Record where we found Qt for the cache.
          ax_cv_have_qt="have_qt=yes                  \
                       ax_qt_dir=$ax_qt_dir          \
               ax_qt_include_dir=$ax_qt_include_dir  \
                   ax_qt_bin_dir=$ax_qt_bin_dir      \
                      ax_qt_LIBS=\"$ax_qt_LIBS\""
        fi
      ])dnl
      eval "$ax_cv_have_qt"
    fi # all $ax_qt_* are set
  fi   # $have_qt reflects the system status
  if test x"$have_qt" = xyes; then
    QT_CXXFLAGS="-I$ax_qt_include_dir"
    if test x"$ax_qt_lib" = xqt-mt; then
        QT_CXXFLAGS="$QT_CXXFLAGS -DQT_THREAD_SUPPORT"
    fi
    QT_DIR="$ax_qt_dir"
    QT_LIBS="$ax_qt_LIBS"
    # If ax_qt_dir is defined, utilities are expected to be in the
    # bin subdirectory
    if test x"$ax_qt_dir" != x; then
        if test -x "$ax_qt_dir/bin/uic"; then
          QT_UIC="$ax_qt_dir/bin/uic"
        else
          # Old versions of Qt don't have uic
          QT_UIC=
        fi
      QT_MOC="$ax_qt_dir/bin/moc"
      QT_LRELEASE="$ax_qt_dir/bin/lrelease"
      QT_LUPDATE="$ax_qt_dir/bin/lupdate"
    else
      # Or maybe we are told where to look for the utilities
      if test x"$ax_qt_bin_dir" != x; then
        if test -x "$ax_qt_bin_dir/uic"; then
          QT_UIC="$ax_qt_bin_dir/uic"
        else
          # Old versions of Qt don't have uic
          QT_UIC=
        fi
        QT_MOC="$ax_qt_bin_dir/moc"
        QT_LRELEASE="$ax_qt_bin_dir/lrelease"
        QT_LUPDATE="$ax_qt_bin_dir/lupdate"
      else
      # Last possibility is that they are in $PATH
        QT_UIC="`which uic`"
        QT_MOC="`which moc`"
        QT_LRELEASE="`which lrelease`"
        QT_LUPDATE="`which lupdate`"
      fi
    fi
    # All variables are defined, report the result
    AC_MSG_RESULT([$have_qt:
    QT_CXXFLAGS=$QT_CXXFLAGS
    QT_DIR=$QT_DIR
    QT_LIBS=$QT_LIBS
    QT_UIC=$QT_UIC
    QT_MOC=$QT_MOC
    QT_LRELEASE=$QT_LRELEASE
    QT_LUPDATE=$QT_LUPDATE])
  else
    # Qt was not found
    QT_CXXFLAGS=
    QT_DIR=
    QT_LIBS=
    QT_UIC=
    QT_MOC=
    QT_LRELEASE=
    QT_LUPDATE=
    AC_MSG_RESULT($have_qt)
  fi
  AC_SUBST(QT_CXXFLAGS)
  AC_SUBST(QT_DIR)
  AC_SUBST(QT_LIBS)
  AC_SUBST(QT_UIC)
  AC_SUBST(QT_MOC)
  AC_SUBST(QT_LRELEASE)
  AC_SUBST(QT_LUPDATE)

  #### Being paranoid:
  if test x"$have_qt" = xyes; then
    AC_MSG_CHECKING(correct functioning of Qt installation)
    AC_CACHE_VAL(ax_cv_qt_test_result,
    [
      cat > ax_qt_test.h << EOF
#include <qobject.h>
class Test : public QObject
{
Q_OBJECT
public:
  Test() {}
  ~Test() {}
public slots:
  void receive() {}
signals:
  void send();
};
EOF

      cat > ax_qt_main.$ac_ext << EOF
#include "ax_qt_test.h"
#include <qapplication.h>
int main( int argc, char **argv )
{
  QApplication app( argc, argv );
  Test t;
  QObject::connect( &t, SIGNAL(send()), &t, SLOT(receive()) );
}
EOF

      ax_cv_qt_test_result="failure"
      ax_try_1="$QT_MOC ax_qt_test.h -o moc_ax_qt_test.$ac_ext >/dev/null 2>/dev/null"
      AC_TRY_EVAL(ax_try_1)
      if test x"$ac_status" != x0; then
        echo "$ax_err_1" >&AS_MESSAGE_LOG_FD
        echo "configure: could not run $QT_MOC on:" >&AS_MESSAGE_LOG_FD
        cat ax_qt_test.h >&AS_MESSAGE_LOG_FD
      else
        ax_try_2="$CXX $QT_CXXFLAGS -c $CXXFLAGS -o moc_ax_qt_test.o moc_ax_qt_test.$ac_ext >/dev/null 2>/dev/null"
        AC_TRY_EVAL(ax_try_2)
        if test x"$ac_status" != x0; then
          echo "$ax_err_2" >&AS_MESSAGE_LOG_FD
          echo "configure: could not compile:" >&AS_MESSAGE_LOG_FD
          cat moc_ax_qt_test.$ac_ext >&AS_MESSAGE_LOG_FD
        else
          ax_try_3="$CXX $QT_CXXFLAGS -c $CXXFLAGS -o ax_qt_main.o ax_qt_main.$ac_ext >/dev/null 2>/dev/null"
          AC_TRY_EVAL(ax_try_3)
          if test x"$ac_status" != x0; then
            echo "$ax_err_3" >&AS_MESSAGE_LOG_FD
            echo "configure: could not compile:" >&AS_MESSAGE_LOG_FD
            cat ax_qt_main.$ac_ext >&AS_MESSAGE_LOG_FD
          else
            ax_try_4="$CXX -o ax_qt_main ax_qt_main.o moc_ax_qt_test.o $QT_LIBS $LIBS >/dev/null 2>/dev/null"
            AC_TRY_EVAL(ax_try_4)
            if test x"$ac_status" != x0; then
              echo "$ax_err_4" >&AS_MESSAGE_LOG_FD
            else
              ax_cv_qt_test_result="success"
            fi
          fi
        fi
      fi
    ])dnl AC_CACHE_VAL ax_cv_qt_test_result
    AC_MSG_RESULT([$ax_cv_qt_test_result])
    if test x"$ax_cv_qt_test_result" = "xfailure"; then
      AC_MSG_ERROR([Failed to find matching components of a complete
                  Qt installation. Try using more options,
                  see ./configure --help.])
    fi

    rm -f ax_qt_test.h moc_ax_qt_test.$ac_ext moc_ax_qt_test.o \
          ax_qt_main.$ac_ext ax_qt_main.o ax_qt_main
  fi
])

dnl Internal subroutine of AX_HAVE_QT
dnl Set ax_qt_dir ax_qt_include_dir ax_qt_bin_dir ax_qt_lib_dir ax_qt_lib
AC_DEFUN([AX_PATH_QT_DIRECT],
[
  ## Binary utilities ##
  if test x"$with_Qt_bin_dir" != x; then
    ax_qt_bin_dir=$with_Qt_bin_dir
  fi
  ## Look for header files ##
  if test x"$with_Qt_include_dir" != x; then
    ax_qt_include_dir="$with_Qt_include_dir"
  else
    # The following header file is expected to define QT_VERSION.
    qt_direct_test_header=qglobal.h
    # Look for the header file in a standard set of common directories.
    ax_include_path_list="
      /usr/include
      `ls -dr ${QTDIR}/include 2>/dev/null`
      `ls -dr /usr/include/qt* 2>/dev/null`
      `ls -dr /usr/lib/qt*/include 2>/dev/null`
      `ls -dr /usr/local/qt*/include 2>/dev/null`
      `ls -dr /opt/qt*/include 2>/dev/null`
      `ls -dr /Developer/qt*/include 2>/dev/null`
    "
    for ax_dir in $ax_include_path_list; do
      if test -r "$ax_dir/$qt_direct_test_header"; then
        ax_dirs="$ax_dirs $ax_dir"
      fi
    done
    # Now look for the newest in this list
    ax_prev_ver=0
    for ax_dir in $ax_dirs; do
      ax_this_ver=`egrep -w '#define QT_VERSION' $ax_dir/$qt_direct_test_header | sed s/'#define QT_VERSION'//`
      if expr $ax_this_ver '>' $ax_prev_ver > /dev/null; then
        ax_qt_include_dir=$ax_dir
        ax_prev_ver=$ax_this_ver
      fi
    done
  fi dnl Found header files.

  # Are these headers located in a traditional Trolltech installation?
  # That would be $ax_qt_include_dir stripped from its last element:
  ax_possible_qt_dir=`dirname $ax_qt_include_dir`
  if (test -x $ax_possible_qt_dir/bin/moc) &&
     ((ls $ax_possible_qt_dir/lib/libqt* > /dev/null 2>/dev/null) ||
      (ls $ax_possible_qt_dir/lib64/libqt* > /dev/null 2>/dev/null)); then
    # Then the rest is a piece of cake
    ax_qt_dir=$ax_possible_qt_dir
    ax_qt_bin_dir="$ax_qt_dir/bin"
    if test x"$with_Qt_lib_dir" != x; then
      ax_qt_lib_dir="$with_Qt_lib_dir"
    else
      if (test -d $ax_qt_dir/lib64); then
	ax_qt_lib_dir="$ax_qt_dir/lib64"
      else
	ax_qt_lib_dir="$ax_qt_dir/lib"
      fi
    fi
    # Only look for lib if the user did not supply it already
    if test x"$ax_qt_lib" = xNO; then
      ax_qt_lib="`ls $ax_qt_lib_dir/libqt* | sed -n 1p |
                   sed s@$ax_qt_lib_dir/lib@@ | [sed s@[.].*@@]`"
    fi
    ax_qt_LIBS="-L$ax_qt_lib_dir -l$ax_qt_lib $X_PRE_LIBS $X_LIBS -lX11 -lXext -lXmu -lXt -lXi $X_EXTRA_LIBS"
  else
    # There is no valid definition for $QTDIR as Trolltech likes to see it
    ax_qt_dir=
    ## Look for Qt library ##
    if test x"$with_Qt_lib_dir" != x; then
      ax_qt_lib_dir="$with_Qt_lib_dir"
      # Only look for lib if the user did not supply it already
      if test x"$ax_qt_lib" = xNO; then
        ax_qt_lib="`ls $ax_qt_lib_dir/libqt* | sed -n 1p |
                     sed s@$ax_qt_lib_dir/lib@@ | [sed s@[.].*@@]`"
      fi
      ax_qt_LIBS="-L$ax_qt_lib_dir -l$ax_qt_lib $X_PRE_LIBS $X_LIBS -lX11 -lXext -lXmu -lXt -lXi $X_EXTRA_LIBS"
    else
      # Normally, when there is no traditional Trolltech installation,
      # the library is installed in a place where the linker finds it
      # automatically.
      # If the user did not define the library name, try with qt
      if test x"$ax_qt_lib" = xNO; then
        ax_qt_lib=qt
      fi
      qt_direct_test_header=qapplication.h
      qt_direct_test_main="
        int argc;
        char ** argv;
        QApplication app(argc,argv);
      "
      # See if we find the library without any special options.
      # Don't add top $LIBS permanently yet
      ax_save_LIBS="$LIBS"
      LIBS="-l$ax_qt_lib $X_PRE_LIBS $X_LIBS -lX11 -lXext -lXmu -lXt -lXi $X_EXTRA_LIBS"
      ax_qt_LIBS="$LIBS"
      ax_save_CXXFLAGS="$CXXFLAGS"
      CXXFLAGS="-I$ax_qt_include_dir"
      AC_TRY_LINK([#include <$qt_direct_test_header>],
        $qt_direct_test_main,
      [
        # Success.
        # We can link with no special library directory.
        ax_qt_lib_dir=
      ], [
        # That did not work. Try the multi-threaded version
        echo "Non-critical error, please neglect the above." >&AS_MESSAGE_LOG_FD
        ax_qt_lib=qt-mt
        LIBS="-l$ax_qt_lib $X_PRE_LIBS $X_LIBS -lX11 -lXext -lXmu -lXt -lXi $X_EXTRA_LIBS"
        AC_TRY_LINK([#include <$qt_direct_test_header>],
          $qt_direct_test_main,
        [
          # Success.
          # We can link with no special library directory.
          ax_qt_lib_dir=
        ], [
          # That did not work. Try the OpenGL version
          echo "Non-critical error, please neglect the above." >&AS_MESSAGE_LOG_FD
          ax_qt_lib=qt-gl
          LIBS="-l$ax_qt_lib $X_PRE_LIBS $X_LIBS -lX11 -lXext -lXmu -lXt -lXi $X_EXTRA_LIBS"
          AC_TRY_LINK([#include <$qt_direct_test_header>],
            $qt_direct_test_main,
          [
            # Success.
            # We can link with no special library directory.
            ax_qt_lib_dir=
          ], [
            # That did not work. Maybe a library version I don't know about?
            echo "Non-critical error, please neglect the above." >&AS_MESSAGE_LOG_FD
            # Look for some Qt lib in a standard set of common directories.
            ax_dir_list="
              `echo $ax_qt_includes | sed ss/includess`
              /lib
	      /usr/lib64
              /usr/lib
	      /usr/local/lib64
              /usr/local/lib
	      /opt/lib64
              /opt/lib
              `ls -dr /usr/lib64/qt* 2>/dev/null`
              `ls -dr /usr/lib64/qt*/lib64 2>/dev/null`
              `ls -dr /usr/lib/qt* 2>/dev/null`
              `ls -dr /usr/local/qt* 2>/dev/null`
              `ls -dr /opt/qt* 2>/dev/null`
            "
            for ax_dir in $ax_dir_list; do
              if ls $ax_dir/libqt* >/dev/null 2>/dev/null; then
                # Gamble that it's the first one...
                ax_qt_lib="`ls $ax_dir/libqt* | sed -n 1p |
                            sed s@$ax_dir/lib@@ | sed s/[[.]].*//`"
                ax_qt_lib_dir="$ax_dir"
                break
              fi
            done
            # Try with that one
            LIBS="-l$ax_qt_lib $X_PRE_LIBS $X_LIBS -lX11 -lXext -lXmu -lXt -lXi $X_EXTRA_LIBS"
            AC_TRY_LINK([#include <$qt_direct_test_header>],
              $qt_direct_test_main,
            [
              # Success.
              # We can link with no special library directory.
              ax_qt_lib_dir=
            ], [
             : # Leave ax_qt_lib_dir defined
            ])
          ])
        ])
      ])
      if test x"$ax_qt_lib_dir" != x; then
        ax_qt_LIBS="-L$ax_qt_lib_dir $LIBS"
      else
        ax_qt_LIBS="$LIBS"
      fi
      LIBS="$ax_save_LIBS"
      CXXFLAGS="$ax_save_CXXFLAGS"
    fi dnl $with_Qt_lib_dir was not given
  fi dnl Done setting up for non-traditional Trolltech installation
])
