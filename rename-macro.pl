#! /usr/bin/env perl
# rename-macro
# Rename an autoconf-archive macro, obsoleting the old name
# Usage: rename-macro PREFIX FROM TO
#   If there is no prefix to remove, make the prefix some
#   string that does not occur in the files being modified.


use strict;
use warnings;

my ($prefix, $old, $new) = @ARGV;

# Extract names from file names
my $old_name = $old;
$old_name =~ s/\..*$//;
my $new_name = $new;
$new_name =~ s/\..*$//;

# Read file
open IN, $old or die "could not read $old\n";
my $text = do { local $/, <IN> };

# Make new macro
my $new_text = $text;
$new_text =~ s/$old_name/$new_name/g; # Change name (lower case)
my $uc_old_name = uc($old_name);
$new_text =~ s/$uc_old_name/uc($new_name)/ge; # Change name (upper case)
$new_text =~ s/$prefix/AX_/g; # Change other references to prefix (upper case)
my $lc_prefix = lc($prefix);
$new_text =~ s/$lc_prefix/ax_/g; # Change other references to prefix (lower case)
open OUTFILE, ">$new" or die "could not read $new";
print OUTFILE $new_text;
system "git add $new";

# Obsolete the old macro
my $insertion = <<END;
# OBSOLETE MACRO
#
#   Renamed to $new_name
#
END
chomp $insertion;
my $old_text = $text;
$old_text =~ s/^\# SYNOPSIS/"$insertion\n\# SYNOPSIS"/me;
open OUTFILE, ">$old" or die "could not write $old";
print OUTFILE $old_text;
