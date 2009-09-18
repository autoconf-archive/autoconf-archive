#! /bin/sh

set -eu

if [ -x "gnulib/gnulib-tool" ]; then
  gnulibtool=gnulib/gnulib-tool
else
  gnulibtool=gnulib-tool
fi
$gnulibtool --m4-base build-aux --source-base build-aux --import git-version-gen gitlog-to-changelog gnupload maintainer-makefile announce-gen

sed -i -e 's/^sc_file_system:/disabled_sc_file_system:/' \
       -e 's/^sc_GPL_version:/disabled_sc_GPL_version:/' \
       -e 's/^sc_m4_quote_check:/disabled_sc_m4_quote_check:/' \
       -e 's/^sc_prohibit_strcmp:/disabled_sc_prohibit_strcmp:/' \
       -e 's/^sc_space_tab:/disabled_sc_space_tab:/' \
       -e 's/^sc_useless_cpp_parens:/disabled_sc_useless_cpp_parens:/' \
  maint.mk

echo TODO >AUTHORS

build-aux/gitlog-to-changelog -- master >ChangeLog

autoreconf --install -Wall

if [ ! -d html ]; then
  echo ""
  echo " Remember to check out the HTML tree before running configure."
  echo ""
fi
