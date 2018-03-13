#! /bin/sh

set -eu

if [ ! -d "gnulib" ] && [ $# -gt 0 ] && [ "$1" = "--copy" ]; then
  git clone git://git.savannah.gnu.org/gnulib.git gnulib
fi

if [ -x "gnulib/gnulib-tool" ]; then
  gnulibtool=gnulib/gnulib-tool
else
  gnulibtool=gnulib-tool
fi

gnulib_modules="git-version-gen gitlog-to-changelog gnupload
                maintainer-makefile announce-gen gendocs fdl-1.3"

$gnulibtool --m4-base build-aux --source-base build-aux --import $gnulib_modules

sed -e 's/^sc_file_system:/disabled_sc_file_system:/' \
    -e 's/^sc_GPL_version:/disabled_sc_GPL_version:/' \
    -e 's/^sc_m4_quote_check:/disabled_sc_m4_quote_check:/' \
    -e 's/^sc_prohibit_strcmp:/disabled_sc_prohibit_strcmp:/' \
    -e 's/^sc_space_tab:/disabled_sc_space_tab:/' \
    -e 's/^sc_useless_cpp_parens:/disabled_sc_useless_cpp_parens:/' \
    -e 's/^sc_prohibit_magic_number_exit:/disabled_sc_prohibit_magic_number_exit:/' \
    -e 's/^sc_copyright_check:/disabled_sc_copyright_check:/' \
    -e 's/^sc_error_message_uppercase:/disabled_sc_error_message_uppercase:/' \
    -e 's/^sc_prohibit_always-defined_macros:/disabled_sc_prohibit_always-defined_macros:/' \
    -e 's/^sc_prohibit_always_true_header_tests:/disabled_sc_prohibit_always_true_header_tests:/' \
    -e 's/^sc_prohibit_test_minus_ao:/disabled_sc_prohibit_test_minus_ao:/' \
    -e 's/^sc_prohibit_doubled_word:/disabled_sc_prohibit_doubled_word:/' \
  maint.mk > maint.mk.new
mv maint.mk.new maint.mk

echo > ChangeLog '# Copyright (c) 2018 Autoconf Archive Maintainers <autoconf-archive-maintainers@gnu.org>'
echo >>ChangeLog '#'
echo >>ChangeLog '# Copying and distribution of this file, with or without modification, are'
echo >>ChangeLog '# permitted in any medium without royalty provided the copyright notice and'
echo >>ChangeLog '# this notice are preserved. This file is offered as-is, without any warranty.'
echo >>ChangeLog ''
build-aux/gitlog-to-changelog >>ChangeLog -- m4/
bash gen-authors.sh >AUTHORS
install -c -m 444 README.md README

autoreconf --install -Wall
