#! /bin/sh

set -eu

if [ -x "gnulib/gnulib-tool" ]; then
  gnulibtool=gnulib/gnulib-tool
else
  gnulibtool=gnulib-tool
fi
$gnulibtool --m4-base build-aux --source-base build-aux --import git-version-gen gitlog-to-changelog gnupload maintainer-makefile announce-gen

echo TODO >AUTHORS

(cd m4 && ../build-aux/gitlog-to-changelog -- master >../ChangeLog)

autoreconf --install -Wall
