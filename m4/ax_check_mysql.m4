# ===========================================================================
#      http://www.gnu.org/software/autoconf-archive/ax_check_mysql.html
# ===========================================================================
#
# SYNOPSIS
#
#   AX_CHECK_MYSQL([MYSQL-PLUGIN-NEEDED],[MYSQL-REQUIRED],[MINIMUM-VERSION],[INCLUDES-REQUIRED])
#   AX_SOURCE_MYSQL()
#   AX_CHECK_MYSQL_INSTALL([ROOT-DIR],[IF-FOUND],[IF-NOT-FOUND])
#
# DESCRIPTION
#
#   Looks for a MySQL installation in typical locations, or can take in a
#   flag designating where a MySQL installation is found. Sets the variables
#   stated to various attributes of the desired MySQL installation.
#
#   In detail, AX_CHECK_MYSQL will automatically look for a MySQL
#   installation in the directories that a mysql source or binary install
#   typically install to. AX_CHECK_MYSQL will throw an error if it can not
#   find one, and it is required.
#
#   AX_CHECK_MYSQL can also check for specific variables passed regarding a
#   location of a MySQL installation.
#
#   If a MySQL installation is found, AX_CHECK_MYSQL sets variables
#   regarding the version of MySQL, its architecture (32 or 64 bit), and
#   wether the version supports Plugins.
#
#   AX_CHECK_MYSQL adds the following flags:
#
#     --with-mysql, for the root of a desired MySQL installation
#     --with-mysql-plugin, for the path to the plugin directory of the MySQL installation
#     --with-mysql-include, for the path to the include directory of the MySQL installation
#     --with-mysql-bin, for the path to the binary directory of the MySQL installation
#     --with-mysql-source, for the path to a directory containing the source of the MySQL installation
#
#   AX_CHECK_MYSQL sets:
#
#     MYSQL to indicate whether MySQL was found or not
#     MYSQL_INCLUDES to the include directory (if one exists)
#     MYSQL_PLUGINS  to the plugin directory
#     MYSQL_COMMANDS  to the mysql executable directory
#     MYSQL_ARCHITECTURE to whether MySQL is 32 or 64 bit (32 if 32, 64 if 64)
#     MYSQL_VERSION to what the MySQL version is (5.1,5.5, etc)
#     MYSQL_PLUGIN_OK to whether MySQL version supports plugins (5.1 or greater)
#     MYSQL_55 to whether the version of MySQL is 5.5 or greater
#     MYSQL_SOURCE  to the source directory passed by --with-mysql-source
#
# LICENSE
#
#   Copyright (c) 2011 University of Washington
#   Copyright (c) 2011 Yusuke Tsutsumi <tsutsumi.yusuke@gmail.com>
#   Copyright (c) 2011 Craig Stimmel <cstimmel@uw.edu>
#   Copyright (c) 2011 Eric Wu
#
#   Copying and distribution of this file, with or without modification, are
#   permitted in any medium without royalty provided the copyright notice
#   and this notice are preserved. This file is offered as-is, without any
#   warranty.

#serial 1

AC_ARG_WITH(mysql,AS_HELP_STRING([--with-mysql],[root of the MySQL installation]))
AC_ARG_WITH(mysql_plugin,AS_HELP_STRING([--with-mysql-plugin],[path to the MySQL installation plugin directory]))
AC_ARG_WITH(mysql_include,AS_HELP_STRING([--with-mysql-include],[path to the MySQL installation include directory]))
AC_ARG_WITH(mysql_bin,AS_HELP_STRING([--with-mysql-bin],[path to the MySQL executables directory]))
AC_ARG_WITH(mysql_source,AS_HELP_STRING([--with-mysql-source],[path to MySQL source files]))

AC_DEFUN([AX_CHECK_MYSQL_INSTALL],[

    #Define variables passed
    ROOT_DIR="$1"

    # Check for include directory
    AC_CHECK_HEADER($ROOT_DIR/include/mysql/mysql_version.h,mysql_include_test="$ROOT_DIR/include/mysql",mysql_include_test="no")
    if test "$mysql_include_test" == "no"
    then
        AC_CHECK_HEADER($ROOT_DIR/include/mysql_version.h,mysql_include_test="$ROOT_DIR/include",mysql_include_test="no")
    fi
    AC_CHECK_FILE($ROOT_DIR/lib/mysql/plugin/mypluglib.so,mysql_plugin_test="$ROOT_DIR/lib/mysql/plugin",mysql_plugin_test="no")
    if test "$mysql_plugin_test" == "no"
    then
        unset mysql_plugin_test
        AC_CHECK_FILE($ROOT_DIR/lib/plugin/mypluglib.so,mysql_plugin_test="$ROOT_DIR/lib/plugin",mysql_plugin_test="no")
    fi
    AC_CHECK_PROG(mysql_bin_test,mysql,$ROOT_DIR/bin/,no,$ROOT_DIR/bin)
    if test "$mysql_plugin_test" != "no" && test "$mysql_bin_test" != "no"
    then
        AC_SUBST(MYSQL_INCLUDES,$mysql_include_test)
        AC_SUBST(MYSQL_PLUGINS,$mysql_plugin_test)
        AC_SUBST(MYSQL_COMMANDS,$mysql_bin_test)
        mysql_test="yes"
        AC_SUBST(MYSQL,yes)
        $2
    else
        mysql_test="no"
        AC_SUBST(MYSQL,no)
        $3
    fi
])

AC_DEFUN([AX_CHECK_MYSQL],[
    mysql_test="no"

    # Define variables
    MYSQL_PLUGIN_NEEDED=`echo $1 | grep -i -o "y"`
    MYSQL_REQUIRED=`echo $2 | grep -i -o "y"`
    MINIMUM_V="$3"
    INCLUDES_REQUIRED=`echo $4 | grep -i -o "y"`


    # Checks for common installation locations of MySQL

    echo "Testing if MySQL was installed to common source/binary directory"
    AC_CHECK_PROG(mysqlsource,mysql,yes,no,/usr/local/mysql/bin,)
    echo "Testing if MySQL was installed to common package manager directory"
    AC_CHECK_PROG(mysqlpackage,mysql,yes,no,/usr/bin,)

    # Checks whether the directories contains what they're supposed to, then produces an error otherwise.
    # In addition, will also generate an error if no installations exist, or two installations are detected.

    if test "$ac_cv_prog_mysqlsource" == "yes" && test "$ac_cv_prog_mysqlpackage" == "yes"
    then
        mysql_issue="Multiple MySQL installations found. Please specify the MySQL installation directory with --with-mysql"
    else if test "$ac_cv_prog_mysqlsource" == "yes"
    then
        AX_CHECK_MYSQL_INSTALL(/usr/local/mysql,mysql_issue="",mysql_issue="Although a source installation was detected the include or plugin directory could not be found. Please designate the root directory of the MySQl installation manually with --with-mysql")
    else if test "$ac_cv_prog_mysqlpackage" == "yes"
    then
        AX_CHECK_MYSQL_INSTALL(/usr/,mysql_issue="",mysql_issue="Although a package installation was detected the include or plugin directory could not be found. Please designate the root directory of the MySQL installation manually with --with-mysql")
    else
        mysql_issue="No default MySQL installs detected. Please specify the MySQL installation directory with --with-mysql"
    fi
    fi
    fi

    # Checks if --with-mysql flag was passed. If so, verifies that the directory follows assumed
    # structure and include,plugin, and bin directory is found. If there are no issues, this
    # will nullify any errors that would have been thrown by the above checking.
    if test "$with_mysql" != ""
    then
        AX_CHECK_MYSQL_INSTALL($with_mysql,mysql_issue="",mysql_issue="Structure of MySQL installation folder does not match a typical install. Please designate the include plugin bin and source directories manually with --with-mysql-plugin --with-mysql-include --with-mysql-bin")
    fi

    # Checks if specific MySQL directory flags were passed (--with-mysql-plugin, --with-mysql-include, --with-mysql-bin)
    # If so then checks if these variables are proper directories. If not, returns an error. Requires that all three directories must be defined.

    if test "$with_mysql_plugin" != "" || test "$with_mysql_include" != "" || test "$with_mysql_bin" != ""
    then
        mysql_test="yes"
        unset ac_cv_prog_mysql_bin_test
        unset ac_cv_prog_mysql_plugin_test
        if test "$with_mysql_plugin" == "" || test "$with_mysql_bin" == ""
        then
            mysql_test="no"
            if test "$MYSQL_REQUIRED" != ""
            then
                AC_MSG_ERROR([Argument is missing! When using --with-mysql-plugin --with-mysql-bin please enter arguments for each.])
            else
                AC_MSG_WARN([Argument is missing! When using --with-mysql-plugin --with-mysql-bin please enter arguments for each.])
            fi
        else

	    AC_CHECK_FILE($with_mysql_plugin/mypluglib.so,mysql_plugin_test="$with_mysql_plugin",mysql_plugin_test="no")
            if test "$mysql_plugin_test" == "no"
            then
                mysql_test="no"
                if test "$MYSQL_REQUIRED" != ""
                then
                    AC_MSG_ERROR([--with-mysql-plugin argument refers to a directory that is not a plugin directory. Please reenter the proper plugin directory.])
                else
                    AC_MSG_WARN([--with-mysql-plugin argument refers to a directory that is not a plugin directory. Please reenter the proper plugin directory.])
                fi
            fi

            AC_CHECK_HEADER($with_mysql_include/mysql_version.h,mysql_include_test="$with_mysql_include/",mysql_include_test="no")
            if test "$mysql_include_test" == "no" && test "$INCLUDES_REQUIRED" != ""
            then
                AC_MSG_ERROR([--with-mysql-include argument refers to a directory that is not a MySQL include directory. Please reenter the proper include directory for the MySQL installation.])
            fi

            AC_CHECK_PROG(mysql_bin_test,mysql,$with_mysql_bin,no,$with_mysql_bin)
            if test "$mysql_bin_test" == "no"
            then
                mysql_test="no"
                if test "$MYSQL_REQUIRED" != ""
                then
                    AC_MSG_ERROR([--with-mysql-bin argument refers to a directory that is not the executable directory. Please reenter the proper directory containing the MySQL executables.])
                else
                    AC_MSG_WARN([--with-mysql-bin argument refers to a directory that is not the executable directory. Please reenter the proper directory containing the MySQL executables.])
                fi
            fi
        fi

        AC_SUBST(MYSQL_INCLUDES,$mysql_include_test)
        AC_SUBST(MYSQL_PLUGINS,$mysql_plugin_test)
        AC_SUBST(MYSQL_COMMANDS,$mysql_bin_test)
        mysql_issue=""

    fi

    # If MySQL still can not find a valid installation, an error/warning message is thrown.
    AC_SUBST(MYSQL,$mysql_test)
    if test "$mysql_issue" != ""
    then
        if test "$MYSQL_REQUIRED" != ""
        then
            AC_MSG_ERROR([$mysql_issue])
        else
            AC_MSG_WARN([$mysql_issue])
        fi
    else

        # Test if INCLUDES-REQUIRED is yes, if so, checks for include directory and throws error if not correct
        if test "$INCLUDES_REQUIRED" != "" && test "$MYSQL_INCLUDES" == "no"
        then
            AC_MSG_ERROR([Include directory could not be found! MySQL development library may not be installed. If development library is installed please use --with-mysql-include --with-mysql-plugin --with-mysql-bin to manually assign directory locations.])
        fi
        # Check MySQL version, wether it's 32 or 64 bit, and modifies the architecture variable accordingly
        AC_MSG_CHECKING([MySQL Architecture])
        MYSQL_ARCHITECTURE='file '$MYSQL_COMMANDS'/mysql'
        MYSQL_ARCHITECTURE=`$MYSQL_ARCHITECTURE | grep -o ".*bit" | sed s/-bit//g | grep -o "[[0-9]][[0-9]]$"`
        AC_MSG_RESULT([$MYSQL_ARCHITECTURE])
        AC_SUBST(MYSQL_ARCHITECTURE,$MYSQL_ARCHITECTURE)

        # Checks MySQL binary version
        AC_MSG_CHECKING([MySQL Version])
        MYSQL_PREFIX=$MYSQL_COMMANDS'/mysqladmin -v'
        MYSQL_V=`$MYSQL_PREFIX | grep -o 'Distrib.*,' | sed s/Distrib\ //g | sed s/,//g`
        AC_MSG_RESULT([$MYSQL_V])

        # Checks whether MySQL version is greater than 5.1, the version needed for plugins
        AC_MSG_CHECKING([if MySQL install supports Plugins])
        MYSQL_MAJOR_V=`echo $MYSQL_V | cut -c 1`
        MYSQL_MINOR_V=`echo $MYSQL_V | cut -c 3`
        MYSQL_REV_V=`echo $MYSQL_V | cut -c 5-6`
        MYSQL_PLUGIN_MINOR_V=1
        MYSQL_PLUGIN_MAJOR_V=5
        if test "$MYSQL_MAJOR_V" -lt "$MYSQL_PLUGIN_MAJOR_V" || (test "$MYSQL_MAJOR_V" -eq "$MYSQL_PLUGIN_MAJOR_V" && test "$MYSQL_MINOR_V" -lt "$MYSQL_PLUGIN_MINOR_V")
        then
            AC_SUBST(MYSQL_PLUGIN_OK,no)
            AC_MSG_RESULT([no])
        else
            AC_SUBST(MYSQL_PLUGIN_OK,yes)
            AC_MSG_RESULT([yes])
        fi

        if test "$MYSQL_PLUGIN_NEEDED" != ""
        then
            if test "$MYSQL_PLUGIN_OK" == "no"
            then
                AC_MSG_ERROR([MySQL version is not able to support plugins! Please upgrade your version of MySQL before installing])
            fi
        fi

        # Checks wether MINIMUM-VERSION was passed, does error checking for the value, and checks for version
        if test "$MINIMUM_V" != ""
        then
            MINIMUM_MAJOR_V=`echo $MINIMUM_V | cut -c 1`
            MINIMUM_MINOR_V=`echo $MINIMUM_V | cut -c 3`
            MINIMUM_REV_V=`echo $MINIMUM_V | cut -c 5-6`
            CHECKER_MAJOR=`echo $MINIMUM_MAJOR_V | grep -o '[[0-9]]'`
            CHECKER_MINOR=`echo $MINIMUM_MINOR_V | grep -o '[[0-9]]'`
            CHECKER_REV=`echo $MINIMUM_REV_V | grep -o  '^[[0-9]]+'`
            if test "$CHECKER_MAJOR" != "" && test "$CHECKER_MINOR" != "" && test "$CHECKER_REV" == ""
            then
                    AC_MSG_CHECKING([if MySQL version is equal or greater than $MINIMUM_V])
                    if test "$MYSQL_MAJOR_V" -lt "$MINIMUM_MAJOR_V" || (test "$MYSQL_MAJOR_V" -eq "$MINIMUM_MAJOR_V" && test "$MYSQL_MINOR_V" -lt "$MINIMUM_MINOR_V") || (test "$MYSQL_MAJOR_V" -eq "$MINIMUM_MAJOR_V" && test "$MYSQL_MINOR_V" -eq "$MINIMUM_MINOR_V" && "$MYSQL_REV_V" -lt "MINIMUM_REV_V")
                    then
                        AC_SUBST(MYSQL_PLUGIN_OK,no)
                        AC_MSG_RESULT([no])
                        AC_MSG_ERROR([installed MySQL version is not above $MINIMUM_V. Please upgrade your version of MySQL])
                    else
                        AC_SUBST(MYSQL_PLUGIN_OK,yes)
                        AC_MSG_RESULT([yes])
                    fi
            else
                    AC_MSG_ERROR([MINIMUM-VERSION varable in AX_CHEC_MYSQL is not formatted properly. Please use X.X or X.X.XX])
            fi
        fi




        # Checks whether MySQL version is 5.5 or greater, the production release with major header/include changes from before
        if test "$MYSQL_MAJOR_V" -gt 4 && test "$MYSQL_MINOR_V" -gt 4
        then
            AC_SUBST(MYSQL_55,yes)
        else
            AC_SUBST(MYSQL_55,no)
        fi

    fi


])

AC_DEFUN([AX_SOURCE_MYSQL],[
    if test "$with_mysql_source" == ""
    then
       AC_MSG_ERROR(["Please Designate MySQL source path, using --with-mysql-source=YOUR_PATH"])
    else
       AC_SUBST(MYSQL_SOURCE,$with_mysql_source)
    fi
])
