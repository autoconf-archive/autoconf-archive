#! /usr/bin/env perl
# rename-macro
# Rename an autoconf-archive macro, obsoleting the old name
# Usage: rename-macro PREFIX FROM TO
#   If there is no prefix to remove, make the prefix some
#   string that does not occur in the files being modified.


use strict;
use warnings;

my ($prefix, $old, $new) = @ARGV;

my $old_name = uc($old);
$old_name =~ s/\..*$//;

my $new_name = uc($new);
$new_name =~ s/\..*$//;

my $insertion = <<END;
# OBSOLETE MACRO
#
#   Renamed to $new_name
#
END
chomp $insertion;

open IN, $old or die "could not read $old\n";
my $text = do { local $/, <IN> };

my $new_text = $text;
$new_text =~ s/$old_name/$new_name/g;
$new_text =~ s/$prefix/AX_/g;
open OUTFILE, ">$new" or die "could not read $new";
print OUTFILE $new_text;

my $old_text = $text;
$old_text =~ s/^\# SYNOPSIS/"$insertion\n\# SYNOPSIS"/me;
$old_text =~ s/^\# SYNOPSIS/"$insertion\n\# SYNOPSIS"/me;
open OUTFILE, ">$old" or die "could not write $old";
print OUTFILE $old_text;

system "git add $new";
