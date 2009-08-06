#! /usr/bin/env perl
# rename-macro
# Rename an autoconf-archive macro, obsoleting the old name
# Usage: rename-macro OLD_PREFIX NEW_PREFIX FROM TO
#   If there is no prefix to remove, make the prefix some
#   string that does not occur in the files being modified.


use strict;
use warnings;

my ($old_prefix, $new_prefix, $old_file, $new_file) = @ARGV;

# Extract names from file names
my $old_name = $old_file;
$old_name =~ s/\..*$//;
my $uc_old_name = uc($old_name);
$old_name = lc($old_name);
my $new_name = $new_file;
$new_name =~ s/\..*$//;
my $uc_new_name = uc($new_name);
$new_name = lc($new_name);

# Read file
open IN, $old_file or die "could not read `$old_file'\n";
my $text = do { local $/, <IN> };

# Make new macro
my $new_text = $text;
$new_text =~ s/$old_name/$new_name/g; # Change name (lower case)
$new_text =~ s/$uc_old_name/uc($new_name)/ge; # Change name (upper case)
$new_text =~ s/$old_prefix/$new_prefix/g; # Change other references to prefix (upper case)
my $lc_old_prefix = lc($old_prefix);
$new_text =~ s/$lc_old_prefix/lc($new_prefix)/ge; # Change other references to prefix (lower case)
open OUTFILE, ">$new_file" or die "could not read `$new_file'";
print OUTFILE $new_text;
system "git add $new_file";

# Obsolete the old macro
my $insertion = <<END;
# OBSOLETE MACRO
#
#   Renamed to $uc_new_name
#
END
chomp $insertion;
my $old_text = $text;
$old_text =~ s/^\# SYNOPSIS/"$insertion\n\# SYNOPSIS"/me;
open OUTFILE, ">$old_file" or die "could not write `$old_file'";
print OUTFILE $old_text;
