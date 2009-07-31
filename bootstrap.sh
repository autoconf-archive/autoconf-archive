#! /bin/sh

set -eu

if [ -x "gnulib/gnulib-tool" ]; then
  gnulibtool=gnulib/gnulib-tool
else
  gnulibtool=gnulib-tool
fi
$gnulibtool --m4-base build-aux --source-base build-aux --import git-version-gen gitlog-to-changelog gnupload maintainer-makefile announce-gen

sed -i -e 's/^sc_file_system:/disabled_sc_file_system:/' maint.mk

echo TODO >AUTHORS

build-aux/gitlog-to-changelog -- master >ChangeLog

autoreconf --install -Wall
