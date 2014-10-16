#! /bin/sh

set -eu

if [ "x$gnulibtool" = "x" ]; then
  if [ -x "gnulib/gnulib-tool" ]; then
    gnulibtool=gnulib/gnulib-tool
  else
    gnulibtool=gnulib-tool
  fi
fi

echo "Here is some information about your gnulib-tool:"
$gnulibtool --version

echo ""
echo "Re-importing gnulib stuff with gnulib-tool..."
# Try to keep these alphabetical:
gnulib_modules="announce-gen fdl-1.3 gendocs git-version-gen \
				gitlog-to-changelog gnu-make gnu-web-doc-update gnupload \
				maintainer-makefile update-copyright"

$gnulibtool --m4-base build-aux --source-base build-aux --import $gnulib_modules

echo ""
echo "Updating maint.mk..."

sed -i -e 's/^sc_file_system:/disabled_sc_file_system:/' \
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
  maint.mk

echo "Updating ChangeLog..."

echo > ChangeLog '# Copyright (c) 2014 Autoconf Archive Maintainers <autoconf-archive-maintainers@gnu.org>'
echo >>ChangeLog '#'
echo >>ChangeLog '# Copying and distribution of this file, with or without modification, are'
echo >>ChangeLog '# permitted in any medium without royalty provided the copyright notice and'
echo >>ChangeLog '# this notice are preserved. This file is offered as-is, without any warranty.'
echo >>ChangeLog ''
build-aux/gitlog-to-changelog >>ChangeLog -- m4/

echo "Updating AUTHORS..."
bash gen-authors.sh >AUTHORS

echo ""
echo "Your autoconf version is:"
autoconf --version

echo ""
echo "autoreconf-ing..."
autoreconf --force --verbose --install -Wall

echo ""
echo "Done bootstrapping."

# Local Variables:
# mode: shell-script
# End:
