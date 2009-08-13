#! /usr/bin/env perl
# alias-macro
# Alias an autoconf-archive macro
# Usage: alias-macro FROM TO

use strict;
use warnings;

my ($old_file, $new_file) = @ARGV;

# Extract names from file names
my $old_name = $old_file;
$old_name =~ s/\..*$//;
my $uc_old_name = uc($old_name);
$old_name = lc($old_name);
my $new_name = $new_file;
$new_name =~ s/\..*$//;
my $uc_new_name = uc($new_name);
$new_name = lc($new_name);

# Check old name exists
die "could not find `$old_file'\n" unless -e $old_file;

# Read new file
open IN, $new_file or die "could not read `$new_file'\n";
my $text = do { local $/, <IN> };

# Alias the macro
my $new_text = $text;
$new_text =~ s/^AC_DEFUN\(\[$uc_new_name/AU_ALIAS([$uc_old_name], [$uc_new_name])\nAC_DEFUN([$uc_new_name/m;
open OUTFILE, ">$new_file" or die "could not write `$new_file'";
print OUTFILE $new_text;
