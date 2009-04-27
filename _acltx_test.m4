# ===========================================================================
#              http://autoconf-archive.cryp.to/_acltx_test.html
# ===========================================================================
#
# SYNOPSIS
#
#   _ACLTX_TEST(FILEDATA,VARIABLETOSET,[NOCLEAN])
#
# DESCRIPTION
#
#   This macros execute the latex application with FILEDATA as input and set
#   VARIABLETOSET the yes or no depending of the result if NOCLEAN is set,
#   the folder used for the test is not delete after testing.
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

AC_DEFUN([_ACLTX_TEST],[
AC_REQUIRE([ACLTX_PROG_LATEX])
rm -rf conftest.dir/.acltx
AS_MKDIR_P([conftest.dir/.acltx])
cd conftest.dir/.acltx
m4_ifval([$2],[$2="no"; export $2;])
cat > conftest.tex << ACLEOF
$1
ACLEOF
cat conftest.tex | $latex 2>&1 1>output m4_ifval([$2],[&& $2=yes])
cd ..
cd ..
sed 's/^/| /' conftest.dir/.acltx/conftest.tex >&5
echo "$as_me:$LINENO: executing cat conftest.tex | $latex" >&5
sed 's/^/| /' conftest.dir/.acltx/output >&5
m4_ifval([$3],,[rm -rf conftest.dir/.acltx])
])
