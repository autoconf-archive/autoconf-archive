#! /usr/bin/env perl
# -*- perl -*-

#
# git-authors-gen
#
# This program is based on gitlog-to-changelog by Jim Meyering
#

use strict;
use warnings;
use Getopt::Long;

(my $ME = $0) =~ s|.*/||;

my $BUGREPORT = 'autoconf-archive-maintainers@nongnu.org';

sub usage ($) {
    my ($exit_code) = @_;
    my $STREAM = ($exit_code == 0 ? *STDOUT : *STDERR);
    if ($exit_code != 0) {
	print $STREAM "Try `$ME --help' for more information.\n";
    } else {
	print $STREAM <<EOF;
Usage: $ME [OPTIONS]

Output git committers.

OPTIONS:

      --since=DATE    convert only the logs since DATE;
                      the default is to convert all log entries.
  -h, --help          display this help and exit

EXAMPLE:

  $ME --since=2008-01-02 > AUTHORS

Report bugs to <${BUGREPORT}>
EOF
    }
    exit($exit_code);
}

# If the string $S is a well-behaved file name, simply return it.
# If it contains white space, quotes, etc., quote it, and return the new string.
sub shell_quote($) {
    my ($s) = @_;
    if ($s =~ m![^\w+/.,-]!) {
	# Convert each single quote to '\''
	$s =~ s/\'/\'\\\'\'/g;
	# Then single quote the string.
	$s = "'$s'";
    }
    return $s;
}

sub quoted_cmd(@) {
    return join (' ', map {shell_quote $_} @_);
}

# Main
{
    my $since_date = '1970-01-01 UTC';
    GetOptions(
	'h|help'  => sub { usage 0 },
	'since=s' => \$since_date,
	) or usage 1;

    @ARGV
	and (warn "$ME: too many arguments\n"), usage 1;

    my @cmd = (qw (git shortlog --summary), "--since=$since_date");
    open PIPE, '-|', @cmd
	or die ("$ME: failed to run `". quoted_cmd (@cmd) ."': $!\n" .
		"(Is your Git too old?  Version 1.5.1 or later required.)\n");

    my %committers;

    while (<PIPE>) {
	my $line = $_;

	defined($line) or last;
	chomp($line);

	if ($line =~ /^\s*\d+\s+(.*)\s*$/) {
	    my $name = $1;

	    if (defined($committers{$name})) {
		die "$ME: Duplicated name found, fix your .mailmap";
	    }
	    $committers{$name} = 1;
	} else {
	    die "$ME: Unhandled line found ('$line')";
	}
    }

    close PIPE
	or die "$ME: error closing pipe from " . quoted_cmd (@cmd) . "\n";

    my @keys = sort(keys(%committers));
    foreach my $name (@keys) {
	print "$name\n";
    }
}
