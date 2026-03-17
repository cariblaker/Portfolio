#!/usr/bin/perl

use strict;
use warnings;

my $string = "This is a test.\n";

if ($string =~ /is/) {
    print $string;
}

my $bool = ($string =~ /is/);

$bool = $string =~ /is/;

$string =~ tr/a-z/A-Z/;

my $string1;

#eval "(\$string1 = \$string) =~ tr/A-Z/a-z/";

print $string;
#print $string1 = "test";

($string1 = $string) =~ tr/A-Z/a-z/;

print $string;
print $string1;

